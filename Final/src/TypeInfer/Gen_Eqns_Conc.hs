module TypeInfer.Gen_Eqns_Conc where

import TypeInfer.Gen_Eqns_Seq
import TypeInfer.Gen_Eqns_CommFuns
import TypeInfer.Gen_Eqns_Patt
import TypeInfer.MPL_AST

import TypeInfer.SymTab
import TypeInfer.SymTab_DataType 
import TypeInfer.SolveEqns

import Control.Monad.State.Lazy
import Text.PrettyPrint.GenericPretty
import Text.PrettyPrint
import Data.List 
import Control.Monad.Trans.Either
import Data.Maybe

genEquations_PComm :: ProcessCommand -> 
                      EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
                      ([TypeEqn],EndFlag)
genEquations_PComm  
        = foldPCommand fun_Run fun_Close fun_Halt fun_Get fun_Put fun_HPut
                       fun_HCase fun_Split fun_Fork fun_Plug fun_Id  
                       fun_PCase                    

genEquations_Proc :: [ProcessCommand] -> [TypeThing] ->
                     EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) [TypeEqn]
genEquations_Proc [] []
        = return []

genEquations_Proc (p:[]) (v:[]) = do 
        modify $ \(n,tt,c,chc,sym) -> (n,v,c,chc,sym)
        (newP,flag) <- genEquations_PComm p
        case flag == 0 of 
            True  -> 
                left $ getCommName p ++ " should not be the last command."
            False -> 
                return newP  

genEquations_Proc (p:ps) (v:vs) = do 
        modify $ \(n,tt,c,chc,sym) -> (n,v,c,chc,sym)
        (newP,flag)  <- genEquations_PComm p
        case flag == 0 of
            True  -> do 
                newPS <- genEquations_Proc ps vs 
                return (newP ++ newPS) 
            False -> do 
                left $ 
                  "Not expecting any commands after " 
                  ++ getCommName p
                   

foldPCommand :: ((Name,[Term],[PChannel],[PChannel],PosnPair) -> b) ->
                ((PChannel,PosnPair) -> b) -> 
                ((PChannel,PosnPair) -> b) ->
                ((Pattern,PChannel,PosnPair) -> b) ->
                ((Term,PChannel,PosnPair) -> b) ->
                ((Name,PChannel,PosnPair) -> b) ->
                ((PChannel,[(Name,Process,PosnPair)],PosnPair) -> b) ->
                ((PChannel,(PChannel,PChannel),PosnPair) -> b) ->
                ((String,[(String,Process)],PosnPair) -> b) ->
                (([PChannel],(Process,Process),PosnPair) -> b) ->
                ((PChannel,PChannel,PosnPair) -> b) ->
                ((Term,[PattProc],PosnPair) -> b) ->
                ProcessCommand -> b 

foldPCommand fRun fClose fHalt fGet fPut fHPut fHCase
             fSplit fFork fPlug fPid fPCase pcomms 
        = case pcomms of 
              PRun rargs -> 
                  fRun rargs
              PClose cargs -> 
                  fClose cargs 
              PHalt hargs ->
                  fHalt hargs
              PGet gargs ->
                  fGet gargs
              PPut putargs ->
                  fPut putargs
              PHPut hputargs ->
                  fHPut hputargs
              PHCase hcargs ->
                  fHCase hcargs
              PSplit spargs ->
                  fSplit spargs
              PFork fargs ->
                  fFork fargs
              PPlug  plist ->
                  fPlug plist
              PId idargs ->   
                  fPid idargs  
              PCase pattProcs ->
                  fPCase pattProcs                       
       
-- ==========================================================================
-- ==========================================================================    


fun_Close :: (PChannel,PosnPair) ->
             EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
             ([TypeEqn],EndFlag)
