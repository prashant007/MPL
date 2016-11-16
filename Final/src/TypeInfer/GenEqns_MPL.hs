module TypeInfer.GenEqns_MPL where 

import TypeInfer.Gen_Eqns_Helper_Patt
import TypeInfer.MPL_AST
import TypeInfer.EqGenCommFuns
import TypeInfer.SymTab
import TypeInfer.SymTabDataType 
import TypeInfer.SolveEqns

import Control.Monad.State.Lazy
import Text.PrettyPrint.GenericPretty
import Text.PrettyPrint
import Data.List 
import Control.Monad.Trans.Either
import Data.Maybe



-- =========================================================================================
-- =========================================================================================  

genEquations :: Term -> EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
genEquations term = foldTerm 
                        fun_Record fun_CallFun fun_Let fun_Var fun_Const 
                        fun_If fun_Case fun_Fold fun_Unfold fun_Cons
                        fun_Dest fun_Prod fun_Default term 

-- here the thing to note is that context is not restored once the equation has been generated
-- for the first element. Keep in mind that context  needs to be restored in genEquation itself.
genEquationsList :: [Term] -> [TypeThing] -> 
                    EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
genEquationsList [] [] 
        = return []
genEquationsList (t:ts) (nvar:rest) = do
        (_,_,context,_) <- get 
        modify $ \(n,v,c,st) -> (n,nvar,c,st)
        eqns <- genEquations t  
        eqnsList <- genEquationsList ts rest 
        return (eqns++eqnsList)   

genEquationsList a b = error $ "The error is :" ++ show a ++ "\n" ++ show b
-- =========================================================================================
-- =========================================================================================  

foldTerm :: ([(Pattern,Term,PosnPair)] -> b) ->
            ((FuncName,[Term],PosnPair) -> b) -> 
            ((Term,[LetWhere],PosnPair) -> b) ->
            ((String,PosnPair) -> b) ->
            ((BaseVal,PosnPair) -> b) ->
            ((Term,Term,Term,PosnPair) -> b) ->
            ((Term,[PatternTermPhr],PosnPair) -> b) ->
            ((Term,[FoldPattern],PosnPair) -> b) ->
            ((Term,FoldPattern,PosnPair) -> b) ->
            ((Name,[Term],PosnPair) -> b) ->
            ((Name,[Term],PosnPair) -> b) ->
            (([Term],PosnPair) -> b) ->
            (PosnPair -> b) ->
            Term -> b 

foldTerm frecord fcallFun flet fvar fconst fif fcase
         ffold f_unfold fCons fdest fProd fDef 
         t  
    = case t of 
         TRecord reclist -> 
             frecord reclist                

         TCallFun(fname,terms,posn) ->  
             fcallFun (fname,terms,posn)

         TLet(term,letwhrs,posn) ->
             flet (term,letwhrs,posn)

         TVar(str,posn) ->   
             fvar (str,posn)

         TConst(bval,posn) ->
             fconst (bval,posn)

         TIf(term1,term2,term3,posn) ->
             fif (term1,term2,term3,posn)

         TCase(term,pattTermphrs,posn) ->
             fcase (term,pattTermphrs,posn) 
             
         TFold(term,foldPatt,posn) ->
             ffold (term,foldPatt,posn)

         TUnfold(term,foldPatt,posn) ->
             f_unfold (term,foldPatt,posn)

         TCons(name,terms,posn) ->
            fCons (name,terms,posn)
        
         TDest(name,terms,posn) ->
            fdest (name,terms,posn) 

         TProd(terms,posn) ->
            fProd (terms,posn) 

         TDefault posn ->
            fDef posn 

-- =========================================================================================
-- =========================================================================================  

fun_Record :: [(Pattern,Term,PosnPair)] ->
              EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_Record reclist = do                
        (_,typeRecord,context,symTab) <- get 
        let 
          (destName,dposn)
                  = (fsttrdTriple.head) reclist 
          allNamesPosn
                  = map fsttrdTriple reclist
          eithVal = lookup_ST (Val_Dest (destName,dposn)) symTab           
        case eithVal of 
            Right retVal -> do 
                let 
                  ValRet_Dest ((cdatName,allDests),ftype,nargs)
                             = retVal 
                  eithRecord = checkRecords allNamesPosn allDests cdatName         
                case eithRecord of 
                    Left emsgR ->
                        left emsgR
                    Right true -> do 
                        handleListRec reclist
            
            Left emsg ->
                left emsg     

