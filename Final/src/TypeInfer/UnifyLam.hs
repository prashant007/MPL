module TypeInfer.UnifyLam  where

import TypeInfer.MPL_AST 
import Data.Either 
import Data.List 

-- here the second expression is always a TVar
check :: (Type,Type) -> Either ErrorMsg SubstList
check (texpr1,texpr2)
        = case (texpr1==texpr2) of
              True  -> do
                   return []

              False ->
                   case doOccursCheck (texpr1,texpr2) of
                       True  -> do 
                           let 
                              TypeVarInt var2 = texpr2
                           return [(var2,texpr1)]
                       False ->
                           Left $ "Fails Occurs Check: Expr <<" ++ show texpr2 
                                   ++ ">> occurs in Expr <<" ++ show texpr1 ++ ">>.\n"

-- here too the second expression is a TVar 
-- return True if occurs check is passed
doOccursCheck :: (Type,Type) -> Bool 
doOccursCheck (te1,TypeVarInt x)
        = case te1 of
              TypeVarInt y ->
                  if x == y then False else True
              TypeFun (texprs,texpr,fposn) ->
                  (and.map (\e -> doOccursCheck (e,TypeVarInt x))) (texpr:texprs)
              TypeDataType (dname,dins,dposn) ->
                  (and.map (\e -> doOccursCheck (e,TypeVarInt x))) dins
              TypeCodataType (dname,dins,dposn) ->
                  (and.map (\e -> doOccursCheck (e,TypeVarInt x))) dins
              TypeProd (prods,posn) ->
                  (and.map (\e -> doOccursCheck (e,TypeVarInt x))) prods    
              otherwise ->
                  True 
                     
               
match :: (Type,Type) -> Either ErrorMsg SubstList
match (t1,t2)
        = case (t1,t2) of   
              (TypeVarInt x,texpr) -> 
                  check (texpr,TypeVarInt x)
              (texpr,TypeVarInt x) ->
                  check (texpr,TypeVarInt x)
              (fexpr,gexpr)  -> 
                  case matchStructure (fexpr,gexpr) of
                      Right ziplist  -> do 
                           let eithList = map match ziplist
                               (ls,rs)  = partitionEithers eithList
                           case ls == [] of
                               True ->     
                                   return $ concat rs 
                               False -> 
                                    Left $ (concat.map (\x ->  x ++ "\n")) ls       
                      Left emsg -> 
                           Left emsg


{-
See if the structures can be unified.
if yes you are in luck otherwise time to get debugging buddy.
-}
matchStructure :: (Type,Type) -> Either ErrorMsg [(Type,Type)]
matchStructure (texpr1,texpr2)
        = case (texpr1,texpr2) of 
              (Unit _ ,Unit _) ->
                    return []

              (TypeFun (ins1,out1,posn1),TypeFun (ins2,out2,posn2)) ->
                   case length ins1 == length ins2 of
                       True -> 
                           return $ zip (out1:ins1) (out2:ins2)
                       False -> do 
                           let 
                              emsg = "\nWrong number of arguments used with function." 
                           Left emsg        

              (TypeDataType (dname1,dins1,dposn1),TypeDataType (dname2,dins2,dposn2)) ->
                   case dname1 == dname2 of 
                       True  -> do 
                           return $ zip dins1 dins2
                       False -> do 
                           let 
                             emsg = "\nExpected data type <<"
                                    ++ dname1 ++ ">> instead got <<" ++  dname2 ++ ">> "
                           Left emsg  

              (TypeCodataType (cname1,dins1,dposn1),TypeCodataType (cname2,dins2,dposn2)) ->
                   case cname1 == cname2 of 
                       True  -> do 
                           return $ zip dins1 dins2
                       False -> do 
                           let 
                             emsg = "\nExpected codata type "
                                    ++ cname1 ++ ">> instead got <<" ++  cname2 ++ ">>" 
                           Left emsg  

              (TypeProd (prods1,posn1),TypeProd (prods2,posn2)) -> do 
                   let 
                     len1 = length prods1
                     len2 = length prods2
                   case len1 == len2 of 
                       True  -> do 
                           return $ zip prods1 prods2
                       False -> do 
                           let 
                             emsg = "Expecting a tuple of length <<" ++ show len1 ++
                                    ">> instead got one with length <<" ++ 
                                     show len2 ++ ">>" 
                           Left emsg  

              (TypeConst (bt1,posn1),TypeConst (bt2,posn2)) ->
                   case bt1 == bt2 of 
                       True  -> 
                           return [] 
                       False -> do
                           let 
                             emsg = "Expecting the base types <<"
                                    ++ show bt1 ++ ">> instead got <<" 
                                    ++ show bt2 ++ ">>" 
                           Left emsg          

              otherwise -> do 
                  let 
                    emsg = "\nExpecting the type <<" ++ printType texpr1
                            ++ ">> instead got the type <<" ++ printType texpr2 ++ ">>"
                  Left emsg    