fun_Close (ch,pn) = do 
    (num,closProt,_,chCont,symTab) <- get
    -- look up this channel in the chCont and remove it from there
    case lookup ch chCont of
        Nothing -> do 
          left 
            $ "Trying to close a channel that doesn't exist. <<"
             ++ ch ++ ">>" ++ printPosn pn 

        Just pair@(pol,prot) -> do 
            let 
              delChCon = delete (ch,pair) chCont
              teqn     = TSimp  (prot,TopBot pn)
            modify $ \(n,tt,c,chC,sym) -> (n,tt,c,delChCon,sym)
            return ([teqn],0)  


-- ======================================================================
-- ======================================================================

fun_Halt :: (PChannel,PosnPair) ->
            EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
             ([TypeEqn],EndFlag)
fun_Halt (ch,pn) = do 
    (_,_,_,chCont,symTab) <- get
    -- look up this channel in the chCont and remove it from there
    case lookup ch chCont of
        Nothing -> do 
            left 
              $ "Trying to Halt a channel that doesn't exist. <<"
                ++ ch ++ ">>" ++ printPosn pn 

        Just pair@(pol,prot) -> do 
            case length chCont == 1 of 
                True -> do 
                  let 
                    delChCon = delete (ch,pair) chCont
                    teqn     = TSimp  (prot,TopBot pn)
                  modify $ \(n,tt,c,chC,sym) -> (n,tt,c,delChCon,sym)
                  return ([teqn],1) 

                False -> 
                    left $
                      "Only the last channel can be halted.\n" ++
                      "Trying to halt channel <<" ++
                       ch ++ printPosn pn ++
                      ">> before closing all but one channel."   


-- ======================================================================
-- ======================================================================

fun_Get :: (Pattern,PChannel,PosnPair) ->
           EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
                            ([TypeEqn],EndFlag)
fun_Get (patt,ch,pn) = do 
    pattVar <- genNewVar    
    pattEqns <- genPattEquationsList [patt] [pattVar]
    (_,protGet,_,chCont,symTab) <- get 
    case lookup ch chCont of 
      Nothing -> 
        left $ 
          "Trying to GET on a channel <<" ++ ch 
          ++ ">>" ++ printPosn pn ++ "that doesn't exist." 
      Just pair -> do 
        let 
          delChCon = delete (ch,pair) chCont
        handle_Get pair (ch,pn) delChCon (pattVar,protGet) pattEqns

-- ======================================================================


handle_Get :: (Polarity,Type) -> (PChannel,PosnPair) ->
              ChanContext -> (TypeThing,TypeThing) -> [TypeEqn] ->
              EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
               ([TypeEqn],EndFlag)

handle_Get (pol,prot) (ch,pn) delChCon (vPatt,protGet) pEqns = do 
    case pol of 
        Out -> do 
            let 
              varGet = TypeVarInt protGet
              pchan  = Get (TypeVarInt vPatt,varGet,pn)
              teqn   = TSimp (prot,pchan)
              finEqn = TQuant ([],[vPatt,protGet])
                              (pEqns ++ [teqn])  
              newCont= (ch,(Out,varGet)):delChCon
            modify $ \(n,tt,c,chC,sym) -> (n,tt,c,newCont,sym)
            return ([finEqn],0)  

        In  -> do 
            let 
              varGet = TypeVarInt protGet
              pchan  = Put (TypeVarInt vPatt,varGet,pn)
              teqn   = TSimp (prot,pchan)
              finEqn = TQuant ([],[vPatt,protGet])
                              (pEqns ++ [teqn])  
              newCont= (ch,(In,varGet)):delChCon
            modify $ \(n,tt,c,chC,sym) -> (n,tt,c,newCont,sym)
            return ([finEqn],0)  

-- ======================================================================
-- ======================================================================


fun_Put :: (Term,PChannel,PosnPair) ->
           EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
                            ([TypeEqn],EndFlag)
fun_Put (term,ch,pn) = do 
    termVar  <- genNewVar
    termEqns <- genEquationsList [term] [termVar]
    (_,protPut,_,chCont,symTab) <- get 
    case lookup ch chCont of 
      Nothing -> 
        left $ 
          "Trying to PUT on a channel <<" ++ ch 
          ++ ">>" ++ printPosn pn ++ "that doesn't exist." 
      Just pair -> do 
        let 
            delChCon = delete (ch,pair) chCont
        handle_Put pair (ch,pn) delChCon (termVar,protPut) termEqns