-- first check if there are any extra destructors
-- then check if all the destructors are used
checkRecords :: [(Name,PosnPair)] -> [Name] -> DataName ->  Either ErrorMsg Bool 
checkRecords recDestsPn codDests codata = do 
        let
          recDests    = map fst recDestsPn  
          absentDests = codDests \\ recDests
          dupDests    = recDests \\ (nub recDests)
          extraDests  = recDests \\ codDests
        case extraDests == [] of 
            True  -> do 
                case absentDests == [] of
                    True  ->   
                        case dupDests == [] of 
                            True  ->
                                return True
                            False -> do 
                                let 
                                  dupDestsPosn
                                       = filter (\(x,p) -> elem x dupDests) recDestsPn
                                  emsg = "Following destructors have been used more than once in" ++
                                         "a record of Codata <<" 
                                          ++ show codata ++ ">>.\n" ++ 
                                          (intercalate "\n" (map printConsDest dupDestsPosn))
                                Left emsg 

                    False -> do 
                        let 
                          absDestPosn
                               = filter (\(x,p) -> elem x absentDests) recDestsPn
                          emsg = "Following destructors missing for Codata <<" 
                                 ++ show codata ++ ">>.\n" ++ 
                                 (intercalate "\n" (map printConsDest absDestPosn))
                        Left emsg                           
            False -> do 
                let 
                  extDestPosn
                       = filter (\(x,p) -> elem x extraDests) recDestsPn
                  emsg = "Extraneous destructors found.Following destructors don't belong to Codata <<" 
                         ++ show codata ++ ">>.\n" ++
                          (intercalate "\n" (map printConsDest extDestPosn))
                Left emsg          


printConsDest :: (Name,PosnPair) -> String
printConsDest (name,posn) = show name ++ "(" ++ printPosn posn ++ ")"                  

fsttrdTriple :: (Pattern,Term,PosnPair) -> (Name,PosnPair)
fsttrdTriple (x,y,z) = (getNameFromPatt x,z)


getNameFromPatt :: Pattern -> Name 
getNameFromPatt patt 
        = case patt of 
              DestPattern (str,_,_) -> 
                  str 
              ConsPattern (str,_,_) ->
                  str 
              otherwise ->
                   error $ "Expecting a constructor or destructor pattern." 



handleListRec :: [(Pattern,Term,PosnPair)] -> 
                 EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
handleListRec []
        = return []

handleListRec (r:rs) = do 
        (_,typeRecord,context,symTab) <- get 
        newR  <- handleRec r 
        newRS <- handleListRec rs 
        let 
          combEqns = combineEqns (newR ++ newRS)
        modify $ \(n,v,c,st) -> (n,typeRecord,context,st)
        return combEqns



handleRec :: (Pattern,Term,PosnPair) -> 
             EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
handleRec (pattern,term,posn) = do 
        (_,typeRecord,context,symTab) <- get 
        typeDest <- genNewVar
        pattEqn  <- genPattEquationsList [pattern] [typeDest]
        typeTerm <- genNewVar
        -- in the changed context evaluate the term
        termEqns <- genEquationsList [term] [typeTerm]
        let 
           (uvars,evars,typeEqns) 
                 = removeQuant (head pattEqn)
           TypeFun (ins,out,tposn)
                 = (snd.removeSimp.head) typeEqns
           remEqns
                 = tail typeEqns
           recType
                 = last ins 
           recEqn 
                 = TSimp (TypeVarInt typeRecord,recType)
           outEqn= TSimp (TypeVarInt typeTerm,out) 
           finEqn= TQuant (uvars,typeTerm:evars)
                          (recEqn:outEqn:(remEqns ++ termEqns))       
        modify $ \(n,v,c,st) -> (n,typeRecord,context,st)
        return [finEqn]
        -- change back the context to original




removeQuant :: TypeEqn -> (UniVars,ExistVars,[TypeEqn])
removeQuant (TQuant (uvars,evars) teqns) 
        = (uvars,evars,teqns)

removeSimp :: TypeEqn -> (Type,Type)
removeSimp (TSimp (t1,t2)) = (t1,t2)


     

-- =========================================================================================
-- ========================================================================================= 

fun_CallFun :: (FuncName,[Term],PosnPair) -> 
               EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_CallFun (fname,terms,posn) = do 
        (_,typeLFun,context,symTab) <- get
        case lookup_ST (Val_Fun (fname,posn)) symTab of 
            Right valRet -> do 
                let 
                  argLen = length terms
                (fuvars,fintypes,strOutType,nargs) <- remove_ValRet_Fun valRet posn 
                case (argLen == nargs) of 
                    True  -> do 
                        newVars  <- genNewVarList nargs
                        termEqns <- genEquationsList terms newVars
                        modify $ \(n,tt,c,st) -> (n,tt,context,st)
                        let
                          compOutEqn
                                   = TSimp (TypeVarInt typeLFun,strOutType) 
                          compEqns = zipWith (\x y -> TSimp (TypeVarInt y,x)) fintypes newVars
                          finEqns  = TQuant ([],fuvars++newVars)
                                            (compOutEqn:(compEqns++ termEqns))
                        return [finEqns]  

                    False -> do 
                        let
                          emsg 
                            = "Function <<" ++ show fname ++ ">> " ++ printPosn posn ++
                              "called with incorrect number of arguments.Expected " 
                               ++ show nargs ++ " , got " ++ show argLen 
                        left emsg       
            Left emsg    ->   
               left emsg


remove_ValRet_Fun :: ValRet -> PosnPair -> 
                     EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) (UniVars,[Type],Type,NumArgs)

remove_ValRet_Fun (ValRet_Fun (ftype,nargs)) posn  = do 
        renFType <- renameFunType ftype
        let 
          (uVars,itypes,otype,sposn)
              = stripFunType renFType posn 1 
        return (uVars,itypes,otype,nargs)



