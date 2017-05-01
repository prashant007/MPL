{-# LANGUAGE DeriveGeneric #-}

module ToCMPL.PatternComp_Help where

import TypeInfer.MPL_AST 

import Text.PrettyPrint.GenericPretty
import Text.PrettyPrint
import Control.Monad.State.Lazy
import Control.Monad.Trans.Either
import Data.List 
import Data.Maybe

import TypeInfer.Gen_Eqns_CommFuns
import TypeInfer.SymTab_DataType
import TypeInfer.SymTab 
import TypeInfer.Gen_Eqns_CommFuns

type Equation = ([Pattern],Term)


data Match =  MatchFun  (FuncName,PosnPair) 
                        [String] [Equation] 
                        Term
              deriving (Eq,Generic)

instance () => Out (Match)

isVarPatt :: Pattern -> Bool 
isVarPatt (VarPattern _) = True 
isVarPatt _              = False 

isConsPatt :: Pattern -> Bool 
isConsPatt (ConsPattern _) = True 
isConsPatt _                 = False  


ruleType :: [Equation] -> Int 
ruleType pattermphrs = do 
    case allVars of 
      True  -> do 
        0 
      False ->
        case allCons of 
          True  ->
            1 
          False ->
            2
   where
      allCons  = (and.map isConsPatt) pattList
      allVars  = (and.map isVarPatt) pattList
      pattList = map (head.fst) pattermphrs

-- ======================================================================
-- ======================================================================

rearrangeEqns :: [Equation] -> (FuncName,PosnPair) -> Term -> 
        EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
                 [[Equation]]

rearrangeEqns eqns fPair@(fname,fPosn) defTerm = do 
    (_,_,_,_,symTab) <- get 
    let 
      allPatts = map (head.fst) eqns 
      ConsPattern (consName,_,posn)
              = head allPatts
      pConses = nub $ map getConsName allPatts  
      eithVal = lookup_ST (Val_Cons (consName,posn)) symTab
    case eithVal of 
      Left emsg -> 
          left emsg
      
      Right retVal -> do 
        let 
          ValRet_Cons ((datName,allConses),_,_,_)
                 = retVal 
          miss_cons = allConses \\ pConses
          extr_Cons = pConses \\ allConses
        case extr_Cons == [] of 
            False -> do 
              let
                emsg = 
                  "Error:Extraneous constructors of data type <<" 
                  ++ show datName ++ ">> used in function <<"
                  ++ show fname ++ printPosn fPosn ++ "\n" ++
                  intercalate ", " extr_Cons
              left emsg 

            True -> do 
              meqns <- mapM (\x -> missing_Eqn x fPair defTerm) miss_cons
              -- prioritise constructors
              let 
                priCons = zip allConses [1..]
                stEQns  = categoriseEqns (eqns ++ meqns) 
                finEqns = evalState stEQns (priCons,1)

              return finEqns


-- This function is going to generate equations for the missing constructors.
-- The term on the right hand side is going to be the default term  
missing_Eqn :: Name -> (FuncName,PosnPair) -> Term ->
        EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
                Equation
missing_Eqn consName (fnm,fpn) defTerm = do   
    (_,_,_,_,symTab) <- get 
    let 
      eithVal = lookup_ST (Val_Cons (consName,fpn)) symTab
    case eithVal of 
      Left emsg -> 
         left emsg 

      Right retVal -> do 
        let 
          ValRet_Cons ((datName,_),_,_,numArgs)
                 = retVal 
        intArgs <- genNewVarList numArgs

        let 
          emsg = "Pattern Error:Constructor <<" ++ consName ++ 
                 ">> of data type <<" ++ show datName ++ 
                 ">> is not present in a pattern in function <<"++ show fnm 
                 ++ ">>" ++ printPosn fpn 

          newVPatts= map (\x ->  VarPattern ("v_" ++ show x,fpn)) intArgs
          consPatt = [ConsPattern (consName,newVPatts,fpn)]

        case defTerm of 
          TError _ -> do 
            let 
              eqn = (consPatt,TError emsg)
            return eqn 

          otherwise -> do 
            let 
              eqn = (consPatt,defTerm)
            return eqn 




{-
Priority list is a pair of constructor names and a priority
assigned to it.

Take a Equation list and group them according to the 
constructors they belong to.  

-}

type PriorityList = [(Name,Int)]

categoriseEqns :: [Equation] -> 
                  State (PriorityList,Int) [[Equation]]
categoriseEqns []   = return []
categoriseEqns eqns = do 
   tripList <- assignPrior eqns
   let 
     gEqns  = groupBy (\x y -> boolCond_Group x y) tripList
     sEqns  = map (sortEqns) gEqns          
     finEqns= map (map getAfromABC) sEqns
   return finEqns

getAfromABC :: (a,b,c) -> a 
getAfromABC (x,y,z) = x

{-
This function will group things that have the
same 2nd argument.This is used with groupWith
function.
-}
boolCond_Group :: (Equation,Int,Int) -> 
                  (Equation,Int,Int) -> Bool
boolCond_Group (_,n1,_) (_,n2,_) 
        = n1 == n2 

{-
This function will sort equations based on its third argument.
This is used with sortBy function.
-}

sortEqns :: [(Equation,Int,Int)] -> [(Equation,Int,Int)]
sortEqns  = sortBy boolCond_Sort

groupEqns :: [(Equation,Int,Int)] -> [[(Equation,Int,Int)] ]
groupEqns = groupBy boolCond_Group 


boolCond_Sort ::  (Equation,Int,Int) -> 
                  (Equation,Int,Int) -> Ordering
boolCond_Sort (_,_,n1) (_,_,n2)
        | n1 > n2  = GT 
        | n1 < n2  = LT 
        | n1 == n2 = EQ  


{-
This function takes a list of equations and
associates a priority with them based on the 
constructor priority. This function also assigns 
a priority to the equations based on their initial 
ordering.


Using these equations can be arranged based on the
priority of their first constructors in the pattern.
This will give back a list of list of equations. Every
list of equations will correspond to a given data 
constructor. In the list of equations within every,
we will arrange the equations on their intial ordering.
-}
assignPrior :: [Equation] -> 
            State (PriorityList,Int) [(Equation,Int,Int)]
assignPrior [] = return []            
assignPrior (eq:eqs) = do 
    (plist,currNum) <- get  

    let 
      mayVal   = lookup (getfstCons eq) plist
      prNum    = fromJust mayVal
      currTrip = (eq,prNum,currNum)

    modify (\(p,cn) -> (p,cn+1)) 
    remTrip <- assignPrior eqs 
    return (currTrip:remTrip) 
     

{-
Take an equation and get the constructor name for the 
first pattern of the pattern list on the left
-- ([Pattern],Either Term [GuardedTerm])
-}
getfstCons :: Equation -> String
getfstCons (patts,_) 
    = getConsName (head patts)  
 

getConsName :: Pattern -> Name 
getConsName (ConsPattern (cname,_,_)) 
    = cname


-- ======================================================================
-- ======================================================================

subsInTerm :: (Term,Term) -> Term -> Term  
subsInTerm subst@(oTerm,nTerm) sterm 
    = case sterm of
        TRecord tripList -> 
          TRecord (substTripList subst tripList) 
        
        TCallFun (fName,terms,pn) ->
          TCallFun (fName,map (subsInTerm subst) terms,pn)

        TLet (term,letwhrs,pn) -> 
          TLet (
                subsInTerm subst term,
                map (substLetWhr subst) letwhrs,
                pn 
               ) 

        TVar (str,pn) -> 
          case ostr == str of 
            True  -> 
              nTerm
            False ->
              sterm

        TIf     (t1,t2,t3,pn) -> 
          TIf (
                subsInTerm subst t1,
                subsInTerm subst t2,
                subsInTerm subst t3,
                pn
              )

        TCase   (term,pattTerms,pn) -> 
          TCase (
                 subsInTerm subst term,
                 map (susbtInPattCase subst) pattTerms,
                 pn
                )

        TFold   (term,foldPatts,pn) -> 
          TFold (
                  subsInTerm subst term,
                  map (substInFoldPatt subst) foldPatts,
                  pn
                ) 

        TUnfold (term,foldPatt,pn) -> 
          undefined

        TCons   (nm,terms,pn) -> 
          TCons (nm, map (subsInTerm subst) terms,pn)

        TDest (nm,terms,pn) -> 
          TDest (nm,map (subsInTerm subst) terms,pn)

        TProd (terms,pn) -> 
          TProd (map (subsInTerm subst) terms,pn)

        otherwise -> 
          sterm  
    where 
       TVar (ostr,opn) = oTerm 

-- ===================================================================
-- ===================================================================

susbtList :: [(Term,Term)] -> Term -> Term 
susbtList [] finTerm 
    = finTerm
susbtList (s:ss) term 
    = susbtList ss (subsInTerm s term)

substTripList :: (Term,Term) -> [(Pattern,Term,PosnPair)] -> 
                 [(Pattern,Term,PosnPair)]

substTripList _ []
    = []
substTripList subst ((patt,term,pn):rest)
    = ((patt,subsInTerm subst term,pn):substTripList subst rest) 


substInFoldPatt :: (Term,Term) -> FoldPattern -> FoldPattern
substInFoldPatt subst (nm,patts,term,pn)
    = (nm,patts,subsInTerm subst term,pn) 


substInFun :: (Term,Term) -> [(PatternTermPhr,PosnPair)] -> 
              [(PatternTermPhr,PosnPair)]
substInFun subst  
    = map (\(pt,ppn) -> (susbtInPattCase subst pt,ppn)) 


susbtInPattCase :: (Term,Term) -> PatternTermPhr -> PatternTermPhr
susbtInPattCase subst (patts,Left term)
    = (patts,Left (subsInTerm subst term))

getLeft :: Either a b -> a
getLeft (Left a) = a

-- ============================================================================
-- ============================================================================


handleGuarded :: [GuardedTerm] -> Term -> 
    EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
            Term

handleGuarded [gTerm] defTerm =  
    return (genCase gTerm defTerm)    

handleGuarded (gTerm:gs) defTerm = do 
    fTerm <- handleGuarded gs defTerm
    return (genCase gTerm fTerm)

{-
Term corresponding to True is obtained from the GuardedTerm and the 
False one from the second argument of function.
-}
genCase :: GuardedTerm -> Term -> Term 
genCase (t1,t2) fTerm = lcase
    where
      t1Posn   = getTermPosn t1
      fPosn    = getTermPosn fTerm
      truePatt = ConsPattern ("True",[],t1Posn)
      falsePatt= ConsPattern ("False",[],fPosn)
      pattTerm1= ([truePatt] ,Left t2)
      pattTerm2= ([falsePatt],Left fTerm)
      lcase    = TCase (t1,[pattTerm1,pattTerm2],t1Posn)



isFunDefnLWhr :: LetWhere -> Bool 
isFunDefnLWhr (LetDefn _) = True 
isFunDefnLWhr _           = False 

{-
Important assumption - All the variable assignments should occur before 
the defintions
-}
handleLet_help :: [LetWhere] -> Term -> PosnPair ->
    EitherT ErrorMsg (State (Int,TypeThing,Context,ChanContext,SymbolTable))
        Term 

handleLet_help [] letTerm _
    = return letTerm  

handleLet_help ret@(lwhr:rest) letTerm pn 
    = case lwhr of 
          -- here onwards every LetWhere will be a defn 
          LetDefn d -> do 
            let 
              finLTerm = TLet (letTerm,ret,pn)
            return finLTerm 

          LetPatt (patt,letTerm) -> do 
            let 
              VarPattern pair
                      = patt 
              subst   = (TVar pair,letTerm)
              -- substitute in the let term 
              newLTerm = subsInTerm subst letTerm   
              -- substitute in the other where clause underneath the 
              -- current one 
              newRest = map (substLetWhr subst) rest
            handleLet_help newRest newLTerm pn 



substLetWhr :: (Term,Term) -> LetWhere -> LetWhere

substLetWhr subst lwhr 
    = case lwhr of 
          LetDefn defn ->
            LetDefn (substInDefn subst defn)  
          LetPatt (patt,term) -> 
            LetPatt (patt,subsInTerm subst term)


substInDefn :: (Term,Term) -> Defn -> Defn 
substInDefn subst defn 
    = case defn of 
        FunctionDefn (fnm,fType,fbody,pn) ->
          FunctionDefn (fnm,fType,substInFun subst fbody,pn)

        otherwise -> defn 