printType :: Type -> String 
printType sType = 
        case sType of
            Unit pn -> 
                "UNIT " 
            TypeDataType (dname,_,pn) -> 
                "DATA TYPE " ++ show dname 
            TypeCodataType (cdname,_,pn) ->
                "CODATA TYPE " ++ show cdname 
            TypeProd (_,pn) ->
                 "TUPLE " 
            TypeConst (btype,pn) ->
                 printConst btype 
            TypeVar (str,pn) ->
                 "VARIABLE "
            TypeVarInt _ -> 
                 "VARIABLE " 
            TypeFun (_,_,pn) ->
                 "FUN TYPE " 


coalesce ::  (Subst,SubstList) -> Either ErrorMsg SubstList
coalesce (subst,slist) = do 
        newSubstList <- coalesce_Evar (subst,slist)
        return newSubstList  



{-
This function does the following .
It take a substitution and a substitution list and does the following for each element 
of the substlist.
if the left variable of the subst and the element of substList matches ,
then the right exprs are matched to get a substitution list. otherwise
substitution is done in the lement of the substList with the right hand side of subst.
-}

coalesce_Evar :: (Subst,SubstList) -> Either ErrorMsg SubstList
coalesce_Evar (_,[]) = return []
coalesce_Evar (subst,s:ss) = do 
        newS  <- coalesce_helper subst s 
        newSS <- coalesce_Evar (subst,ss) 
        return $ (newS ++ newSS ) 
         

coalesce_helper :: Subst -> Subst -> Either ErrorMsg SubstList
coalesce_helper (x,t) (y,s)
        = case x == y of
              True -> 
                  match (t,s)
              False -> do 
                  let
                    subs_s = substInTExpr (x,t) s  
                  check (subs_s,TypeVarInt y)
                       

substInTExpr:: Subst -> Type -> Type
substInTExpr (x,t) texpr 
        = case texpr of 
              TypeVarInt y ->
                  if x == y then t else texpr

              TypeFun (tins,tout,posn) ->
                  TypeFun
                      (
                         (map (substInTExpr (x,t)) tins),
                         (substInTExpr (x,t) tout),
                         posn 
                       )  
              
              TypeDataType (dname,dins,dposn) ->
                  TypeDataType 
                      (
                        dname,
                        map (substInTExpr (x,t)) dins, 
                        dposn
                      )

              TypeCodataType (cname,dins,dposn) ->
                  TypeCodataType 
                      (
                        cname,
                        map (substInTExpr (x,t)) dins, 
                        dposn
                      )

              TypeProd (prods,pposn) -> 
                  TypeProd 
                     (
                      map (substInTExpr (x,t)) prods ,
                      pposn
                     )

              otherwise ->
                  texpr 

linearize_Cust :: SubstList -> ExistVars -> Either ErrorMsg (ExistVars,SubstList)
linearize_Cust [] evars
        = return (evars,[])  
linearize_Cust (s:ss) evars = do 
        intmt1 <- coalesce (s,ss)
        let 
          (newEvars,intmt11) = check_Reciproc evars intmt1
        (finEvars,intmt2) <- linearize_Cust intmt11 newEvars
        return $ (finEvars,(s:intmt2)) 


-- =============================================================
-- =============================================================
-- checking for things like (2,TVarInt 4) and (4,TVarInt 2)

remove_Reciproc :: SubstList -> SubstList
remove_Reciproc slist = snd (check_Reciproc [] slist)

check_Reciproc :: ExistVars -> SubstList -> (ExistVars,SubstList)
check_Reciproc evars slist
        = (nub finEvars,nub $ finSimp++notsimp)
     where    
       simp    = filter checkSimp slist     
       notsimp = slist \\ simp
       (finEvars,finSimp)
               = check_Reciproc_help simp evars []  
 

check_Reciproc_help :: SubstList ->  ExistVars -> SubstList -> (ExistVars,SubstList)
check_Reciproc_help [] evars finSList 
        = (evars,finSList)
check_Reciproc_help ((x,TypeVarInt y):rest) evars shuntList 
        = case elem (y,TypeVarInt x) rest of 
              True  -> 
                  check_Reciproc_help newRest newEvars ((x,TypeVarInt y):shuntList)
                where
                  newRest  = delete (y,TypeVarInt x) rest   
                  newEvars = (y:evars)
              False -> 
                  check_Reciproc_help rest evars ((x,TypeVarInt y):shuntList)


checkSimp :: Subst -> Bool
checkSimp (x,TypeVarInt y) = True
checkSimp _                = False  

-- =============================================================
-- =============================================================
            