-- =========================================================================================
-- ========================================================================================= 
{-
Put all the defns (here the defns are function defns) in a new scope in the symbol table and 
then type infer the term.Once that is done restore the symbol table to the original.
-}

fun_Let :: (Term,[LetWhere],PosnPair) ->
           EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]

fun_Let (term,letwhrs,posn) = do 
        (initNum,typeLet,context,symTab) <- get 
        modify $ \(n,tt,c,st) -> (1,0,[],symTab)
        let 
          ldefns    = filter isLetDefn letwhrs
          lremPatts = letwhrs \\ ldefns
          defns     = map removeLetDefn ldefns
          remPatts  = map removeLetPatt lremPatts 
        quadDefnList  <- takeCareofFunDefns defns 
        let 
          newDefns  = (\(a,b,c) -> a) quadDefnList
          newSymTab = insert_ST newDefns symTab NewScope
        -- patt,Terms will be evaluated in the old context and
        -- new symtab.once their evaluation is done the symtab it
        -- took in is returned alogn with an updated context in which
        -- the term part of the let is evaluated.   
        modify $ \(n,tt,c,st) -> (initNum,typeLet,context,newSymTab)
        thngList <- genNewVarList (length remPatts)
        pattEqns <- letPattTermEqns remPatts thngList
        termEqns <- genEquationsList [term] [typeLet]
        modify $ \(n,tt,c,st) -> (n,tt,context,symTab)
        let finEqn = TQuant ([],thngList) (combineEqns (pattEqns ++ termEqns))
        return [finEqn]


isLetDefn :: LetWhere -> Bool
isLetDefn ld = case ld of 
    LetDefn _ -> True
    otherwise -> False 

removeLetDefn :: LetWhere -> Defn 
removeLetDefn (LetDefn d) = d 

removeLetPatt :: LetWhere -> (Pattern,Term)
removeLetPatt (LetPatt (p,t)) = (p,t)


letPattTermEqns :: [(Pattern,Term)] -> [TypeThing] -> 
                   EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn] 
letPattTermEqns [] [] 
        = return [] 
letPattTermEqns ((patt,term):rest) (typeThing:ts) = do 
        (_,_,context,symTab) <- get
        pattEqns <- genPattEquationsList [patt] [typeThing]
        termEqns <- genEquationsList [term] [typeThing]
        remEqns  <- letPattTermEqns rest ts 
        return (pattEqns ++ termEqns ++ remEqns)



getAllFunNames :: [Defn] -> [FuncName]
getAllFunNames defns = map getDefnName defns 

getDefnName :: Defn -> FuncName 
getDefnName (FunctionDefn (fn,_,_,_)) = fn 

{-This is the function for the mutual case-}
takeCareofFunDefns :: [Defn] -> 
                   EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) 
                                    ([Defn],(Log,Package),[TypeEqn])
takeCareofFunDefns []    = do 
         let 
           empPack = (([],[]),[],[],[])
         return ([],([],empPack),[])

takeCareofFunDefns defns = do
        (startNum,_,_,_) <- get  
        typeThings <- genNewVarList (length defns)
        assignSkelTypes defns
        finEqns    <- genFunDefnListEqns defns typeThings         
        let 
          solEqn  = solveEqns finEqns
        case solEqn of
            Left errormsg -> do 
                left $ "Error in mutual functions \n\n" ++
                       intercalate "," (map show (getAllFunNames defns))
                       ++"\n" ++ errormsg

            Right logpack -> do 
                 let 
                    (log,package)
                            = logpack 
                    (fvars,uvars,evars,subsList)
                            = package    
                 case mkNewDefnsMut defns startNum subsList [] of 
                     Left errormsg  ->
                         left $ errormsg ++ "\n" ++ show package
                     Right finDefns ->
                         return (finDefns,logpack,finEqns)                 
                 

mkNewDefnsMut :: [Defn] -> Int -> SubstList -> [Defn] ->
                 Either ErrorMsg [Defn]
mkNewDefnsMut [] _ _ finDefns = do 
      return (reverse finDefns)
mkNewDefnsMut ((FunctionDefn (fn,ftype,fnlist,pn)):ds) num sList shDefn = do 
      let   
        newFType = (fromJust.lookup num) sList
      case lookup num sList of 
          Just newFType -> do 
              let
                fvars    = freeVars newFType
                funType  = IntFType (fvars,newFType)
              case intTypeToStrType funType of 
                  Left  errormsg  -> do 
                      Left errormsg
                  Right fnStrType -> do 
                      let 
                        newDefn  = FunctionDefn (fn,fnStrType,fnlist,pn)
                      mkNewDefnsMut ds (num+1) sList (newDefn:shDefn)
          Nothing -> do 
             let
               oDefn = FunctionDefn (fn,ftype,fnlist,pn)
             mkNewDefnsMut ds (num+1) sList (oDefn:shDefn)


takeCareofFunDefn :: Defn ->
                  EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) 
                                   ([Defn],(Log,Package),[TypeEqn])
