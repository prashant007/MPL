module ToCMPL.PatternCompiler where

import ToCMPL.PatternComp_Help

import TypeInfer.MPL_AST 
import TypeInfer.Gen_Eqns_CommFuns

import TypeInfer.SymTab_DataType
import TypeInfer.SymTab 


import Control.Monad.State.Lazy
import Control.Monad.Trans.Either
import Data.List 

eMsgCase :: (FuncName,PosnPair) -> Term  
eMsgCase (fnm,fpn) 
    = TError $
        "Error in compiling Pattern: In function <<" 
        ++ show fnm ++ ">>" ++ printPosn fpn 

pattCompile_Stmt :: Stmt -> 
        EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
                Stmt 
pattCompile_Stmt stmt = do 
    case stmt of 
      DefnStmt (defns,stmts,pn) -> do 
        newStmts <- mapM pattCompile_Stmt stmts 
        newDefns <- mapM pattCompile_Defn defns 
        return $ DefnStmt (defns,stmts,pn)

      otheriwse ->
        return stmt    


pattCompile_Defn :: Defn -> 
        EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
                Defn  

pattCompile_Defn defn = do 
    (_,_,_,_,symTab) <- get 
    case defn of 
        FunctionDefn (fName,fType,pairList,pn) -> do 
            let
              pattTerms= map fst pairList 
              numArgs  = (length.fst.head) pattTerms
            newArgs <- genNewVarList numArgs
            newPattTerm <- mapM handleEithTerm pattTerms
            let 
              strArgs = map (\x -> "v_" ++ show x) newArgs
              varPatts= map (\x -> VarPattern (x,pn)) strArgs
              eithTerm= eMsgCase (fName,pn) 
              match   = MatchFun (fName,pn) strArgs newPattTerm eithTerm 

            newTerm <- normalize_Match match 

            let 
              newPList= [((varPatts,Left newTerm),pn)]
              newDefn = FunctionDefn (fName,fType,newPList,pn)  

            return newDefn

        otherwise -> 
            return defn 


{-
This function handles the base case of the normalize_Match function
-}

checkpattList :: (FuncName,PosnPair) ->  [Equation] -> Term -> 
     EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
             Term 

checkpattList (fn,pn) pattTermList defTerm = do 
    let
      allPatts  = map fst pattTermList
      nonempty  = filter (\x -> x /= []) allPatts
    case nonempty == [] of 
      True  ->
        return $ (snd.head) pattTermList

      False -> do 
        case defTerm of 
          TError emsg -> 
            left emsg
          othTerm -> 
            return $ othTerm 



normalize_Match :: Match -> 
     EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
             Term
normalize_Match (MatchFun fnPair [] pattTermList defTerm)
    = checkpattList fnPair pattTermList defTerm

normalize_Match m@(MatchFun fnPair args pattList defTerm) = do 
    (_,_,_,_,symTab) <- get  
    case (ruleType pattList) of 
      0 -> 
        normalize_Match (handleVarPatt m) 

      1 -> do
        eqns <- rearrangeEqns pattList fnPair defTerm 
        handleConsPatt args fnPair defTerm eqns

      otherwise -> do 
          handleMixedPatt args fnPair defTerm pattList




{-
This is the variable case
-}

handleVarPatt :: Match -> Match 
handleVarPatt (MatchFun (fnm,fpn) (u:us) eqns eithVal)
      = MatchFun (fnm,fpn) us (map (varPatt_help u) eqns) eithVal

varPatt_help :: String -> Equation -> Equation
varPatt_help str ((VarPattern pair):ps,term)
      = susbtInPattTerm subst (ps,term)
  where 
    subst  = (TVar pair,TVar (str,snd pair))  


susbtInPattTerm :: (Term,Term) -> Equation -> Equation
susbtInPattTerm subst (patts,term)
    = (patts,(subsInTerm subst term))


{-
This is the case where all the first patterns are constructors.
-}