-- ======================================================================

handle_Put :: (Polarity,Type) -> (PChannel,PosnPair) ->
              ChanContext -> (TypeThing,TypeThing) -> [TypeEqn] ->
              EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
               ([TypeEqn],EndFlag)

handle_Put (pol,prot) (ch,pn) delChCon (tVar,protPut) pEqns = do 
    case pol of 
        Out -> do 
            let 
              putVar = TypeVarInt protPut 
              pchan  = Put (TypeVarInt tVar,putVar,pn)
              teqn   = TSimp (prot,pchan)
              finEqn = TQuant ([],[tVar,protPut])
                              (pEqns ++ [teqn])
              newCont= (ch,(Out,putVar)):delChCon
            modify $ \(n,tt,c,chC,sym) -> (n,tt,c,newCont,sym)
            return ([finEqn],0)  

        In  -> do 
            let 
              putVar = TypeVarInt protPut 
              pchan  = Get (TypeVarInt tVar,putVar,pn)
              teqn   = TSimp (prot,pchan)
              finEqn = TQuant ([],[tVar,protPut])
                              (pEqns ++ [teqn])
              newCont= (ch,(In,putVar)):delChCon
            modify $ \(n,tt,c,chC,sym) -> (n,tt,c,newCont,sym)
            return ([finEqn],0)  


-- ======================================================================
-- ======================================================================


fun_HPut :: (Name,PChannel,PosnPair) ->
           EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
                            ([TypeEqn],EndFlag)
fun_HPut (handle,ch,pn) = do 
    (num,typeHPut,_,chCont,symTab) <- get
    -- check if the channel is in the context
    case lookup ch chCont of        
        Nothing -> do 
            let 
              emsg = "Trying to hput a value on an unknown channel <<" 
                      ++ ch ++ ">> " ++ printPosn pn   
            left emsg   

        Just pair@(pol,prot) -> do 
            let 
              delChCon = delete (ch,pair) chCont
            case pol of 
                Out -> do 
                    let 
                      lookVal = Val_Prot (handle,pn)
                    case lookup_ST lookVal symTab of 
                        Left stEmsg ->
                            left stEmsg
                        Right stRetVal -> do
                            let 
                              ValRet_Prot (rPNm,rPt) 
                                     = stRetVal
                            intFType <- renameFunType rPt          
                            let 
                              (univVars,itypes,otype,_)
                                     = stripFunType rPt pn 0
                              teqn1  = TSimp (prot,otype)
                              teqn2  = TSimp (TypeVarInt typeHPut,head itypes) 
                              finEqn = TQuant ([],typeHPut:univVars) [teqn1,teqn2] 
                              newCont= (ch,(Out,TypeVarInt typeHPut)):delChCon

                            modify $ \(n,tt,c,chC,sym) -> (n,tt,c,newCont,sym)
                            return ([finEqn],0)                                                       

                In  -> do   
                    let 
                      lookVal = Val_Coprot (handle,pn)
                    case lookup_ST lookVal symTab of 
                        Left stEmsg ->
                            left stEmsg
                        Right stRetVal -> do
                            let 
                              ValRet_Coprot (rPNm,rPt) 
                                    = stRetVal
                            intFType <- renameFunType rPt 
                            let
                              (univVars,itypes,otype,_)
                                     = stripFunType rPt pn 0
                              teqn1  = TSimp (prot, otype)
                              teqn2  = TSimp(TypeVarInt typeHPut,head itypes) 
                              finEqn = TQuant ([],typeHPut:univVars) [teqn1,teqn2] 
                              newCont= (ch,(In,TypeVarInt typeHPut)):delChCon
                              
                            modify $ \(n,tt,c,chC,sym) -> (n,tt,c,newCont,sym)
                            return ([finEqn],0)   