takeCareofFunDefn defn@(FunctionDefn (fname,mfunType,pattTermList,posn)) = do
            funEqns <- genFunDefnEqns defn "norm" 
            let 
              solEqn = solveEqns funEqns
            case mfunType of
                -- no type was given
                NoType ->
                    case solEqn of
                        Left errormsg -> do 
                            let
                               emsg = ["Type error in function <<",
                                       show fname, ">> defined ",
                                       printPosn posn, "\n", errormsg 
                                      ] 
                            left $ concat emsg 

                        Right logpack -> do 
                             (_,_,_,symTab) <- get  
                             let 
                                (log,package)
                                         = logpack 
                                (fvars,uvars,evars,subsList)
                                         = package                          
                                funType  = IntFType (evars,(snd.head) subsList)
                             case intTypeToStrType funType of 
                                 Left  iemsg ->
                                     left $ 
                                       unlines 
                                       [
                                        "Error renaming function name " ++ show fname,
                                        iemsg,intercalate "\n" log,
                                        prettyStyle zigStyle funEqns
                                       ]  

                                 Right fnStrType -> do 
                                     let 
                                       newDefn = FunctionDefn (fname,fnStrType,pattTermList,posn)
                                     modify $ \(n,tt,c,st) -> (1,0,[],st)
                                     return ([newDefn],logpack,funEqns)
 
                otherwise -> 
                    case solEqn of
                        Left errormsg -> do 
                            let
                              emsg = "\n" ++ "Type Mistmatch : In function <<" ++
                                      show fname ++ ">> defined" ++ printPosn posn
                                      ++ "\n\n" ++ errormsg   
                              errDefn 
                                   = FunctionDefn (fname,NoType,pattTermList,posn)
                            errEqns <- genFunDefnEqns errDefn "norm" 
                            case solveEqns errEqns of 
                                Left _ ->
                                    left emsg

                                Right logpack -> do 
                                    let 
                                      (log,package)
                                               = logpack 
                                      (fvars,uvars,evars,subsList)
                                               = package                          
                                      funType  = IntFType (evars,(snd.head) subsList)
                                    case intTypeToStrType funType of 
                                        Left  erremsg   ->
                                            left $ 
                                               unlines [errormsg,erremsg]

                                        Right fnStrType -> do   
                                            left $ 
                                               concat
                                                [
                                                 emsg,"\n",
                                                 "Expected Type :: " ++ show fnStrType,"\n",
                                                 "Given Type    :: " ++ show mfunType
                                                ]      

                        Right logpack -> do  
                             return ([defn],logpack,funEqns)


genFunDefnEqns :: Defn -> String -> 
                  EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
genFunDefnEqns defn funkind = do 
        (_,_,context,symTab) <- get
        let 
          FunctionDefn (fname,mfunType,pattTermList,posn) = defn 
        newFType <- renameFunType mfunType
        case funkind == "norm" of 
            True  -> do 
                assignSkelType defn 
                funEqns  <- genPattTermListFunc 
                               pattTermList 
                               (fname,posn,newFType)
                modify $ \(n,tt,c,st) -> (n,tt,context,st)
                return funEqns

            False -> do 
                funEqns  <- genPattTermListFunc 
                               pattTermList 
                               (fname,posn,newFType)
                modify $ \(n,tt,c,st) -> (n,tt,context,st)
                return funEqns
  

-- ==================================================================================
-- ==================================================================================
-- ==================================================================================
takeCareofDefns :: [Defn] -> 
                   EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) 
                                    [([Defn],(Log,Package),[TypeEqn])]
takeCareofDefns []  
        = return []
takeCareofDefns (d:ds) = do 
        q  <- takeCareofDefn d 
        qs <- takeCareofDefns ds 
        return (q:qs)


-- data and codata case will not happen as they have been filtered before
takeCareofDefn :: Defn ->
                 EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) 
                                  ([Defn],(Log,Package),[TypeEqn])
takeCareofDefn defn 
        = case defn of 
              TypeSyn (tsyns,pn) -> undefined   
              ProtocolDefn (pcls,pn) -> undefined
              CoprotocolDefn (pcls,pn) -> undefined
              FunctionDefn _ ->
                  takeCareofFun defn 
              ProcessDefn _ -> undefined
              TermSyn _ -> undefined
              OperatorDefn _ -> undefined
              sthg -> error $ "\n" ++ show sthg




takeCareofFun :: Defn -> 
                 EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) 
                                  ([Defn],(Log,Package),[TypeEqn])
takeCareofFun defn = do 
        modify $ \(n,tt,c,st) -> (1,0,[],st)
        takeCareofFunDefn defn




{- This function is tailor made for the mutual case -}
genFunDefnListEqns :: [Defn] -> [TypeThing] ->
                      EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
genFunDefnListEqns [] []  
        = return []

genFunDefnListEqns (d:ds) (tthing:trest) = do 
       (_,_,context,symTab) <- get 
       modify $ \(n,tt,c,st) -> (n,tthing,c,st)
       dEqns  <- genFunDefnEqns d "mut" 
       modify $ \(n,tt,c,st) -> (n,tt,context,st)
       dsEqns <- genFunDefnListEqns ds trest
       return $ combineEqns (dEqns++dsEqns)


-- ==================================================================================
-- ==================================================================================
-- ==================================================================================

-- This function updates the symbol table with a skeleton type, returns the skeleton variables
-- used in the skeleton type along with total number of variable that each line in function
-- i.e pattern and term on the right would have to generate.
assignSkelType :: Defn ->
                  EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) ()
                                   
