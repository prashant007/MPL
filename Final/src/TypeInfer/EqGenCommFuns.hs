module TypeInfer.EqGenCommFuns where

import TypeInfer.SymTabDataType
import TypeInfer.MPL_AST

import Control.Monad.State.Lazy
import Control.Monad.Trans.Either
import Data.List 

equalS = replicate 90 '='
stars  = replicate 90 '*'

getParamVars :: Type -> [String]
getParamVars typeP = nub (getTypeVars typeP)

getTypeVars :: Type -> [String]
getTypeVars sType 
        = case sType of 
              Unit pn -> 
                  []
              
              TypeDataType (_,types,pn) ->
                  concat $ map getTypeVars types 

              TypeCodataType (_,types,pn) ->
                  concat $ map getTypeVars types 

              TypeProd (types,pn) ->
                  concat $ map getTypeVars types 

              TypeConst _ ->
                  [] 

              TypeVar (t,pn) -> 
                  [t]

              TypeVarInt _ ->
                  []

              TypeFun (types,stype,pn) ->
                  concat $ map getTypeVars (stype:types)   

strToTVar :: [String] -> PosnPair -> [Type] 
strToTVar args dposn = map (\x -> TypeVar (x,dposn)) args

freeVars :: Type -> [Int]
freeVars texpr 
        = case texpr of
              TypeVarInt x -> 
                   [x]
              TypeFun (tins,tout,posn) ->
                   nub $ concat $ map freeVars (tout:tins)
              TypeDataType (name,dins,posn) ->
                   nub $ concat $ map freeVars dins 
              TypeCodataType (name,dins,posn) ->
                   nub $ concat $ map freeVars dins 
              TypeProd (types,pn) -> 
                   nub $ concat $ map freeVars types   
              otherwise ->
                   []   

printPosn :: PosnPair -> String
printPosn (line,col) = " at line,column (" ++ show line ++ "," ++ show col ++ ")"

-- ================================================================================
-- ================================================================================
-- ================================================================================

getDefnPosn :: Defn -> PosnPair
getDefnPosn defn 
        = case defn of  
              Data   (_,pn) ->
                  pn  
              Codata (_,pn) ->
                  pn 
              TypeSyn (_,pn) ->   
                  pn  
              ProtocolDefn   (_,pn) ->
                  pn  
              CoprotocolDefn (_,pn) ->
                  pn   
              FunctionDefn (_,_,_,pn) ->
                  pn  

              ProcessDefn  (_,_,_,pn) -> 
                  pn 

              TermSyn (_,_,pn) -> 
                  pn 
              OperatorDefn (_,_,pn) ->
                  pn               

getTypePosn :: Type -> PosnPair
getTypePosn cType 
        = case cType of 
              Unit pn -> pn 
              TypeDataType  (_,_,pn) -> pn 
              TypeCodataType(_,_,pn) -> pn 
              TypeProd  (_,pn)  -> pn 
              TypeConst (_,pn)  -> pn 
              TypeVar   (_,pn)  -> pn 
              TypeVarInt _      -> (0,0) 
              TypeFun   (_,_,pn)-> pn 



getTermPosn :: Term -> PosnPair
getTermPosn term 
        = case term of 
              TRecord list -> (\(a,b,c) -> c) (head list)
              TCallFun (_,_,pn) -> pn 
              TLet (_,_,pn)     -> pn 
              TVar (_,pn)       -> pn 
              TConst(_,pn)      -> pn 
              TIf (_,_,_,pn)    -> pn 
              TCase (_,_,pn)    -> pn 
              TFold (_,_,pn)    -> pn 
              TUnfold (_,_,pn)  -> pn 
              TCons (_,_,pn)    -> pn 
              TDest (_,_,pn)    -> pn 
              TProd (_,pn)      -> pn 
              TDefault pn       -> pn 

getPattPosn :: Pattern -> PosnPair
getPattPosn patt 
        = case patt of 
              ConsPattern (_,_,pn) -> pn 
              DestPattern (_,_,pn) -> pn 
              ProdPattern (_,pn)   -> pn  
              VarPattern  (_,pn)   -> pn 
              StrConstPattern(_,pn)-> pn 
              IntConstPattern(_,pn)-> pn  
              DontCarePattern pn   -> pn  