-- ======================================================================
-- ======================================================================

fun_HCase ::(PChannel,[(Name,Process,PosnPair)],PosnPair) ->  
            EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
                ([TypeEqn],EndFlag) 
fun_HCase (ch,tripList,pn) = do 
    (num,typeHCase,_,chCont,symTab) <- get
    -- check if the channel is in the context
    case lookup ch chCont of        
        Nothing -> do 
            let 
              emsg = "Trying to hcase on an unknown channel <<" 
                      ++ ch ++ ">> " ++ printPosn pn   
            left emsg   

        Just pair@(pol,prot) -> do 
            let 
              delChCon = delete (ch,pair) chCont
              newCont  = (ch,(pol,TypeVarInt typeHCase)):delChCon
            retEqns <- handle_Hcase tripList (ch,pol,prot) (newCont,typeHCase)
            modify $ \(n,tt,c,chC,sym) -> (n,tt,c,newCont,sym)
            return (retEqns,1)

              

handle_Hcase :: [(Name,Process,PosnPair)] -> (PChannel,Polarity,Type) ->
                (ChanContext,ExistVar) -> 
                EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
                  [TypeEqn]     
handle_Hcase [] _ _ 
    = return []

handle_Hcase ((handle,procs,pn):rs) (ch,pol,prot) (chanCont,hcase) = do 
    (_,_,_,_,symTab) <- get
    case pol of 
        In -> do
            let 
              lookVal = Val_Prot (handle,pn)
            case lookup_ST lookVal symTab of 
                Left stEmsg ->
                    left stEmsg
                Right stRetVal -> do
                    newVars  <- genNewVarList (length procs)
                    eqnProcs <- genEquations_Proc procs newVars
                    let 
                      ValRet_Prot (rPNm,rPt) 
                             = stRetVal  
                    intFType <- renameFunType rPt 
                    let
                      (univVars,itypes,otype,_)
                             = stripFunType rPt pn 0
                      fEqn   = TSimp (prot,otype)
                      sEqn   = TSimp (TypeVarInt hcase,head itypes)
                      finEqn = (fEqn:sEqn:eqnProcs) 

                    modify $ \(n,tt,c,chC,sym) -> 
                              (n,hcase,c,chanCont,sym)                   
                    rsEqns <- handle_Hcase rs (ch,pol,prot) 
                                              (chanCont,hcase)  
                    let 
                      retEqn = TQuant ([],[hcase]) (finEqn ++ rsEqns) 
                    return [retEqn]  

        Out  -> do 
            let 
              lookVal = Val_Coprot (handle,pn)
            case lookup_ST lookVal symTab of 
                Left stEmsg ->
                    left stEmsg
                Right stRetVal -> do
                    newVars  <- genNewVarList (length procs)
                    eqnProcs <- genEquations_Proc procs newVars
                    let 
                      ValRet_Coprot (rPNm,rPt) 
                             = stRetVal

                    intFType <- renameFunType rPt 

                    let
                      (univVars,itypes,otype,_)
                             = stripFunType rPt pn 0
                      fEqn   = TSimp (prot,otype)
                      sEqn   = TSimp (TypeVarInt hcase,head itypes)
                      finEqn = (fEqn:sEqn:eqnProcs) 

                    modify $ \(n,tt,c,chC,sym) -> 
                              (n,hcase,c,chanCont,sym)                   
                    rsEqns <- handle_Hcase rs (ch,pol,prot) 
                                              (chanCont,hcase)    
                    let 
                      retEqn = TQuant ([],[hcase]) (finEqn ++ rsEqns) 
                    return [retEqn]


-- =========================================================================
-- =========================================================================


fun_Run :: (Name,[Term],[PChannel],[PChannel],PosnPair) ->  
           EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
                   ([TypeEqn],EndFlag)