assignSkelType (FunctionDefn (fname,fType,pattTerms,fPosn)) = do 
        (_,typeFunDefn,context,symTab) <- get
        case fType of 
            StrFType gFunType -> do 
                insFunType <- renameFunType fType 
                let 
                  funDefn = FunctionDefn (fname,insFunType,pattTerms,fPosn)
                  newST   = insert_ST [funDefn] symTab OldScope
                modify $ \(n,tt,c,st) -> (n,typeFunDefn,context,newST) 
                return () 
            otherwise -> do 
                let 
                  fstPTerm = head pattTerms
                  ((fstPatts,fstTerm),fstPosn)
                           = fstPTerm
                  nargs    = length fstPatts  
                skelVars <- genNewVarList (nargs +1)
                let 
                  (outSkel:inSkel)
                          = skelVars
                  skelFun = TypeFun 
                                  ( map TypeVarInt inSkel,
                                    TypeVarInt outSkel,
                                    fstPosn
                                  ) 
                  fstFunType
                          = IntFType ([],skelFun)
                  funDefn = FunctionDefn (fname,fstFunType,pattTerms,fPosn)
                  newST   = insert_ST [funDefn] symTab OldScope
                modify $ \(n,tt,c,st) -> (n,typeFunDefn,context,newST)
                return ()

                 


assignSkelTypes :: [Defn] -> 
                   EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) () 
                                    
assignSkelTypes []
        = return ()
assignSkelTypes (d:ds) = do 
        assignSkelType d 
        assignSkelTypes ds 
        return ()

-- =========================================================================================
-- ========================================================================================= 

fun_Var :: (String,PosnPair) -> 
           EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_Var (var,posn) = do      
        (num,typeVar,context,_) <- get 
        case lookup_ctxt var context of
            Nothing -> do 
                left 
                  $ "\nVariable <<" ++ show var ++ ">>" ++ 
                     printPosn posn ++ " not in scope.\n" 

            Just someType -> do 
               return [TSimp (TypeVarInt typeVar,someType)]


lookup_ctxt :: String -> Context -> Maybe Type 
lookup_ctxt var context
        = lookup var (concat context)   

-- =========================================================================================
-- ========================================================================================= 

fun_Const :: (BaseVal,PosnPair) -> 
             EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_Const (bval,posn) = do 
        (num,typeConst,context,symTab) <- get
        let
          eqn = TSimp (
                       TypeVarInt typeConst,
                       TypeConst (baseValToBType bval,posn)
                       )
        return $ [eqn]  
  
baseValToBType :: BaseVal -> BaseType 
baseValToBType bval 
        = case bval of 
              ConstInt _  ->
                  BaseInt
              ConstChar _ ->
                  BaseChar
              ConstString _ -> 
                  BaseString
              ConstDouble _ ->
                  BaseDouble

-- =========================================================================================
-- ========================================================================================= 

fun_If :: (Term,Term,Term,PosnPair) ->
          EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_If (term1,term2,term3,posn) = do 
       (num,typeIf,context,symTab) <- get 
       eqns1 <- genEquations term1
       eqns2 <- genEquations term2
       eqns3 <- genEquations term3
       return $ eqns1 ++ eqns2 ++ eqns3 


-- =========================================================================================
-- ========================================================================================= 


fun_Case :: (Term,[PatternTermPhr],PosnPair) ->
            EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_Case (term,patttermphrs,posn) = do
        (_,typeCase,context,symTab) <- get     
        [typeTerm,typeLeft,typeRight] <- genNewVarList 3
        termEqns <- genEquationsList [term] [typeTerm]
        pattEqns <- getPattListCase patttermphrs (typeLeft,typeRight)
        let 
          leftEqn = TSimp (TypeVarInt typeLeft,TypeVarInt typeTerm)
          rightEqn= TSimp (TypeVarInt typeCase,TypeVarInt typeRight)
          finEqn  = TQuant ([],[typeTerm,typeRight,typeLeft])
                           ([leftEqn,rightEqn] ++ (termEqns++ pattEqns))
        return [finEqn]


getPattListCase :: [PatternTermPhr] -> (TypeThing,TypeThing) ->
                   EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
getPattListCase pattTerms (typeLeft,typeRight) = do 
            (_,_,context,symTab) <- get
            totEqn <- helperPattTermCase pattTerms (typeLeft,typeRight)
            return totEqn

checkAllConses :: [PatternTermPhr] -> Either ErrorMsg Bool 
checkAllConses _ = undefined
-- All patterns can be either cons pattern or var pattern
-- All patterns should be of the same data type.
-- if there is a var pattern as the first pattern followed by first pattern
-- then tell the user that it is an issue.
-- if a constructor name has been repeated , then throw an error.
-- if a constructor name is not present then check if the default case is present.
-- if a default case is present then everything is hunky dory else throw an error saying
-- that not all cases have been handled and there is no default case.



-- 1 > hidden pattern (if the 1st pattern is a  var pattern)


helperPattTermCase :: [PatternTermPhr] -> (TypeThing,TypeThing) -> 
                      EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
helperPattTermCase [] _ 
        = return []