handleConsPatt :: [String] -> (FuncName,PosnPair) -> Term -> [[Equation]] -> 
     EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
             Term 
handleConsPatt (u:us) fnPair@(fn,fpn) defTerm eqns = do 
    pattTermList <- mapM (\eq -> genPattTerm us fnPair defTerm eq) eqns
    let 
      term = TCase (TVar(u,fpn),pattTermList,fpn)
    return $ term   
     


{-
This equation takes a list of string and an equation list beginning with
a particular constructor. This is going to be converted to one branch in the
case construct.

-}

genPattTerm :: [String] -> (FuncName,PosnPair) -> Term -> [Equation] -> 
     EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
             PatternTermPhr
genPattTerm us fnPair defTerm eqns@((patts,_):ps) = do
    let 
      ConsPattern (cn,args,pn) = head patts  
    newVars <- genNewVarList (length args)
    let  
      newArgs     = map (\x -> "v_" ++ show x) newVars 
      pattArgs    = map (\x -> VarPattern (x,pn)) newArgs
      newheadPatt = ConsPattern (cn,pattArgs,pn)
      newEqns     = getPattHelper eqns 
      newMatch    = MatchFun fnPair (newArgs++us) newEqns defTerm
    newTerm <- normalize_Match newMatch   
    return ([newheadPatt],Left newTerm)


getPattHelper :: [Equation] -> [Equation]
getPattHelper []
    = []
getPattHelper ((ConsPattern (cn,patts,pn):ps,term):rest)
    = (patts ++ ps,term):getPattHelper rest






{- This is the mixed case -}
handleMixedPatt :: [String] -> (FuncName,PosnPair) -> Term -> [Equation] ->
     EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
             Term          
handleMixedPatt uvars fnPair defterm [eqn] = do  
    let 
      match = MatchFun fnPair uvars [eqn] defterm
    normalize_Match match

handleMixedPatt uvars fnPair defterm (eqn:eqns)  = do 
    newTerm <- handleMixedPatt uvars fnPair defterm eqns 
    let 
      match = MatchFun fnPair uvars [eqn] newTerm
    normalize_Match match 


-- ===============================================================
-- ===============================================================
-- I am assuming there is a default term in the guard and at the minimum 
-- there are two guards.
handleEithTerm :: PatternTermPhr -> 
    EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
                ([Pattern],Term)

handleEithTerm (patts,eithTerm) 
    = case eithTerm of 
          Left term -> 
            case term of 
              TIf (t1,t2,t3,_) -> do 
                let 
                  cTerm = genCase (t1,t2) t3 
                return (patts,cTerm)

              TLet _ -> do 
                finTerm <- handleLet term 
                return (patts,finTerm)

              otherwise -> 
                return (patts,term)

          Right gTerms -> do 
            let defTerm = (snd.last) gTerms
            newTerm <- handleGuarded (init gTerms) defTerm
            return (patts,newTerm)

    
{-
   This function will ensure that constants used in the where 
    part of let are replaced with their right hand side in both the term of 
    let term as well as in the where part.

    The point to note here is that to prevent the overwrite of local variables 
    of the let function defintions by the global ones they need to be made 
    refreshed. One way of doing this would be to compile the patterns in these 
    functions. 
-}
handleLet :: Term -> 
    EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
            Term 
handleLet (TLet (lterm,lwhrs,pn)) = do
    let 
      allDefLWhrs  = filter isFunDefnLWhr lwhrs
      allDefns     = map (\(LetDefn d) -> d) allDefLWhrs 
      remLWhrs     = lwhrs \\ allDefLWhrs    
    newDefns <- mapM pattCompile_Defn allDefns
    let 
      newAllDefLWhrs = map (\d -> LetDefn d) newDefns 
      finLWhrs       = remLWhrs ++ newAllDefLWhrs   
    handleLet_help finLWhrs lterm pn 