fun_Run (name,terms,ichs,ochs,pn) = do 
    let 
      lterms= length terms 
      lins  = length ichs 
      louts = length ochs 
      lTrip = (lterms,lins,louts)
    termVars <- genNewVarList lterms  
    termEqns <- genEquationsList terms termVars        
    (_,typeRun,_,chCont,symTab) <- get
    let 
      lookVal = Val_Proc (name,pn) 
    case lookup_ST lookVal symTab of 
      Left emsg -> 
        left emsg  
      Right retVal -> do
        let 
          ValRet_Proc (procType,argsTrip) 
                 = retVal
        case printProcError argsTrip lTrip of 
            Right _  -> do
               let 
                 (uvars,seqTypes,iProts,oProts,procPn)
                         = stripProcProt procType
                 seqEqns = zipWith (\x y -> TSimp (TypeVarInt x,y)) termVars seqTypes   
               case genEqnsPRun (ichs,iProts,In) (chCont,name,pn) of 
                   Left emsg ->
                       left emsg
                   Right inEqns -> 
                       case genEqnsPRun (ochs,oProts,Out) (chCont,name,pn) of  
                           Left emsg -> 
                               left emsg
                           Right outEqns -> do 
                               let 
                                 finEqns = TQuant ([],termVars)
                                              (seqEqns++inEqns++outEqns)
                               return ([finEqns],1)
                                

            Left argEmsg -> do 
               let 
                 emsg = "Process <<" ++ name ++
                         ">> called with incorrect number of arguments" ++
                         printPosn pn 
               left $ concat [emsg,"\n",argEmsg]

genEqnsPRun :: ([PChannel],[Type],Polarity) -> (ChanContext,Name,PosnPair) ->
               Either ErrorMsg [TypeEqn]
genEqnsPRun ([],[],_) _ 
    = return []

genEqnsPRun (ch:rch,prot:rProt,chpol) otrip@(chContext,name,pn)  
    = case lookup ch chContext of 
          Nothing -> do
              let 
                emsg = "Calling process <<" ++ name ++ 
                        ">> with nonexistent channel <<" ++ ch 
                         ++ printPosn pn ++ ">>."
              Left emsg 
          Just (pol,ctype) -> do 
              case chpol == pol of 
                  True  -> do 
                      let 
                        currEqn = TSimp (ctype,prot) 
                      remEqns <- genEqnsPRun (rch,rProt,chpol) otrip
                      return $ currEqn:remEqns

                  False -> do 
                      let 
                        emsg = "Calling process <<" ++ name ++ 
                                ">> using wrong polarity of the channel <<" ++ ch 
                                 ++ printPosn pn ++ ">>.\nExpecting <<" ++ show chpol
                                 ++ ">> instead got <<" ++ show pol ++ ">>."
                      Left emsg 

                  


printProcError :: (Int,Int,Int) -> (Int,Int,Int) -> Either ErrorMsg Bool
printProcError (ns,ni,no) (lt,li,lo)
    = case (ns == lt,ni == li,no == lo) of 
          (True,True,True) -> 
              return True
          (False,_,_) -> 
              Left $
                "Sequential Arguments : Expecting <<" ++ show ns ++ 
                ">>  instead got <<" ++ show lt ++ ">>."    

          (_,False,_) ->
              Left $
                "Concurrent Arguments (Input) : Expecting <<" ++ show ni ++ 
                ">> channels  instead got <<" ++ show lt ++ ">> channels."

          (_,_,False) ->                   
              Left $
                "Concurrent Arguments (Input) : Expecting <<" ++ show no ++ 
                ">> channels  instead got <<" ++ show lo ++ ">> channels."

-- =========================================================================
-- =========================================================================

fun_PCase ::(Term,[PattProc],PosnPair) ->   
            EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
                   ([TypeEqn],EndFlag)
fun_PCase (term,pattProcs,pn) = do
    (_,protPCase,cont,chCont,symTab) <- get
    termVar      <- genNewVar 
    termEqns     <- genEquationsList [term] [termVar]
    pattProcEqns <- genPCaseEquations pattProcs (termVar,protPCase)
    let 
      finEqn = TQuant ([],[termVar]) (pattProcEqns++termEqns)
    modify $ \(n,tt,c,chC,sym) -> (n,tt,cont,chC,sym)  
    return $ ([finEqn],1)

