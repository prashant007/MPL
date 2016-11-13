module TypeInfer.Gen_Eqns_Helper_Patt where 

import TypeInfer.MPL_AST
import TypeInfer.SymTabDataType
import TypeInfer.SymTab 

import Control.Monad.State.Lazy
import Text.PrettyPrint.GenericPretty
import Text.PrettyPrint
import Data.List 
import Control.Monad.Trans.Either
import Data.Maybe 

genPattEquationsList ::[Pattern] -> [TypeThing] -> 
                       EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
genPattEquationsList [] [] 
        = return [] 
genPattEquationsList (t:ts) (nvar:rest) = do
        (_,_,context,_) <- get 
        modify $ \(n,v,c,st) -> (n,nvar,c,st)
        eqns <- genPattEqns t  
        eqnsList <- genPattEquationsList ts rest 
        return $ combineEqns (eqns++eqnsList)   

genPattEquationsList patts tthing = error $ "\n" ++ show patts ++ "\n" ++ show tthing

fold_Pattern :: ((String,[Pattern],PosnPair) -> b) ->
                ((String,[Pattern],PosnPair) -> b) ->
                (([Pattern],PosnPair) -> b) ->
                ((String,PosnPair) -> b) ->
                ((String,PosnPair) -> b) ->
                ((Int,PosnPair) -> b) ->
                (PosnPair -> b) ->
                Pattern -> b  

fold_Pattern pattCons pattDest pattprod pattvar pattconstStr pattconstInt pattdcare p  
        = case p of
              ConsPattern (str,patts,posn) ->
                  pattCons (str,patts,posn)
              
              DestPattern (str,patts,posn) ->
                  pattDest (str,patts,posn)

              ProdPattern (patts,posn) ->
                  pattprod (patts,posn)

              VarPattern (str,posn) ->
                  pattvar (str,posn)

              StrConstPattern (str,posn) ->
                 pattconstStr (str,posn)

              IntConstPattern(num,posn) ->
                 pattconstInt (num,posn) 

              DontCarePattern posn ->
                 pattdcare posn 


genPattEqns :: Pattern -> 
               EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
genPattEqns patt 
        = fold_Pattern funPattCons funPattDest funPattProd funPattVar 
                       funConstStringPattern funConstIntPattern 
                       funPattDCare patt   

-- =========================================================================================
-- ========================================================================================= 

funPattCons :: (String,[Pattern],PosnPair) -> 
               EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
funPattCons (consName,patts,posn) = do
        (_,typePattCons,context,symTab) <- get 
        let 
          eithVal = lookup_ST (Val_Cons (consName,posn)) symTab
        case eithVal of 
            Right retVal -> do 
                let 
                  ValRet_Cons ((datName,allConses),ftype,_,nargs)
                           = retVal 
                helperPattCons patts (consName,posn) (ftype,nargs)    
            Left emsg -> do 
                left emsg


helperPattCons :: [Pattern] -> (String,PosnPair)  -> (FunType,NumArgs) -> 
                  EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]

helperPattCons patts (consName,posn) (ftype,nargs) = do 
        (_,typePattCons,context,symTab) <- get 
        case nargs == length patts of
            True  -> do 
                renFunType <- renameFunType ftype 
                newVars    <- genNewVarList nargs
                pattEqns   <- genPattEquationsList patts newVars
                let 
                  (univVars,itypes,otype,sposn)
                          = stripFunType renFunType
                  outEqn  = TSimp (TypeVarInt typePattCons,otype)
                  inEqns  = zipWith (\x y -> TSimp (TypeVarInt y,x)) itypes newVars
                  finEqns = combineEqns 
                                ((TQuant ([],univVars++newVars) (outEqn:inEqns)):pattEqns)
                                   --(combineEqns(pattEqns ++ outEqn:inEqns)) 
                return finEqns 

            False -> do 
                let
                  emsg 
                    = "Constructor <<" ++ consName ++ ">> " ++ printPosn posn ++
                      "called with incorrect number of arguments.Expected " 
                       ++ show nargs ++ " ,got " ++ show (length patts)
                left emsg    

-- =========================================================================================
-- ========================================================================================= 

funPattDest :: (String,[Pattern],PosnPair) -> 
               EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
funPattDest (consName,patts,posn) = do
        (_,_,context,symTab) <- get 
        let 
          eithVal = lookup_ST (Val_Dest (consName,posn)) symTab
        case eithVal of
            Right retVal -> do 
                let 
                  ValRet_Dest ((codatName,allDests),ftype,nargs)
                           = retVal 
                helperPattDest patts (consName,posn) (ftype,nargs)
            Left emsg ->
                left emsg            


helperPattDest :: [Pattern] -> (String,PosnPair) -> (FunType,NumArgs) -> 
                  EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
                                  

helperPattDest patts (destName,posn) (funType,nargs) = do 
        (_,typePattDest,context,symTab) <- get 
        case nargs-1 == length patts of
            True  -> do 
                renFunType <- renameFunType funType 
                newVars    <- genNewVarList (nargs-1)
                pattEqns   <- genPattEquationsList patts newVars
                let 
                  (univVars,itypes,otype,sposn)
                            = stripFunType renFunType
                  iTypesWORec
                            = init itypes 
                  tFunSTab  = TypeFun (itypes,otype,sposn)
                  dEqn      = TSimp (TypeVarInt typePattDest,tFunSTab)
                  inEqns    = zipWith (\x y -> TSimp (TypeVarInt x,y)) newVars iTypesWORec
                  finEqn    = TQuant ([],univVars++newVars) 
                                     (dEqn:(inEqns ++ pattEqns)) 
                return [finEqn]                    

            False -> do 
                let
                  emsg 
                    = "Destructor <<" ++ destName ++ ">> " ++ printPosn posn ++
                      "called with incorrect number of arguments.Expected " 
                       ++ show nargs ++ " ,got " ++ show (length patts)
                left emsg 