-- ================================================================================
-- ================================================================================
-- ================================================================================

 -- Take a type with TypeVar String and change the variables to TypeVarInt Int 
renameFunType :: FunType -> 
                 EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) FunType
renameFunType funType = do 
        case funType of 
            StrFType (uVars,ftype) -> do 
                uvarInts <- genNewVarList (length uVars)
                let 
                  substList = zip uVars uvarInts
                  newFType  = renameTVar substList ftype
                return $ IntFType (uvarInts,newFType)
            
            otherwise -> 
                return funType    


intTypeToStrType :: FunType -> Either ErrorMsg FunType
intTypeToStrType funType = do 
        case funType of 
            IntFType (uvars,fType) -> do 
                  let  
                     uVarsStrs = map (\x -> "T" ++ show x)
                                     [0,1..(length uvars-1)]
                     substList = zip uvars uVarsStrs 
                  case renameTVarInts substList fType of 
                      Just newFType -> 
                          return $ StrFType (uVarsStrs,newFType)
                      Nothing ->
                         Left $ ". Error renaming ::" ++ show funType     
            otherwise ->
                 return funType  

renameTVarInts :: [(Int,String)] -> Type -> Maybe Type 
renameTVarInts substList intType
        = case intType of 
              Unit pn -> 
                  return $
                      Unit pn 

              TypeDataType (name,dtypes,posn) -> do 
                  mDats <- mapM (renameTVarInts substList) dtypes
                  return $ 
                      TypeDataType (name,mDats,posn)

              TypeCodataType (name,dtypes,posn) -> do 
                  mCoDats <- mapM (renameTVarInts substList) dtypes
                  return $ 
                      TypeCodataType (name,mCoDats,posn)
              
              TypeProd (types,posn) -> do 
                  mProds <- mapM (renameTVarInts substList) types
                  return $ 
                      TypeProd (mProds,posn)  

              TypeConst (bType,posn) ->
                  return intType

              TypeVar (var,posn) ->
                  return $ 
                      TypeVar (var,posn)

              TypeVarInt num ->
                  case lookup num substList of 
                      Nothing ->
                          Nothing
                      Just sval -> 
                          return $
                              TypeVar(sval,(0,0))


              TypeFun (itypes,otype,posn) -> do 
                  miTypes <- mapM (renameTVarInts substList) itypes
                  moType  <- renameTVarInts substList otype
                  return $ 
                      TypeFun (
                                miTypes,
                                moType,
                                posn
                              )

renameTVar :: [(String,Int)] -> Type -> Type 
renameTVar substList typeflem   
        = case typeflem of
              Unit pn -> 
                  Unit pn 

              TypeDataType (name,dtypes,posn) ->
                  TypeDataType (name,map (renameTVar substList) dtypes,posn)

              TypeCodataType (name,dtypes,posn) ->
                  TypeCodataType (name,map (renameTVar substList) dtypes,posn)
              
              TypeProd (types,posn) ->
                  TypeProd (map (renameTVar substList) types,posn)  

              TypeConst (bType,posn) ->
                  typeflem

              TypeVar (var,posn) ->
                  case lookup var substList of 
                      Just varInt -> 
                          TypeVarInt varInt
                      Nothing ->
                          error "This means the universal var list for function type was not accurate."

              TypeVarInt num ->
                  typeflem

              TypeFun (itypes,otype,posn) ->
                  TypeFun (
                            map (renameTVar substList) itypes,
                            renameTVar substList otype,
                            posn
                          ) 

-- =====================================================================================
-- =====================================================================================


genNewVar :: EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) Int 
genNewVar = do
    (num,_,_,_) <- get 
    modify $ \(x,t,c,st) -> (x + 1,t,c,st)
    return num 

-- =====================================================================================
-- =====================================================================================


genNewVarList :: Int -> EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [Int]
genNewVarList 0 =
    return [] 
genNewVarList n = do 
    v  <- genNewVar 
    vs <- genNewVarList (n-1)
    return (v:vs)