helperPattTermCase (p:ps) (typeinp,typeout) = do 
        pEqns  <- genEqnsPattTermCaseType p [typeinp,typeout]
        psEqns <- helperPattTermCase ps (typeinp,typeout)
        return $ (pEqns++psEqns)

genEqnsPattTermCaseType :: PatternTermPhr -> [TypeThing] -> 
                           EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
genEqnsPattTermCaseType (patt:[],eithTerm) [varLeft,varRight] = do 
        (_,_,context,symTab) <- get  
        pattEqns <- genPattEquationsList [patt] [varLeft]
        case eithTerm of
            Left term -> do 
                termEqns <- genEquationsList [term] [varRight]
                modify $ \(n,tt,c,st) -> (n,tt,context,symTab) 
                let 
                  totEqns = pattEqns ++ termEqns
                  cEqns   = combineEqns totEqns
                return cEqns

            Right termPairList -> do
                -- check whether termL is a boolean or not
                guardEqns <- handleGuarded pattEqns varRight termPairList
                modify $ \(n,tt,c,st) -> (n,tt,context,symTab)
                return guardEqns    

handleGuarded :: [TypeEqn] -> TypeThing -> [(Term,Term)] -> 
                 EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
handleGuarded pattEqns varRight termPairList = do 
        handleGuardedHelper pattEqns varRight termPairList  


handleGuardedHelper :: [TypeEqn] -> TypeThing -> [(Term,Term)] -> 
                       EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
handleGuardedHelper _ _ [] 
        = return []
handleGuardedHelper pattEqns varRight ((lTerm,rTerm):rest) = do
        [newVarL,newVarR] <- genNewVarList 2 
        lEqns <- genEquationsList [lTerm] [newVarL] 
        rEqns <- genEquationsList [rTerm] [newVarR] 
        let 
           -- connecting equation to other guard branches
           tlPosn= getTermPosn lTerm
           qEqn1 = TSimp (TypeVarInt newVarR,TypeVarInt varRight)
           qEqn2 = TSimp (TypeVarInt newVarL,TypeDataType ("Bool",[],tlPosn))
           connEqns = TQuant ([],[newVarL,newVarR]) [qEqn2,qEqn1]
           combEqns = combineEqns (pattEqns ++ (connEqns:(lEqns ++ rEqns)))
        remEqns <- handleGuardedHelper pattEqns varRight rest       
        return (combEqns ++ remEqns)  

-- ===================================================================================
-- =================================================================================== 

getDefnPosn :: Defn -> PosnPair
getDefnPosn defn 
        = case defn of 
              Data (_,pn)   -> pn 
              Codata (_,pn) -> pn 
              TypeSyn (_,pn)-> pn      
              ProtocolDefn  (_,pn) -> pn 
              CoprotocolDefn(_,pn) -> pn 
              FunctionDefn (_,_,_,pn) -> pn 
              ProcessDefn (_,_,_,pn) -> pn 


-- ===================================================================================
-- =================================================================================== 
{-
FuncName - Funcion Type
FunType - Original Type given to the function
[TypeThing] - Variables used in the skeleton
Int - Total number of arguments + 1 for the output
TypeEqn - lowest eqn)

-}

genPattTermListFunc :: [(PatternTermPhr,PosnPair)] -> 
                       (FuncName,PosnPair,FunType) ->
                   EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
genPattTermListFunc pattTerms (fname,fposn,fType) = do 
        (_,typeFunDefn,context,symTab) <- get
        let 
          funVal  = Val_Fun (fname,fposn)
          eithVal = lookup_ST funVal symTab  
        case eithVal of
            Left  emsg -> do 
                left emsg 
            Right valRet -> do 
                let 
                  remove_TVarInt :: Type -> Int 
                  remove_TVarInt (TypeVarInt n) = n
                  remove_TVarInt sthg = error $ "Not expecting hahah\n" ++ show sthg 

                  ValRet_Fun (skelFunType,numins)
                        = valRet
                  IntFType (pars,funType)
                        = skelFunType  
                  TypeFun (skelIns,skelOut,skelPosn) 
                        = funType     
                  nargs = numins +1    
                  lowestEqn 
                        = TSimp (TypeVarInt typeFunDefn,funType)
                  skelVars 
                        = concat $ map freeVars (skelOut:skelIns)
                pattTermEqns <- helperEqnsPattern 
                                     (skelVars,nargs)
                                     pattTerms 
                let 
                  totEqn = TQuant ([],skelVars)
                                  (lowestEqn:pattTermEqns)  
                case fType of
                    IntFType _ -> do 
                        let
                          (intFUVars,inTypes,outType,sposn)
                              = stripFunType fType fposn 0
                          newFunType
                              = TypeFun (inTypes,outType,sposn) 
                          givenEqn 
                              = TQuant (intFUVars,[typeFunDefn])
                                       [TSimp (TypeVarInt typeFunDefn,newFunType)]
                          newTotEqn
                              = combineEqns [givenEqn,totEqn]                 
                        return newTotEqn
                      
                    otherwise ->
                        return [totEqn]



genEqnsPattTermFunType :: (PatternTermPhr,PosnPair) -> ([Int],Int) -> 
                   EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