genPCaseEquations :: [PattProc] -> (TypeThing,TypeThing) -> 
                     EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
                         [TypeEqn]
genPCaseEquations [] _ 
    = return []
genPCaseEquations ((patt,proc):ps) (termVar,protPCase) = do 
    (_,protPCase,cont,chCont,symTab) <- get
    pattEqns <- genPattEquationsList [patt] [termVar]
    varProcs <- genNewVarList (length proc)
    procEqns <- genEquations_Proc proc varProcs 
    modify $ \(n,tt,c,chC,sym) -> (n,protPCase,cont,chCont,sym)     
    psEqns   <- genPCaseEquations ps (termVar,protPCase)
    return $ pattEqns ++ procEqns ++ psEqns


-- ============================================================================
-- ============================================================================

fun_Split :: (PChannel,(PChannel,PChannel),PosnPair) ->
           EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
             ([TypeEqn],EndFlag)
fun_Split (ch,(ch1,ch2),pn) = do 
    (num,tSplit,_,chCont,symTab) <- get
    [tCh1,tCh2] <- genNewVarList 2
    -- check if the channel is in the context
    case (lookup ch chCont) of        
        Nothing -> do 
            let 
              emsg = "Trying to hput a value on an unknown channel <<" 
                      ++ ch ++ ">> " ++ printPosn pn   
            left emsg   

        Just pair@(pol,prot) -> do 
            let 
              delChCon = delete (ch,pair) chCont
              tvar1    = TypeVarInt tCh1
              tvar2    = TypeVarInt tCh2
              (simpEqn,newCont)
                       = helper_Split (pol,prot,pn) (ch1,tvar1) 
                                      (ch2,tvar2) delChCon
              finEqn   = TQuant ([],[tCh1,tCh2]) [simpEqn]
                                   
            modify $ \(n,tt,c,chC,sym) -> (n,tt,c,newCont,sym)  
            return ([finEqn],0)

helper_Split :: (Polarity,Type,PosnPair) -> (PChannel,Type) -> (PChannel,Type) 
                -> ChanContext -> (TypeEqn,ChanContext)
helper_Split (pol,prot,pn) (ch1,tvar1) (ch2,tvar2)  delChCon = 
    case pol of 
        Out -> (simpEqn,newCont) 
           where 
             con1    = (ch1,(Out,tvar1))
             con2    = (ch2,(Out,tvar2))
             newCont = con1:con2: delChCon
             parProt = ProtPar (tvar1,tvar2,pn) 
             simpEqn = TSimp (prot,parProt)

        In  -> (simpEqn,newCont)               
           where 
             con1    = (ch1,(In,tvar1))
             con2    = (ch2,(In,tvar2))
             newCont = con1:con2: delChCon
             tensProt= ProtTensor (tvar1,tvar2,pn)                    
             simpEqn = TSimp (prot,tensProt)
-- ============================================================================
-- ============================================================================

fun_Fork :: (String,[(PChannel,Process)],PosnPair) -> 
            EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
              ([TypeEqn],EndFlag)
fun_Fork (ch,chProcList,pn) = do             
    (num,tSplit,_,chCont,symTab) <- get
    -- check if the channel is in the context
    case (lookup ch chCont) of        
        Nothing -> do 
            let 
              emsg = "Trying to fork on an unknown channel <<" 
                      ++ ch ++ ">> " ++ printPosn pn   
            left emsg   

        Just pair@(pol,prot) -> do 
            let 
              delChCon = delete (ch,pair) chCont
            help_Fork (chProcList!!0) (chProcList!!1)
                      (pol,prot,pn) delChCon


help_Fork :: (PChannel,Process)  -> (PChannel,Process) -> 
             (Polarity,Type,PosnPair) -> ChanContext -> 
             EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
               ([TypeEqn],EndFlag)            