stripFunType :: FunType -> ([Int],[Type],Type,PosnPair)
stripFunType funType 
        = case funType of 
              IntFType (uvars,ifunType) -> 
                  case ifunType of
                      TypeFun (itypes,otype,posn) ->
                          (uvars,itypes,otype,posn)
                      otherwise ->
                          error $ show funType 

              otherwise ->
                  error $ "Not expecting a function type like this::" ++ show funType     

-- =========================================================================================
-- ========================================================================================= 
funPattProd :: ([Pattern],PosnPair) ->
               EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
funPattProd (patts,posn) = do  
        (_,typePattProd,context,symTab) <- get  
        newVars  <- genNewVarList (length patts)
        pattEqns <- genPattEquationsList patts newVars 
        let
          prodEqn = TSimp (TypeVarInt typePattProd,TypeProd (map TypeVarInt newVars,posn))  
          finEqn  = TQuant ([],newVars) (combineEqns (prodEqn:pattEqns)) 
        return [finEqn]                      
-- =========================================================================================
-- ========================================================================================= 
--update the context with the variable
funPattVar :: (String,PosnPair) ->
              EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]  
funPattVar (str,posn) = do 
        (_,typePattVar,context,symTab) <- get 
        let 
          newContext = insertCtxt (str,TypeVarInt typePattVar) context
        modify $ \(n,tt,c,st) -> (n,tt,newContext,st)
        return []  


insertCtxt :: (String,Type) -> Context -> Context
insertCtxt (str,ctype) []
        = [[(str,ctype)]]
insertCtxt (str,ctype) (c:cs)
        = ((str,ctype):c):cs  

                         

-- =========================================================================================
-- ========================================================================================= 
funConstStringPattern :: (String,PosnPair) -> 
                   EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn] 
funConstStringPattern (constStr,posn) = do 
        (_,typePattConst,context,symTab) <- get 
        let 
          eqn = TSimp (TypeVarInt typePattConst,TypeConst (BaseString,posn))
        return [eqn]  

-- =========================================================================================
-- ========================================================================================= 
funConstIntPattern :: (Int,PosnPair) -> 
                   EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn] 
funConstIntPattern (constStr,posn) = do 
        (_,typePattConst,context,symTab) <- get 
        let 
          eqn = TSimp (TypeVarInt typePattConst,TypeConst (BaseInt,posn))
        return [eqn]  

-- =========================================================================================
-- ========================================================================================= 
funPattDCare :: PosnPair -> EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) [TypeEqn]
funPattDCare posn = do  
        return []

-- =========================================================================================
-- ========================================================================================= 

getFunVar :: FunType -> ([String],Type)
getFunVar (StrFType (uVars,ftype)) = (uVars,ftype)


-- This function returns the list of all global variables ,
-- fold function types for all the constructors as well the output
-- type of the fold function which is the same for all the fold functions
-- of a data type.

renameFunsTypes :: [FunType] -> 
                  EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) 
                                   ([Int],[Type],Type)
renameFunsTypes funs = do 
        (allVars,alltypes,otype) <- rnmFTypesHelp funs
        uvarInts <- genNewVarList (length allVars)  
        let 
          substList = zip allVars uvarInts
          allIntTypes
                    = map (renameTVar substList) alltypes 
          oIntType  = renameTVar substList otype
        return (uvarInts,allIntTypes,oIntType)  
                   

rnmFTypesHelp :: [FunType] -> 
                  EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) 
                                   ([String],[Type],Type)
rnmFTypesHelp allFuns = do 
        let 
          allVars   = (nub.concat.map (fst.getFunVar)) allFuns
          alltypes  = (map (snd.getFunVar)) allFuns
          (_,oType) = getOutFnType (head alltypes)
        return (allVars,alltypes,oType)

getOutFnType :: Type -> ([Type],Type) 
getOutFnType (TypeFun (ins,out,pn)) = (ins,out) 



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
                                   

-- ===================================================================================
-- ===================================================================================
combineEqns :: [TypeEqn] -> [TypeEqn]
combineEqns totEqns
        = case  noQuantEqns totEqns of 
              True  ->
                  totEqns
              False ->
                  combineEqnsHelper totEqns ([],[],[])

combineEqnsHelper :: [TypeEqn] -> (UniVars,ExistVars,[TypeEqn]) -> [TypeEqn]
combineEqnsHelper [] (suv,sev,steqns)
        = [TQuant (suv,sev) steqns]
combineEqnsHelper (eqn:eqns) (suv,sev,steqns)  
        = case eqn of 
             TSimp simpEqn ->
                 combineEqnsHelper eqns (suv,sev,(steqns ++ [TSimp simpEqn]))
             TQuant (uvars,evars) eqlist ->
                 combineEqnsHelper eqns (suv++uvars,sev++evars,steqns++eqlist) 

-- return True if there is no Quant eqn
noQuantEqns :: [TypeEqn] -> Bool 
noQuantEqns eqns 
        = case (filter isQuantEqn eqns) of 
              [] -> 
                  True
              _  ->
                  False    

isQuantEqn :: TypeEqn -> Bool
isQuantEqn eqn 
        = case eqn of 
              TQuant _ _ ->
                  True
              TSimp _ ->
                  False   