genEqnsPattTermFunType ((patts,eithTerm),posn) (varsLeft,varRight) = do 
        (_,_,context,symTab) <- get  
        pattEqns <- genPattEquationsList patts varsLeft      
        case eithTerm of
            Left term -> do 
                termEqns <- genEquationsList [term] [varRight]
                modify $ \(n,tt,c,st) -> (n,tt,context,symTab) 
                let 
                  totEqns = pattEqns ++ termEqns
                return $ combineEqns totEqns

            Right termPairList -> do
                -- this will be the final equation to return
                guardEqns <- handleGuarded pattEqns varRight termPairList
                modify $ \(n,tt,c,st) -> (n,tt,context,symTab)
                return guardEqns      

helperEqnsPattern :: ([Int],Int) -> [(PatternTermPhr,PosnPair)] -> 
                     EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]

helperEqnsPattern _ []  
        = return []

helperEqnsPattern (skelVars,nVars) (fstPattTerm:restPatts) = do 
        pattVars <- genNewVarList nVars  
        let 
          eqnsEquality
                   = zipWith (\x y -> TSimp (TypeVarInt y,TypeVarInt x)) skelVars pattVars
        eqnsNonEquality <- genEqnsPattTermFunType fstPattTerm (tail pattVars,head pattVars)
        let 
          fstPattEqns = TQuant ([],pattVars) (eqnsEquality ++ eqnsNonEquality)
        remPattEqns <- helperEqnsPattern (skelVars,nVars) restPatts 
        return $ (fstPattEqns:remPattEqns)



-- ===================================================================================
-- ===================================================================================
fun_Fold :: (Term,[FoldPattern],PosnPair) ->
            EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_Fold (term,foldPatts,posn) = do
        (_,_,context,symTab) <- get     
        handle_FoldPatts foldPatts term 
      

getFoldName :: FoldPattern -> (Name,PosnPair)
getFoldName (name,_,_,pn) = (name,pn)

handle_FoldPatts :: [FoldPattern] -> Term ->
                    EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
handle_FoldPatts foldPatts term = do 
        (_,typeFold,context,symTab) <- get 
        let 
          nmPnPairs = map getFoldName foldPatts
        funPairs <- getAllFoldFuns nmPnPairs
        let 
          dataFun = (snd.head) funPairs
          funs    = (map fst funPairs) ++ [dataFun]              
        (allUVars,allFuns,outType) <- renameFunsTypes funs 
        foldEqns  <- hndl_FPatt_main foldPatts (init allFuns)
        termVar   <- genNewVar
        termEqns1 <- genEquationsList [term] [termVar]
        let
          outEqn    = TSimp  (TypeVarInt typeFold,outType) 
          termEqns2 = TSimp  (TypeVarInt termVar,last allFuns)
          finEqn    = TQuant ([],termVar:allUVars)
                             ([outEqn,termEqns2] ++ termEqns1 ++ foldEqns)
        modify $ \(m,tt,c,st) -> (m,typeFold,context,st)
        return [finEqn]
        
getAllFoldFuns :: [(Name,PosnPair)] -> 
                  EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) 
                                   [(FunType,FunType)]
getAllFoldFuns [] = return []
getAllFoldFuns (np:nps) = do 
        (_,_,context,symTab) <- get  
        case lookup_ST (Val_Cons np) symTab of 
            Left emsg -> do 
                left emsg 
            Right valRet -> do 
                let 
                  ValRet_Cons (_,_,pair,_) = valRet
                pairs <- getAllFoldFuns nps 
                return (pair:pairs) 


hndl_FPatt_main :: [FoldPattern] -> [Type] -> 
                   EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
hndl_FPatt_main [] [] = return []     
hndl_FPatt_main (p:ps) (ft:fts) = do
        teqn  <- handle_FoldPatt p ft 
        teqns <- hndl_FPatt_main ps fts 
        return $ teqn ++ teqns



handle_FoldPatt :: FoldPattern -> Type -> 
                   EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
handle_FoldPatt (name,patts,term,posn) foldT  = do 
        (_,typeFold,context,symTab) <- get
        pattVars <- genNewVarList (length patts)
        pattEqns <- genPattEquationsList patts pattVars
        termVar  <- genNewVar
        termEqns <- genEquationsList [term] [termVar]
        let 
          (ins,out)= getOutFnType foldT 
          inEqns   = zipWith (\x y -> TSimp (TypeVarInt y,x)) ins pattVars 
          outEqn   = TSimp (TypeVarInt termVar,out)
          finEqn   = TQuant ([],termVar:pattVars) 
                           (outEqn:(inEqns ++ pattEqns++termEqns))
        modify $ \(n,tt,c,st) -> (n,typeFold,context,symTab)
        return [finEqn]