help_Fork (ch1,proc1) (ch2,proc2) (pol,prot,pn) delChCon = do 
    (num,_,context,chanCont,symTab) <- get
    [var1,var2] <- genNewVarList 2 
    proc1Vars <- genNewVarList (length proc1)
    proc2Vars <- genNewVarList (length proc2)
    let 
      type1  = TypeVarInt var1
      type2  = TypeVarInt var2 
    case pol of 
        Out -> do 
            let 
              ch1con = (ch1,(Out,type1)) 
              con1   = ch1con:delChCon
            modify $ \(n,tt,c,chC,sym) -> (n,tt,c,con1,sym)
            proc1Eqns <- genEquations_Proc proc1 proc1Vars
            (_,_,_,chanCont1,_) <- get 
            let 
              delCon1 = delete ch1con chanCont1
              ch2con  = (ch2,(Out,type2))
              con2    = ch2con:delCon1
            modify $ \(n,tt,c,chC,sym) -> (n,tt,context,con2,sym)
            proc2Eqns <- genEquations_Proc proc2 proc2Vars
            let 
              tensProt = ProtTensor (type1,type2,pn)
              simpEqn  = TSimp (prot,tensProt)
              finEqn   = TQuant ([],[var1,var2]) [simpEqn]
            return ([finEqn],1)

        In  -> do     
            let 
              ch1con = (ch1,(In,type1)) 
              con1   = ch1con:delChCon
            modify $ \(n,tt,c,chC,sym) -> (n,tt,c,con1,sym)
            proc1Eqns <- genEquations_Proc proc1 proc1Vars
            (_,_,_,chanCont1,_) <- get 
            let 
              delCon1 = delete ch1con chanCont1
              ch2con  = (ch2,(In,type2))
              con2    = ch2con:delCon1
            modify $ \(n,tt,c,chC,sym) -> (n,tt,context,con2,sym)
            proc2Eqns <- genEquations_Proc proc2  proc2Vars
            let 
              tensProt = ProtPar (type1,type2,pn)
              simpEqn  = TSimp (prot,tensProt)
              finEqn   = TQuant ([],[var1,var2]) [simpEqn]
            return ([finEqn],1)


-- ============================================================================
-- ============================================================================

fun_Plug :: ([PChannel],(Process,Process),PosnPair) -> 
             EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
               ([TypeEqn],EndFlag) 
fun_Plug (chs,(proc1,proc2),pn) = do 
    (num,_,context,chanCont,symTab) <- get
    newVars   <- genNewVarList (length chs) 
    proc1Vars <- genNewVarList (length proc1)
    proc2Vars <- genNewVarList (length proc2)
    let 
      typeVars   = map TypeVarInt newVars
      incOutCont = zipWith (\c t -> (c,(Out,t))) chs typeVars 
      incInCont  = zipWith (\c t -> (c,(In,t))) chs typeVars
      -- context for proc1
      procCon1   = incOutCont ++ chanCont
      -- context for proc2
      procCon2   = incInCont ++ chanCont 
    case newVars == [] of 
        True  -> do 
            p1Eqns <- genEquations_Proc proc1 proc1Vars
            modify $ \(n,tt,c,chC,sym) -> (n,tt,context,chanCont,sym)
            p2Eqns <- genEquations_Proc proc2 proc2Vars
            return (p1Eqns ++ p2Eqns,1)

        False -> do 
            modify $ \(n,tt,c,chC,sym) -> (n,tt,context,procCon1,sym)
            p1Eqns <- genEquations_Proc proc1 proc1Vars
            modify $ \(n,tt,c,chC,sym) -> (n,tt,context,procCon2,sym)
            p2Eqns <- genEquations_Proc proc2 proc2Vars
            let 
              finEqn = TQuant ([],newVars) (p1Eqns ++ p2Eqns)
            return ([finEqn],1)


-- ============================================================================
-- ============================================================================ 

fun_Id :: (PChannel,PChannel,PosnPair) -> 
          EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable)) 
               ([TypeEqn],EndFlag) 
fun_Id (chl,chr,pn) = undefined 