module ToCMPL.LambdaLift where 

import TypeInfer.MPL_AST
import qualified Data.Set as S 
import Data.List

type FVar = String
type BVar = String

{-
first name is the function name. Every function has some freevars, 
some bound vars and the functions names used in the function body
-}
type SetEqn = (Name,(S.Set BVar,S.Set FVar,[Name]))

{-
All the definitons here function definitions. Only things that need to be lambda
lifted are  the defns within the where part of let statements. These
defintions can be mutually recursive.
-}

genSetEqns :: [Defn] -> [SetEqn]
genSetEqns = map genSetEqn 

{-
At this point all the functions are gonna have only one line of 
pattern term.
-}
genSetEqn :: Defn -> SetEqn 
genSetEqn fDefn@(FunctionDefn (Custom fn,fType,[fBody],pn))
        = (fn,(S.fromList fVars,S.fromList bVars,funDeps)) 
    where
      ((fPatts,Left fTerm),_) 
             = fBody 
      -- get bound vars
      bVars  = getBVarDefn fDefn 
      -- get free vars 
      fVars  = getfreeVarsDefn fDefn 
      funDeps= getFNames fTerm



getBVarDefn :: Defn -> [BVar]
getBVarDefn (FunctionDefn (Custom fn,fType,[fBody],pn))
    = map (\(VarPattern (u,pn)) -> u) fPatts
  where
      ((fPatts,fTerm),_) = fBody 


{-
get all the free variables used inside a function defintion 
-}

getfreeVarsDefn :: Defn -> [FVar]
getfreeVarsDefn defn@(FunctionDefn (Custom fn,fType,[fBody],pn))
    = allVars \\ bvars 
  where
      ((fPatts,Left fTerm),_) 
             = fBody 
      bvars  = getBVarDefn defn 
      allVars= getVarsL fTerm


getVarsL :: Term -> [FVar]
getVarsL term 
    = case term of 
        TRecord tList ->
          getVarsL_rec tList

        TCallFun (_,terms,_) ->
          concat $ map getVarsL terms

        TLet (term,lwhrs,_) -> 
          getVarsL term ++ getVarsL_lwhrs lwhrs  

        TVar    (var,_) -> 
          [var]

        TIf (t1,t2,t3,_) -> 
          (concat.map getVarsL) [t1,t2,t3]

        TCase   (term,pattTerms,_) ->
          getVarsL term ++ 
          (concat.map getVarsL_PT) pattTerms 

        TCons   (_,terms,_) ->
          (concat.map getVarsL) terms

        TDest   (_,terms,_) -> 
          (concat.map getVarsL) terms

        TProd   (terms,_) -> 
          (concat.map getVarsL) terms

        otherwise -> 
          [] 


getVarsL_rec :: [(Pattern,Term,PosnPair)] -> [FVar]
getVarsL_rec tList = concat $ map getVarsL (map (\(a,b,c) -> b) tList)

{-
At this point all the terms on the right are Left terms.
-}
getVarsL_PT :: PatternTermPhr -> [FVar]
getVarsL_PT (_,Left term)
    = getVarsL term 


getVarsL_lwhrs :: [LetWhere] -> [FVar]
getVarsL_lwhrs lwhrs = concat $ map getVarsL_lwhr lwhrs

getVarsL_lwhr :: LetWhere -> [FVar]
getVarsL_lwhr lwhr 
    = case lwhr of 
        LetPatt (patt,term) -> 
            getVarsL term 
        LetDefn defn ->
            getfreeVarsDefn defn 

-- ========================================================================
-- ========================================================================

getFNames ::  Term -> [Name]
getFNames term 
    = case term of 
        TRecord tList ->
           (concat.map getFNames_rec) tList

        TCallFun (fnm,terms,_) ->
          case fnm of 
              Custom sfn ->
                sfn : tnms 
              otherwise ->
                tnms 
           where
             tnms = (concat.map getFNames) terms

        TLet (term,lwhrs,_) -> 
          getFNames term ++ getFNames_lwhrs lwhrs  

        TIf (t1,t2,t3,_) -> 
          (concat.map getFNames) [t1,t2,t3]

        TCase   (term,pattTerms,_) ->
          getFNames term ++ 
          (concat.map getFNames_PT) pattTerms 

        TCons   (_,terms,_) ->
          (concat.map getFNames) terms

        TDest   (_,terms,_) -> 
          (concat.map getFNames) terms

        TProd   (terms,_) -> 
          (concat.map getFNames) terms

        otherwise -> 
          [] 


getFNames_rec :: (Pattern,Term,PosnPair) -> [Name]
getFNames_rec (_,term,_)
    = getFNames term 

getFNames_lwhrs :: [LetWhere] -> [Name]
getFNames_lwhrs = (concat.map getFNames_lwhr)

getFNames_lwhr :: LetWhere -> [Name]
getFNames_lwhr lwhr 
    = case lwhr of
        LetDefn defn -> 
            concat $ map getFNames terms  
          where
            FunctionDefn (_,_,pattList,_) = defn 
            terms = map (\((p,Left t),ppn)-> t) pattList

        LetPatt (_,term) -> 
            getFNames term  


getFNames_PT :: PatternTermPhr -> [Name]
getFNames_PT (patts,Left term)
    = getFNames term 


 