-- check whether all constructors are present 
-- first is the list of all constructor in the fold , second is the list of all constructors
checkConses :: [(Name,PosnPair)] -> [Name] -> Name -> SymbolTable -> Either ErrorMsg Bool 
checkConses foldConsPosn allConses datatype symTab = do 
        let 
           foldConses
                   = map fst foldConsPosn
           -- absent conses
           absCons = allConses \\ foldConses
           -- duplicate conses
           dupCons = allConses \\ (nub allConses)
           -- extra conses
           extCons = foldConses \\ allConses
        case extCons == [] of 
            True  -> do 
                case absCons == [] of
                    True  ->   
                        case dupCons == [] of 
                            True  ->
                                return True
                            False -> do 
                                let 
                                  dupConsPosn
                                       = filter (\(x,p) -> elem x dupCons) foldConsPosn
                                  emsg = "Following constructors have been used more than once in" ++
                                         "a fold over  data type <<" 
                                          ++ show datatype ++ ">>.\n" ++ 
                                          (intercalate "\n" (map printConsDest dupConsPosn))
                                Left emsg 

                    False -> do 
                        let 
                          absConsPosn
                               = filter (\(x,p) -> elem x absCons) foldConsPosn
                          emsg = "Following constructors missing for data <<" 
                                 ++ show datatype ++ ">>.\n" ++ 
                                 (intercalate "\n" (map printConsDest absConsPosn))
                        Left emsg                           
            False -> do 
                let 
                  extConsPosn
                       = filter (\(x,p) -> elem x extCons) foldConsPosn
                  emsg = "Extraneous constructors found.Following constructors don't belong to data <<" 
                         ++ show datatype ++ ">>.\n" ++
                          (intercalate "\n" (map printConsDest extConsPosn))
                Left emsg 




-- ===================================================================================
-- ===================================================================================
fun_Unfold ::(Term,FoldPattern,PosnPair) ->
             EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_Unfold (term,foldPatt,posn) = undefined      


-- ===================================================================================
-- ===================================================================================
fun_Cons ::(Name,[Term],PosnPair) ->
           EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_Cons (consName,terms,posn) = do 
        (_,typeCons,context,symTab) <- get 
        let 
          eithVal = lookup_ST (Val_Cons (consName,posn)) symTab           
        case eithVal of 
            Right retVal -> do 
                let 
                  ValRet_Cons ((datName,allConses),ftype,_,nargs)
                           = retVal 
                case nargs == length terms of
                    True  -> do 
                        renFunType <- renameFunType ftype 
                        newVars    <- genNewVarList nargs
                        termEqns   <- genEquationsList terms newVars
                        let 
                          (univVars,itypes,otype,sposn)
                                  = stripFunType renFunType posn 1     
                          outEqn  = TSimp (TypeVarInt typeCons,otype)
                          inEqns  = zipWith (\x y -> TSimp (TypeVarInt y,x)) 
                                            itypes 
                                            newVars

                          finEqns = TQuant ([],univVars++newVars)
                                           (outEqn:(inEqns ++ termEqns))
                        return [finEqns]
                    False -> do 
                        let
                          emsg 
                            = "Constructor/Destructor <<" ++ show consName ++ ">> " ++ 
                               printPosn posn ++
                              "called with incorrect number of arguments.Expected " 
                               ++ show nargs ++ " ,got " ++ show (length terms) 
                        left emsg                                     
                
            Left emsg -> 
                left emsg  
-- ===================================================================================
-- ===================================================================================
fun_Dest :: (Name,[Term],PosnPair) ->
            EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_Dest (name,terms,posn) = do 
        (_,typeDest,context,symTab) <- get
        let 
          eithVal = lookup_ST (Val_Dest (name,posn)) symTab
        case eithVal of 
            Left emsg ->
                left emsg 
            Right retVal -> do 
                let 
                  numTerm = length terms  
                  ValRet_Dest ((cdatName,allDests),funtype,nargs)
                          = retVal 
                case numTerm == nargs  of 
                    True  -> do 
                        renFunType <- renameFunType funtype 
                        termVars   <- genNewVarList nargs
                        termEqns   <- genEquationsList terms termVars
                        let 
                          IntFType (evars,fType)
                                 = renFunType 
                          TypeFun(ins,out,tposn)
                                 = fType 
                          inEqns = zipWith (\x y ->TSimp (TypeVarInt x,y)) termVars ins                                                   
                          outEqn = TSimp (TypeVarInt typeDest,out) 
                          finEqn = TQuant ([],evars++termVars) (outEqn:(inEqns ++ termEqns)) 
                        return [finEqn]                                              

                    False -> do 
                        let 
                          emsg 
                            = "Destructor <<" ++ show name ++ ">> has incorrect number of arguments.\n"
                              ++ "Expected " ++ show nargs ++ ", got " ++ show numTerm
                        left emsg 

-- ===================================================================================
-- ===================================================================================
fun_Prod ::([Term],PosnPair) -> 
            EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_Prod (terms,posn) = do 
        (_,typeProd,context,symTab) <- get
        termVars  <- genNewVarList (length terms)
        prodEqns  <- genEquationsList terms termVars
        let 
          tSimp  = TSimp (TypeVarInt typeProd,TypeProd (map TypeVarInt termVars,posn))
          finEqn = TQuant ([],termVars) (tSimp:prodEqns)
        modify $ \(n,tt,c,st) -> (n,tt,context,symTab)
        return [finEqn]

-- ===================================================================================
-- ===================================================================================
fun_Default ::PosnPair -> 
              EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
fun_Default posn = do 
        (_,typeDef,context,symTab) <- get 
        let 
          eqn = TSimp (TypeVarInt typeDef,TypeDataType ("Bool",[],posn))
        return [eqn]   

