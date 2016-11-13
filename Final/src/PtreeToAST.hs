module PtreeToAST where

import AbsMPL
import qualified TypeInfer.MPL_AST as M 
import Control.Monad.State.Lazy
import Data.List

transTokUnit :: TokUnit -> M.PosnPair
transTokUnit x = case x of 
   TokUnit string -> fst string  

transTokDefn :: TokDefn -> M.PosnPair
transTokDefn x = case x of
  TokDefn string -> fst string

transTokRun :: TokRun -> M.PosnPair
transTokRun x = case x of
  TokRun string -> fst string

transTokTerm :: TokTerm -> M.PosnPair
transTokTerm x = case x of
  TokTerm string -> fst string

transTokData :: TokData -> M.PosnPair
transTokData x = case x of
  TokData string -> fst string

transTokCodata :: TokCodata -> M.PosnPair
transTokCodata x = case x of
  TokCodata string -> fst string

transTokType :: TokType -> M.PosnPair
transTokType x = case x of
  TokType string -> fst string

transTokProtocol :: TokProtocol -> M.PosnPair
transTokProtocol x = case x of
  TokProtocol string -> fst string

transTokCoprotocol :: TokCoprotocol -> M.PosnPair
transTokCoprotocol x = case x of
  TokCoprotocol string -> fst string

transTokGetProt :: TokGetProt -> M.PosnPair
transTokGetProt x = case x of
  TokGetProt string -> fst string

transTokPutProt :: TokPutProt -> M.PosnPair
transTokPutProt x = case x of
  TokPutProt string -> fst string

transTokNeg :: TokNeg -> M.PosnPair
transTokNeg x = case x of
  TokNeg string -> fst string

transTokTop :: TokTop -> M.PosnPair
transTokTop x = case x of
  TokTop string -> fst string

transTokBot :: TokBot -> M.PosnPair
transTokBot x = case x of
  TokBot string -> fst string

transTokFun :: TokFun -> M.PosnPair
transTokFun x = case x of
  TokFun string -> fst string

transTokDefault :: TokDefault -> M.PosnPair
transTokDefault x = case x of
  TokDefault string -> fst string

transTokRecord :: TokRecord -> M.PosnPair
transTokRecord x = case x of
  TokRecord string -> fst string

transTokLet :: TokLet -> M.PosnPair
transTokLet x = case x of
  TokLet string -> fst string

transTokIf :: TokIf -> M.PosnPair
transTokIf x = case x of
  TokIf string -> fst string

transTokFold :: TokFold -> M.PosnPair
transTokFold x = case x of
  TokFold string -> fst string

transTokUnfold :: TokUnfold -> M.PosnPair
transTokUnfold x = case x of
  TokUnfold string -> fst string

transTokCase :: TokCase -> M.PosnPair
transTokCase x = case x of
  TokCase string -> fst string

transTokProc :: TokProc -> M.PosnPair
transTokProc x = case x of
  TokProc string -> fst string

transTokClose :: TokClose -> M.PosnPair
transTokClose x = case x of
  TokClose string -> fst string

transTokHalt :: TokHalt -> M.PosnPair
transTokHalt x = case x of
  TokHalt string -> fst string

transTokGet :: TokGet -> M.PosnPair
transTokGet x = case x of
  TokGet string -> fst string

transTokPut :: TokPut -> M.PosnPair
transTokPut x = case x of
  TokPut string -> fst string

transTokHCase :: TokHCase -> M.PosnPair
transTokHCase x = case x of
  TokHCase string -> fst string

transTokHPut :: TokHPut -> M.PosnPair
transTokHPut x = case x of
  TokHPut string -> fst string

transTokSplit :: TokSplit -> M.PosnPair
transTokSplit x = case x of
  TokSplit string -> fst string

transTokFork :: TokFork -> M.PosnPair
transTokFork x = case x of
  TokFork string -> fst string

transUIdent :: UIdent -> (M.PosnPair,String)
transUIdent x = case x of
  UIdent string -> string

transPIdent :: PIdent -> (M.PosnPair,String)
transPIdent x = case x of
  PIdent string -> string

{-
transInfixRem :: InfixRem -> (M.PosnPair,String)
transInfixRem x = case x of
  InfixRem string -> string
-}

transTokString :: TokString -> (M.PosnPair,String)
transTokString x = case x of 
  TokString (posn,name) -> (posn,(tail.init)name)

transPInteger :: PInteger -> (M.PosnPair,Int)
transPInteger x = case x of 
  PInteger (posn,integer) -> (posn,read integer::Int)  

transTokDCare :: TokDCare -> M.PosnPair
transTokDCare x = case x of 
  TokDCare (posn,str) -> posn  


transMPL :: MPL -> State [(String,[M.Name])] [M.Stmt]
transMPL x = case x of
  MPLPROG mplstmts runstmt -> undefined
  MPLTest mplstmts -> mapM transMPLstmt mplstmts

transInfix0op :: Infix0op -> M.FuncName
transInfix0op x = case x of
  Infix0op string -> detectFun "orB" 

transInfix1op :: Infix1op -> M.FuncName
transInfix1op x = case x of
  Infix1op string -> detectFun "andB"

transInfix2op :: Infix2op -> M.FuncName
transInfix2op x = case x of
  Infix2op string -> case string of 
        "==" -> detectFun "eqI"
        "/=" -> detectFun "notEqI"
        "<"  -> detectFun "leqI"
        ">"  -> detectFun "geqI" 
        "<=" -> detectFun "leqI"
        ">=" -> detectFun "geqI"
        otherwise -> error $ "wrong symbol::" ++ string
      

transInfix3op :: Infix3op -> M.FuncName
transInfix3op x = case x of
  Infix3op string -> detectFun "concat"

transInfix4op :: Infix4op -> M.FuncName
transInfix4op x = case x of
  Infix4op string -> case string of 
      "+" -> detectFun "addI"
      "-" -> detectFun "subI"
      otherwise -> error $ "wrong symbol::" ++ string

transInfix5op :: Infix5op -> M.FuncName
transInfix5op x = case x of
  Infix5op string -> case string of 
      "*"    -> detectFun "mulI"
      "/"    -> detectFun "quotI"
      "%"    -> detectFun "remI"
      "div"  -> detectFun "quotI"
      "rem"  -> detectFun "remI"
      "quot" -> detectFun "quotI"
      otherwise -> error $ "wrong symbol::" ++ string

transInfix6op :: Infix6op -> M.FuncName
transInfix6op x = case x of
  Infix6op string -> case string of
      "^" -> detectFun "powI" 
      otherwise -> error $ "wrong symbol::" ++ string

transInfix7op :: Infix7op -> M.FuncName
transInfix7op x = case x of
  Infix7op string -> case string of
      "!!" -> detectFun "index" 
      otherwise -> error $ "wrong symbol::" ++ string

-- ================================================================================
-- ================================================================================
-- ================================================================================
getDefnPosn :: M.Defn -> M.PosnPair
getDefnPosn defn 
        = case defn of  
              M.Data   (_,pn) ->
                  pn  
              M.Codata (_,pn) ->
                  pn 
              M.TypeSyn (_,pn) ->   
                  pn  
              M.ProtocolDefn   (_,pn) ->
                  pn  
              M.CoprotocolDefn (_,pn) ->
                  pn   
              M.FunctionDefn (_,_,_,pn) ->
                  pn  

              M.ProcessDefn  (_,_,_,pn) -> 
                  pn 

              M.TermSyn (_,_,pn) -> 
                  pn 
              M.OperatorDefn (_,_,pn) ->
                  pn               

getTypePosn :: M.Type -> M.PosnPair
getTypePosn cType 
        = case cType of 
              M.Unit pn -> pn 
              M.TypeDataType  (_,_,pn) -> pn 
              M.TypeCodataType(_,_,pn) -> pn 
              M.TypeProd  (_,pn)  -> pn 
              M.TypeConst (_,pn)  -> pn 
              M.TypeVar   (_,pn)  -> pn 
              M.TypeVarInt _      -> (0,0) 
              M.TypeFun   (_,_,pn)-> pn 



getTermPosn :: M.Term -> M.PosnPair
getTermPosn term 
        = case term of 
              M.TRecord list -> (\(a,b,c) -> c) (head list)
              M.TCallFun (_,_,pn) -> pn 
              M.TLet (_,_,pn)     -> pn 
              M.TVar (_,pn)       -> pn 
              M.TConst(_,pn)      -> pn 
              M.TIf (_,_,_,pn)    -> pn 
              M.TCase (_,_,pn)    -> pn 
              M.TFold (_,_,pn)    -> pn 
              M.TUnfold (_,_,pn)  -> pn 
              M.TCons (_,_,pn)    -> pn 
              M.TDest (_,_,pn)    -> pn 
              M.TProd (_,pn)      -> pn 
              M.TDefault pn       -> pn 

getPattPosn :: M.Pattern -> M.PosnPair
getPattPosn patt 
        = case patt of 
              M.ConsPattern (_,_,pn) -> pn 
              M.DestPattern (_,_,pn) -> pn 
              M.ProdPattern (_,pn)   -> pn  
              M.VarPattern  (_,pn)   -> pn 
              M.StrConstPattern(_,pn)-> pn 
              M.IntConstPattern(_,pn)-> pn  
              M.DontCarePattern pn   -> pn  
-- ================================================================================
-- ================================================================================
-- ================================================================================

transMPLstmt :: MPLstmt -> State [(String,[M.Name])] M.Stmt
transMPLstmt x = case x of
  WHEREDEFN tokdefn defns mplstmtalts -> do 
      tDefns    <- mapM transDefn defns
      tMPLStmts <- mapM transMPLstmtAlt mplstmtalts
      return $ M.DefnStmt (tDefns,tMPLStmts,transTokDefn tokdefn)

  WOWHEREDEFN tokdefn defns -> do 
      tDefns <- mapM transDefn defns
      return $ M.DefnStmt (tDefns,[],transTokDefn tokdefn)

  BAREDEFN defn -> do 
      tDefn <- transDefn defn 
      return $ M.DefnStmt ([tDefn],[],getDefnPosn tDefn)

-- ================================================================================

transMPLstmtAlt :: MPLstmtAlt -> State [(String,[M.Name])] M.Stmt
transMPLstmtAlt x = case x of
  MPLSTMTALT mplstmt -> do 
      transMPLstmt mplstmt

-- ================================================================================

transRUNstmt :: RUNstmt -> State [(String,[M.Name])] M.Stmt
transRUNstmt x = case x of
  RUNSTMTWITHType tokrun protocols1 protocols2 channels1 channels2 process -> undefined 
     {-
      A.RunStmt (
                  Just ([],map transProtocol protocols1,map transProtocol protocols2),
                  (map transChannel channels1),(map transChannel channels2),
                  transProcess process,transTokRun tokrun
                )
     -}

  RUNSTMTWITHTOUType tokrun channels1 channels2 process -> undefined
     {-
      A.RunStmt (
                  Nothing,  
                  (map transChannel channels1),(map transChannel channels2),
                  transProcess process,transTokRun tokrun
                )
     -}

-- ================================================================================

transDefn :: Defn -> State [(String,[M.Name])] M.Defn 
transDefn x = case x of
  TYPEDEF typedefn -> 
      transTypeDefn typedefn 

  PROTOCOLDEF ctypedefn -> 
      transCTypeDefn ctypedefn

  FUNCTIONDEF functiondefn -> do 
      let
         nmList = getFunctionDefnName functiondefn
      dupCheck <- insertNamesInList ("function",nmList)
      case dupCheck of 
          Nothing -> 
              transFunctionDefn functiondefn
          Just errormsg -> 
               error $ unlines [
                                 "\n",M.equalS,M.equalS,"*********Error*********",
                                 errormsg,M.equalS,M.equalS
                               ]

  --OPERATORDEF operatordefn -> 
  --    return $ transOperatorDefn operatordefn

  PROCESSDEF processdef -> 
      transProcessDef processdef

  --TERMSYNDEF termsynonym -> 
  --    return $ transTermSynonym termsynonym

-- ================================================================================

{-
transOperatorDefn :: OperatorDefn -> M.Defn 
transOperatorDefn x = case x of
  INFIX_LEFT infixrem integer -> 
      M.OperatorDefn (nm,
                      Left $ fromInteger integer,
                      posn 
                     )
          where
            (posn,nm) = transInfixRem infixrem

  INFIX_RIGHT infixrem integer -> 
      M.OperatorDefn (
                      nm,
                      Right $ fromInteger integer,
                      posn
                     )
          where
            (posn,nm) = transInfixRem infixrem


transTermSynonym :: TermSynonym -> M.Defn 
transTermSynonym x = case x of
  TERM_SYNONYM tokterm pident1 infixrem pident2 pident3 pident4 pident5 -> 
      M.TermSyn ( 
                  (snd $ transPIdent pident1,snd $ transInfixRem infixrem,snd $ transPIdent pident2),
                  (snd $ transPIdent pident3,snd $ transPIdent pident4,snd $ transPIdent pident5),
                  transTokTerm tokterm
                )

-}

getDClauseName :: M.DataClause -> M.Name 
getDClauseName (M.DataName (dnm,_),_) = dnm 

insertNamesInList :: (String,[M.Name]) -> State [(String,[M.Name])] (Maybe M.ErrorMsg)
insertNamesInList (ttype,insnmList) = do 
        list <- get 
        case lookup ttype list of 
            Nothing -> do 
                let 
                   newList = (ttype,insnmList):list 
                modify $ \l -> newList
                return Nothing
            Just nmList -> do 
                let 
                  commNms = intersect nmList insnmList
                case commNms == []  of 
                    False  -> do 
                        return $ 
                            Just $ "\nFollowing <<" ++ ttype ++ 
                                   ">> have been defined multiple times.\n" ++
                                   concat (map (\x -> x ++ "\n") commNms) 
                    True -> do 
                        let 
                           oldList   = delete (ttype,nmList) list 
                           newList   = (ttype,nmList ++ insnmList):oldList
                        modify $ \l -> newList
                        return Nothing    




transTypeDefn :: TypeDefn -> State [(String,[M.Name])] M.Defn 
transTypeDefn x = case x of
  DATA tokdata dataclauses -> do 
       tdclauses <- mapM transDataClause dataclauses
       let 
         dnames = map getDClauseName tdclauses
       dupCheck <- insertNamesInList ("data type",dnames)
       case dupCheck  of 
           Nothing ->  
               return $ M.Data (tdclauses,transTokData tokdata)   
           Just errormsg -> 
               error $ unlines [
                                 "\n",M.equalS,M.equalS,"*********Error*********",
                                 errormsg,M.equalS,M.equalS
                               ]


  CODATA tokcodata codataclauses -> do 
      tdclauses <- mapM transCoDataClause codataclauses
      let 
        cdnames   = map getDClauseName tdclauses
      dupCheck <- insertNamesInList ("codata type",cdnames)
      case dupCheck of 
          Nothing ->
              return $ M.Codata (tdclauses,transTokCodata tokcodata)
          Just errormsg ->
               error $ unlines [
                                 "\n",M.equalS,M.equalS,"*********Error*********",
                                 errormsg,M.equalS,M.equalS
                               ]
  TYPE toktype typespecs type_ -> do 
      ttype <- transType type_
      let 
        tSpecs = map (fst.transTypeSpec) typespecs
        tsynms = map (\x -> (x,ttype)) tSpecs 
      return $ M.TypeSyn (tsynms,transTokType toktype) 



-- ==================================================================
-- ==================================================================

transDataClause :: DataClause -> State [(String,[M.Name])] M.DataClause 
transDataClause x = case x of
  DATACLAUSE typespec uident dataphrases -> do 
       let 
         (dposn,datAlt)
                = transUIdent uident
         datName  = M.DataName (transTypeSpec typespec)
         datType  = dNametoDType datName dposn        
       datPhrs <- mapM transDataPhrase dataphrases
       let 
          finDphrs = changeDataPhrList (datAlt,datType) (concat datPhrs)
       return (datName,finDphrs)


{-
here replace the simple string with the dataName
-}
errorMsg :: M.PosnPair -> String
errorMsg (line,col) = "at line,col (" ++ show line ++ ", " ++ show col ++ ")"

changeDataPhrList :: (String,M.Type) -> [(M.Name,[M.Type],String,M.NumArgs,M.PosnPair)] -> 
                     [M.DataPhrase]
changeDataPhrList subst = map (changeDataPhr subst) 

changeDataPhr :: (String,M.Type) -> (M.Name,[M.Type],String,M.NumArgs,M.PosnPair) ->
                 M.DataPhrase
changeDataPhr subst@(str,typeDat) (consName,inTypes,outName,nargs,pn)
        = case outName == str of 
              True  ->
                  (consName,fType,nargs)
                where
                  oType   = typeDat
                  iTypes  = replaceTypes subst inTypes
                  funType = M.TypeFun (iTypes,oType,pn)
                  pVars   = M.getParamVars funType
                  fType   = M.StrFType (pVars,funType)

              False -> do 
                  let 
                    emsg = "Expected <<" ++ str ++ ">> as the output type of <<" ++ 
                            consName ++ " >> but got << " ++ outName ++ ">> " ++ 
                            errorMsg pn 
                  error $ unlines [
                                    "\n",M.equalS,M.equalS,"*********Error*********",
                                    emsg,M.equalS,M.equalS
                                   ]

                     



dNametoDType :: M.DataName -> M.PosnPair -> M.Type 
dNametoDType (M.DataName (dname,args)) dposn
        = M.TypeDataType (dname,strToTVar args dposn,dposn)

strToTVar :: [String] -> M.PosnPair -> [M.Type] 
strToTVar args dposn = map (\x -> M.TypeVar (x,dposn)) args 

replaceTypes :: (String,M.Type) -> [M.Type] -> [M.Type]
replaceTypes subst types = map (replaceType subst) types 

replaceType :: (String,M.Type) -> M.Type -> M.Type 
replaceType subst@(str,datType) fType 
        = case fType of 
              M.Unit pn ->
                  M.Unit pn 

              M.TypeDataType (name,types,pn) ->
                  M.TypeDataType (name,map (replaceType subst) types,pn)

              M.TypeCodataType (name,types,pn) ->
                  M.TypeCodataType (name,map (replaceType subst) types,pn)

              M.TypeProd (types,pn) ->
                  M.TypeProd (map (replaceType subst) types,pn)

              M.TypeConst (bType,pn) ->
                  fType

              M.TypeVar   (var,pn) ->
                  case var == str of 
                      True  ->
                          datType
                      False ->
                          fType

              M.TypeVarInt num ->
                  fType

              M.TypeFun(types,typeF,pn) ->
                  M.TypeFun (map (replaceType subst) types,replaceType subst typeF,pn)              


-- ================================================================================
-- ================================================================================
-- ================================================================================

dNametoCDType :: M.DataName -> M.PosnPair -> M.Type 
dNametoCDType (M.DataName (dname,args)) dposn
        = M.TypeCodataType (dname,strToTVar args dposn,dposn)

transCoDataClause :: CoDataClause -> State [(String,[M.Name])] M.DataClause
transCoDataClause x = case x of
  CODATACLAUSE uident typespec codataphrases -> do 
       let 
         (dposn,datAlt)
                = transUIdent uident
         cdatName = M.DataName (transTypeSpec typespec)  
         datType  = dNametoCDType cdatName dposn
       cdarPhrs <- mapM transCoDataPhrase codataphrases
       let
         finCDphrs = changeCodataPhrList (datAlt,datType) 
                                         (concat cdarPhrs)
       return (cdatName,finCDphrs)



changeCodataPhrList :: (String,M.Type) -> [(M.Name,[M.Type],M.Type,M.NumArgs,M.PosnPair)] ->
                       [M.DataPhrase] 
changeCodataPhrList subst  = map (changeCodataPhr subst) 


changeCodataPhr :: (String,M.Type) -> (M.Name,[M.Type],M.Type,M.NumArgs,M.PosnPair) ->
                   M.DataPhrase
changeCodataPhr subst@(str,typeCodat) (destName,inTypes,outType,nargs,pn)
        = case (getStrFromTypeVar (last inTypes) == str) of    
              True  ->
                  (destName,fType,nargs)
                where
                  oType   = replaceType subst outType
                  iTypes  = replaceTypes subst inTypes
                  funType = M.TypeFun (iTypes,oType,pn)
                  pVars   = M.getParamVars funType
                  fType   = M.StrFType (pVars,funType)

              False -> do 
                  let 
                    errormsg =   
                        "Expected <<" ++ str ++ ">> as the destructor name but instead got <<"
                        ++ getStrFromTypeVar (last inTypes) ++ ">>."
                  error $ unlines [
                                    "\n",M.equalS,M.equalS,"*********Error*********",
                                    errormsg,M.equalS,M.equalS
                                   ]


transDataPhrase :: DataPhrase -> 
                   State [(String,[M.Name])] 
                         [(M.Name,[M.Type],String,M.NumArgs,M.PosnPair)]
transDataPhrase x = case x of
  DATAPHRASE structors types uident -> do 
          tTypes <- mapM transType types 
          let 
            nargs    = length tTypes
            tStructs = map transStructor structors 
            consNames= map snd tStructs
            tident   = snd $ transUIdent uident
            qList    = map (\(pn,t) -> (t,tTypes,tident,nargs,pn)) tStructs
          dupCheck <- insertNamesInList ("data type",consNames)
          case dupCheck of 
              Just errormsg ->
                 error $
                  unlines [
                           "\n",M.equalS,M.equalS,"*********Error*********",
                           errormsg,M.equalS,M.equalS
                          ] 
              Nothing -> 
                  return qList




transCoDataPhrase :: CoDataPhrase -> 
                    State [(String,[M.Name])]
                          [(M.Name,[M.Type],M.Type,M.NumArgs,M.PosnPair)]
transCoDataPhrase x = case x of
  CODATAPHRASE structors types stype -> do 
          tTypes <- mapM transType types 
          tOut   <- transType stype
          let 
            nargs    = length tTypes
            tStructs = map transStructor structors 
            destNames= map snd tStructs
            qList    = map (\(pn,t) -> (t,tTypes,tOut,nargs,pn)) tStructs  
          dupCheck <- insertNamesInList ("codata type",destNames)
          case dupCheck of 
              Just errormsg ->
                 error $
                  unlines [
                           "\n",M.equalS,M.equalS,"*********Error*********",
                           errormsg,M.equalS,M.equalS
                          ] 
              Nothing -> 
                  return qList
            
          
getStrFromTypeVar :: M.Type -> String 
getStrFromTypeVar x  
        = case x of 
              (M.TypeVar (str,posn)) -> 
                  str 
              otherwise -> do 
                  let 
                    errormsg = 
                        "Was expecting a type variable corresponding to the data type "
                        ++ errorMsg (getTypePosn x)
                  error $ unlines [
                                    "\n",M.equalS,M.equalS,"*********Error*********",
                                     errormsg,M.equalS,M.equalS
                                   ]

transStructor :: Structor -> (M.PosnPair,String)
transStructor x = case x of
  STRUCTOR uident -> 
      transUIdent uident

transTypeSpec :: TypeSpec -> (M.Name,[M.Param])
transTypeSpec x = case x of
  TYPESPEC_param uident typeparams -> 
      (
        snd $ transUIdent uident,
        map transTypeParam typeparams
      )

  TYPESPEC_basic uident -> 
      (
        snd $ transUIdent uident,
        []
      )

transTypeParam :: TypeParam -> M.Param
transTypeParam x = case x of
  TYPEPARAM uident -> snd (transUIdent uident)

-- ================================================================================
-- ================================================================================
-- ================================================================================



transType :: Type ->  State [(String,[M.Name])] M.Type 
transType x = case x of
  TYPEARROW typen stype -> do 
       inT  <- transTypeN typen 
       out  <- transType stype
       let 
         cdatTy = M.TypeCodataType ("Exp",[inT,out],getTypePosn inT)
       return cdatTy 

  TYPENext typen -> 
      transTypeN typen 

transTypeN :: TypeN -> State [(String,[M.Name])] M.Type 
transTypeN x = case x of
  TYPEUNIT tokunit -> do
      return $ M.Unit (transTokUnit tokunit)  

  TYPELIST typen -> do
      tTypen <- transTypeN typen 
      return $ M.TypeDataType ("List",[tTypen],getTypePosn tTypen) 

  TYPEDATCODAT uident types -> do 
      list <- get 
      let 
        (posn,name) = transUIdent uident
        newList     = transformList list  
      tTypes <- mapM transType types
      case lookup name newList of    
          Just category ->  
              case category == "data type" of 
                  True  -> 
                      return $ M.TypeDataType (name,tTypes,posn)
                  False -> 
                      return $ M.TypeCodataType (name,tTypes,posn)  
          Nothing  -> do 
              let 
                 errormsg =
                      "\nTrying to use a data or codata <<" ++ name ++
                      ">> that hasn't been defined, "
                      ++ errorMsg posn ++ "\n" 
              error $ unlines [
                                "\n",M.equalS,M.equalS,"*********Error*********",
                                errormsg,M.equalS,M.equalS
                              ]


  TYPECONST_VAR uident -> do 
      list <- get 
      let 
        (posn,name)
                = transUIdent uident
        newList = transformList list 
        tType   = fromStrToType (posn,name)
      case lookup name newList of    
          Just category ->  
              case category of 
                 "data type"  ->  
                     return $ M.TypeDataType (name,[],posn)
                 "codata type"-> 
                     return $ M.TypeCodataType (name,[],posn)
                 otherwise   -> 
                     return tType
          
          Nothing ->            
              return tType

  TYPEPROD types -> do 
      cTypes <- mapM transType types 
      let 
        tposn = getTypePosn (head cTypes)
      return $ M.TypeProd (cTypes,tposn) 

  TYPEBRACKET stype -> do 
      transType stype



fromStrToType :: (M.PosnPair,String) -> M.Type 
fromStrToType (posn,str) 
        | str == "Int"    = M.TypeConst (M.BaseInt,posn)
        | str == "Double" = M.TypeConst (M.BaseDouble,posn)
        | str == "Char"   = M.TypeConst (M.BaseChar,posn)
        | str == "String" = M.TypeConst (M.BaseString,posn)
        | otherwise       = M.TypeVar (str,posn)
       

transformList :: [(String,[M.Name])] -> [(M.Name,String)]
transformList [] 
        = []
transformList ((str,names):rest) 
        = (map (\x -> (x,str)) names) ++
          (transformList rest)     

-- ================================================================================
-- ================================================================================
-- ================================================================================

transCTypeDefn _ = undefined
{-  
transCTypeDefn :: CTypeDefn -> Result
transCTypeDefn x = case x of
  PROTOCOL tokprotocol protocolclauses -> 
  COPROTOCOL tokcoprotocol coprotocolclauses -> 
transProtocolClause :: ProtocolClause -> Result
transProtocolClause x = case x of
  PROTOCOLCLAUSE protocoltypespec uident protocolphrases -> 
transCoProtocolClause :: CoProtocolClause -> Result
transCoProtocolClause x = case x of
  COPROTOCOLCLAUSE uident protocoltypespec coprotocolphrases -> 
transProtocolTypeSpec :: ProtocolTypeSpec -> Result
transProtocolTypeSpec x = case x of
  PROTOCOLTYPESPEC_param uident typeparams protocolparams -> 
  PROTOCOLTYPESPEC_noparam uident -> 
transProtocolParam :: ProtocolParam -> Result
transProtocolParam x = case x of
  PROTOCOLPARAM uident -> 
transProtocolPhrase :: ProtocolPhrase -> Result
transProtocolPhrase x = case x of
  PROTOCOLPHRASE eventhandles protocol uident -> 
transCoProtocolPhrase :: CoProtocolPhrase -> Result
transCoProtocolPhrase x = case x of
  COPROTOCOLPHRASE eventhandles uident protocol -> 
transEventHandle :: EventHandle -> Result
transEventHandle x = case x of
  EVENTHANDLER uident -> 
transEventHandleHPUT :: EventHandleHPUT -> Result
transEventHandleHPUT x = case x of
  EVENTHANDLERHPUT uident1 uident2 -> 
transProtocol :: Protocol -> Result
transProtocol x = case x of
  PROTOCOLtensor protocol1 protocol2 -> 
  PROTOCOLpar protocol1 protocol2 -> 
  PROTOCOLget tokgetprot type_ protocol -> 
  PROTOCOLput tokputprot type_ protocol -> 
  PROTOCOLneg tokneg protocol -> 
  PROTOCOLtop toktop -> 
  PROTOCOLbot tokbot -> 
  ProtcolNamed uident types protocols -> 
  PROTOCOLvar uident -> 
-}

getFunctionDefnName :: FunctionDefn -> [M.Name]
getFunctionDefnName fdefn 
        = case fdefn of 
              FUNCTIONDEFNfull _ pident _ _ _ ->
                  [snd $ transPIdent pident]
              FUNCTIONDEFNshort _ pident _ ->
                  [snd $ transPIdent pident]
    

transFunctionDefn :: FunctionDefn -> State [(String,[M.Name])] M.Defn
transFunctionDefn x = case x of
  FUNCTIONDEFNfull tokfun pident types type_ patttermpharses -> do 
          let 
             fposn  = transTokFun tokfun 
             fname  = M.Custom $ snd $ transPIdent pident
          iTypes <- mapM transType types 
          oType  <- transType type_
          tPattPhs <- mapM transPattTermPharse patttermpharses 
          let 
             funType = M.TypeFun (iTypes,oType,fposn)
             parVars = M.getParamVars funType
             fType   = M.StrFType (parVars,funType)
             funDefn = M.FunctionDefn (fname,fType,tPattPhs,fposn)
          return funDefn

  FUNCTIONDEFNshort tokfun pident patttermpharses -> do 
          tPattPhs <- mapM transPattTermPharse patttermpharses 
          let 
             fposn   = transTokFun tokfun
             fname   = M.Custom $ snd $ transPIdent pident 
             funDefn = M.FunctionDefn (fname,M.NoType,tPattPhs,fposn)
          return funDefn


transFoldPattern :: FoldPattern -> State [(String,[M.Name])] M.FoldPattern
transFoldPattern x = case x of
  FOLDPATT_WOBRAC uident pidents term -> do 
       let 
         (posn,name) = transUIdent uident
         vPatts      = map ((M.VarPattern).swap.transPIdent) pidents
       tTerm <- transTerm term         
       return $ (name,vPatts,tTerm,posn)  


swap :: (a,b) -> (b,a)
swap (x,y) = (y,x)

transPattTermPharse :: PattTermPharse -> 
                       State [(String,[M.Name])] (M.PatternTermPhr,M.PosnPair)
transPattTermPharse x = case x of
  PATTERNshort patterns term -> do 
        tTerm  <- transTerm term 
        tPatts <- mapM transPattern patterns
        let
          tPosn  = getPattPosn (head tPatts)
        return $ (
                   (tPatts,Left tTerm),
                   tPosn
                 )  
      
  PATTERNguard patterns guardedterms -> do 
        tTerms <- mapM transGuardedTerm guardedterms
        tPatts <- mapM transPattern patterns
        let 
          tPosn  = getPattPosn (head tPatts)
        return ((tPatts,Right tTerms),tPosn)

transGuardedTerm :: GuardedTerm -> State [(String,[M.Name])] M.GuardedTerm
transGuardedTerm x = case x of
  GUARDterm term1 term2 -> do 
          tTerm1 <- transTerm term1 
          tTerm2 <- transTerm term2  
          return (tTerm1,tTerm2)

  GUARDother tokdefault term -> do
          tTerm <- transTerm term  
          return (
                  M.TDefault (transTokDefault tokdefault),
                  tTerm
                 )

-- =============================================================================
-- =============================================================================
-- =============================================================================

                

transPattern :: Pattern -> State [(String,[M.Name])] M.Pattern
transPattern x = case x of
  LISTPATTERN2 pattern1 pattern2 -> do 
          tPatt1 <- transPattern pattern1
          tPatt2 <- transPattern pattern2
          let 
            tPosn  = getPattPosn tPatt1 
          return $ M.ConsPattern ("Cons",[tPatt1,tPatt2],tPosn)
                
  CONSPATTERN uident patterns -> do 
         list <- get 
         let 
           (tPosn,name)
                   = transUIdent uident
           newList = transformList list 
         tPatts <- mapM transPattern patterns 
         case lookup name newList of    
             Just category ->  
                 case category == "data type" of 
                     True  ->
                         return $ M.ConsPattern (name,tPatts,tPosn) 
                     False ->
                         return $ M.DestPattern (name,tPatts,tPosn)  

             Nothing -> do      
                 let 
                    errormsg =
                          "\n Trying to use a data or codata that hasn't been defined, "
                          ++ errorMsg tPosn 
                 error $ unlines [
                                    "\n",M.equalS,M.equalS,"*********Error*********",
                                    errormsg,M.equalS,M.equalS
                                  ] 

  CONSPATTERN_WA uident -> do 
         list <- get 
         let 
           (tPosn,name)
                   = transUIdent uident
           newList = transformList list 
         case lookup name newList of    
             Just category ->  
                 case category == "data type" of 
                     True  ->
                         return $ M.ConsPattern (name,[],tPosn) 
                     False ->
                         return $ M.DestPattern (name,[],tPosn)  

             Nothing -> do      
                 let 
                     errormsg =
                          "\nTrying to use a constructor/destructor <<" ++ name ++  
                          ">> that hasn't been defined, "
                          ++ errorMsg tPosn 
                 error $ unlines [
                                    "\n",M.equalS,M.equalS,"*********Error*********",
                                    errormsg,M.equalS,M.equalS
                                  ] 

  LISTPATTERN1 patterns -> 
          case length patterns == 0 of 
              True  ->
                  return $ M.ConsPattern ("Nil",[],(0,0))

              False -> do 
                    tPatt     <- transPattern (head patterns)
                    restTPatt <- transPattern (LISTPATTERN1 (tail patterns)) 
                    return $ M.ConsPattern ("Cons",[tPatt,restTPatt],getPattPosn tPatt)
                
        
  PRODPATTERN patterns -> 
          case length patterns == 0 of 
              True  -> 
                  error $ unlines [
                                     "\n",M.equalS,M.equalS,"*********Error*********",
                                     errormsg,M.equalS,M.equalS
                                   ]
                  
                     where
                       errormsg = "Empty Tuple in pattern" 
              False -> 
                  case length patterns == 1 of 
                      True  -> 
                          transPattern (head patterns)
                      False -> do 
                          tPatts <- mapM transPattern patterns
                          let 
                            tPosn = getPattPosn (head tPatts)
                          return $ M.ProdPattern (tPatts,tPosn) 

  VARPATTERN pident -> 
         return $ M.VarPattern (tName,tPosn)
      where
        (tPosn,tName) = transPIdent pident  

  STR_CONSTPATTERN tokstr ->
         return $ M.StrConstPattern (tName,tPosn)
      where
        (tPosn,tName) = transTokString tokstr  

  INT_CONSTPATTERN pinteger -> 
         return $ M.IntConstPattern (num,tPosn)
      where
        (tPosn,num) = transPInteger pinteger 

  NULLPATTERN nullPatt -> 
         return $ M.DontCarePattern (transTokDCare nullPatt)

-- ==========================================================================
-- ==========================================================================
-- ==========================================================================

transTerm :: Term -> State [(String,[M.Name])] M.Term 
transTerm x = case x of
  RECORDTERM tokrecord recordentrys -> do  
          tRecs <- mapM transRecordEntry recordentrys
          return $ M.TRecord tRecs

  RECORDTERMALT recordentryalts -> do 
          tRecs <- mapM transRecordEntryAlt recordentryalts 
          return $ M.TRecord tRecs

  --InfixTerm term1 infixrem term2 -> 
  --        undefined 

  Infix0TERM term3 i0op term4 -> do 
          tTerm3 <- transTerm term3 
          tTerm4 <- transTerm term4 
          return $ M.TCallFun 
                         (transInfix0op i0op,[tTerm3,tTerm4],getTermPosn tTerm3)               
 
  Infix1TERM term4 i1op term5 -> do 
          tTerm4 <- transTerm term4 
          tTerm5 <- transTerm term5 
          return $ M.TCallFun 
                         (transInfix1op i1op,[tTerm4,tTerm5],getTermPosn tTerm4) 

  Infix2TERM term5 i2op term6 -> do 
          tTerm5  <- transTerm term5 
          tTerm6  <- transTerm term6 
          return $ M.TCallFun 
                         (transInfix2op i2op,[tTerm5,tTerm6],getTermPosn tTerm5) 

  Infix3TERM term6 i3op term7 -> do 
          tTerm6  <- transTerm term6 
          tTerm7  <- transTerm term7 
          return $ M.TCallFun 
                         (transInfix3op i3op,[tTerm6,tTerm7],getTermPosn tTerm6) 

  Infix4TERM term7 i4op term8 -> do 
          tTerm6  <- transTerm term7 
          tTerm7  <- transTerm term8 
          return $ M.TCallFun 
                         (transInfix4op i4op,[tTerm6,tTerm7],getTermPosn tTerm7) 


  Infix5TERM term8 i5op term9 -> do 
          tTerm8  <- transTerm term8 
          tTerm9  <- transTerm term9 
          return $ M.TCallFun 
                         (transInfix5op i5op,[tTerm8,tTerm9],getTermPosn tTerm8) 


  Infix6TERM term10 i6op term9 -> do 
          tTerm10  <- transTerm term10 
          tTerm9   <- transTerm term9 
          return $ M.TCallFun 
                         (transInfix6op i6op,[tTerm10,tTerm9],getTermPosn tTerm9) 

  Infix7TERM term10 i7op term11 -> do 
          tTerm10  <- transTerm term10 
          tTerm11   <- transTerm term11 
          return $ M.TCallFun 
                         (transInfix7op i7op,[tTerm10,tTerm11],getTermPosn tTerm10) 


  LISTTERM2 term1 term2 -> do 
           tTerm1 <- transTerm term1 
           tTerm2 <- transTerm term2 
           return $ M.TCons ("Cons", [tTerm1,tTerm2],getTermPosn tTerm1)

  LISTTERM terms -> 
          case length terms == 0 of 
              True  ->
                  return $ M.TCons ("Nil",[],(0,0))
              False -> do 
                  tTerm <- transTerm (head terms) 
                  tRest <- transTerm $ LISTTERM (tail terms)
                  let 
                    tPosn  = getTermPosn tTerm
                  return $ M.TCons ("Cons",[tTerm,tRest],tPosn)
         
  LETTERM toklet term lwheres -> do 
          tTerm    <- transTerm term
          tletwhrs <- mapM transLetWhere lwheres 
          return $ M.TLet (tTerm,tletwhrs,transTokLet toklet)

  VARTERM pident -> 
          return $ M.TVar ((swap.transPIdent) pident)

  CONSTTERM constanttype -> do            
          return $ M.TConst (transConstantType constanttype)

  IFTERM tokif term1 term2 term3 -> do 
          tTerm1 <- transTerm term1
          tTerm2 <- transTerm term2
          tTerm3 <- transTerm term3 
          return $ M.TIf (tTerm1,tTerm2,tTerm3,transTokIf tokif)

  UNFOLDTERM tokunfold pident foldpatterns -> 
          undefined 

  FOLDTERM tokfold pident foldpatterns -> do 
          tFoldPatts <- mapM transFoldPattern foldpatterns
          return $ M.TFold (
                            ((M.TVar).swap.transPIdent) pident,
                            tFoldPatts,
                            transTokFold tokfold
                          )

  CASETERM tokcase term patttermpharses -> do 
          tTerm <- transTerm term
          tPattTerms <- mapM transPattTermPharse patttermpharses 
          return $ M.TCase ( 
                            tTerm,
                            map fst tPattTerms,
                            transTokCase tokcase 
                           )

  GENCONSTERM_WARGS uident terms -> do
        list <- get        
        let 
          (posn,name) 
                  = transUIdent uident
          newList = transformList list  
        tTerms <- mapM transTerm terms  
        case lookup name newList of  
          Just category ->  
              case category == "data type" of 
                  True  -> 
                      return $ M.TCons (name,tTerms,posn)
                  False -> 
                      return $ M.TDest (name,tTerms,posn)
  
          Nothing  -> do 
              let 
                 errormsg =
                      "\nTrying to use a constructor/destructor <<" ++ name ++
                      ">> that hasn't been defined, "++ errorMsg posn 
              error $ unlines [
                                "\n",M.equalS,M.equalS,"*********Error*********",
                                errormsg,M.equalS,M.equalS
                              ]            
        
  GENCONSTERM_WOARGS uident -> do 
        list <- get        
        let 
          (posn,name) 
                  = transUIdent uident
          newList = transformList list  
        case lookup name newList of  
          Just category ->  
              case category == "data type" of 
                  True  -> 
                      return $ M.TCons (name,[],posn)
                  False -> 
                      return $ M.TDest (name,[],posn)
  
          Nothing  -> do 
              let 
                 errormsg =
                      "\nTrying to use a constructor/destructor <<" ++ name ++
                      ">> that hasn't been defined, "++ errorMsg posn 
              error $ unlines [
                                "\n",M.equalS,M.equalS,"*********Error*********",
                                errormsg,M.equalS,M.equalS
                              ]
                                
  PRODTERM terms -> do 
          tTerms <- mapM transTerm terms
          let 
            tPosn  = getTermPosn (head tTerms)   
          return $ M.TProd (tTerms,tPosn)     

  FUNAPPTERM pident terms -> do 
        tTerms <- mapM transTerm terms 
        let 
          (posn,name)
               = transPIdent pident
        return $ M.TCallFun (detectFun name,tTerms,posn)


transLetWhere :: LetWhere -> State [(String,[M.Name])] M.LetWhere
transLetWhere lwhs
   = case lwhs of 
         DEFN_LetWhere defn -> do 
             tDefn <- transDefn defn
             return $ M.LetDefn tDefn
         PATTTERM_LetWhere pattTerm -> do
             tPattTerm <- transPattTerm pattTerm 
             return $ M.LetPatt tPattTerm

transPattTerm :: PattTerm -> State [(String,[M.Name])] (M.Pattern,M.Term)
transPattTerm (JUSTPATTTERM patt term) = do 
         tPatt <- transPattern patt 
         tTerm <- transTerm term 
         return (tPatt,tTerm)  


detectFun :: M.Name -> M.FuncName
detectFun name 
        | name == "addI"  = M.BuiltIn (M.Add_I)
        | name == "subI"  = M.BuiltIn (M.Sub_I)
        | name == "mulI"  = M.BuiltIn (M.Mul_I)
        | name == "quotI" = M.BuiltIn (M.DivQ_I)
        | name == "remI"  = M.BuiltIn (M.DivR_I) 
        | name == "eqI"   = M.BuiltIn (M.Eq_I)
        | name == "leqI"  = M.BuiltIn (M.Leq_I)
        | name == "notEqI"= M.BuiltIn (M.Neq_I)
        | name == "lessI" = M.BuiltIn (M.LT_I)
        | name == "grtI"  = M.BuiltIn (M.GT_I) 
        | name == "geqI"  = M.BuiltIn (M.Geq_I)
        | name == "eqC"   = M.BuiltIn (M.Eq_C)
        | name == "eqS"   = M.BuiltIn (M.Eq_S)
        | name == "concat"= M.BuiltIn (M.Concat_S)
        | name == "unstring"   = M.BuiltIn (M.Unstring_S)
        | name == "headString" = M.BuiltIn (M.HeadString_S)
        | name == "tailString" = M.BuiltIn (M.TailString_S)
        | name == "orB"         = M.BuiltIn (M.Or_B)
        | name == "andB"        = M.BuiltIn (M.And_B)
        | otherwise            = M.Custom name


-- ==========================================================================
-- ==========================================================================
-- ==========================================================================

transConstantType :: ConstantType -> (M.BaseVal,M.PosnPair)
transConstantType x = case x of
  INTEGER pinteger -> 
        (M.ConstInt num,posn)
      where
       (posn,num) = transPInteger pinteger

  STRING tokString -> 
        (M.ConstString str,posn) 
      where
        (posn,str) = transTokString tokString

  DOUBLE double -> 
        (M.ConstDouble double,(0,0))

transRecordEntryAlt :: RecordEntryAlt -> 
                      State [(String,[M.Name])] (M.Pattern,M.Term,M.PosnPair)
transRecordEntryAlt x = case x of
  RECORDENTRY_ALT recEntry -> do 
        transRecordEntry recEntry 


transRecordEntry :: RecordEntry ->
                    State [(String,[M.Name])] (M.Pattern,M.Term,M.PosnPair)
transRecordEntry x = case x of
  RECORDENTRY patt term -> do
        destPatt <- transPattern patt
        tTerm    <- transTerm term 
        return (destPatt,tTerm,getPattPosn destPatt) 



-- =============================================================================
-- =============================================================================
-- =============================================================================

transProcessDef _ = undefined

{-  
transProcessDef :: ProcessDef -> Result
transProcessDef x = case x of
  PROCESSDEFfull tokproc pident types protocols1 protocols2 patprocessphrs -> 
  PROCESSDEFshort tokproc pident patprocessphrs -> 
transPatProcessPhr :: PatProcessPhr -> Result
transPatProcessPhr x = case x of
  PROCESSPHRASEguard patterns channels1 channels2 guardprocessphrases -> 
  PROCESSPHRASEnoguard patterns channels1 channels2 process -> 
transProcess :: Process -> Result
transProcess x = case x of
  MANY_PROCESS processcommands -> 
  ONE_PROCESS processcommand -> 
transProcessCommand :: ProcessCommand -> Result
transProcessCommand x = case x of
  PROCESS_RUN pident terms channels1 channels2 -> 
  PROCESS_CLOSE tokclose channel -> 
  PROCESS_HALT tokhalt channel -> 
  PROCESS_GET tokget pident channel -> 
  PROCESS_HCASE tokhcase channel handlers -> 
  PROCESS_PUT tokput term channel -> 
  PROCESS_HPUT tokhput eventhandlehput channel -> 
  PROCESS_SPLIT toksplit channel channels -> 
  PROCESS_FORK tokfork pident forkparts -> 
  Process_PLUG plugparts -> 
  Procss_ID pchannel1 pchannel2 -> 
  PROCESScase tokcase term processphrases -> 
transPlugPart :: PlugPart -> Result
transPlugPart x = case x of
  PLUGPART_MANY processcommands -> 
  PLUGPART_ONE processcommand -> 
transForkPart :: ForkPart -> Result
transForkPart x = case x of
  FORKPARTfull pident channels process -> 
  FORKPARTshort pident process -> 
transHandler :: Handler -> Result
transHandler x = case x of
  HANDLER eventhandlehput process -> 
transProcessPhrase :: ProcessPhrase -> Result
transProcessPhrase x = case x of
  CASEPROCESSguard patterns guardprocessphrases -> 
  CASEPROCESSnoguard patterns process -> 
transGuardProcessPhrase :: GuardProcessPhrase -> Result
transGuardProcessPhrase x = case x of
  GUARDEDPROCESSterm term processcommands -> 
  GUARDEDPROCESSother tokdefault processcommands -> 
transPChannel :: PChannel -> Result
transPChannel x = case x of
  BARECHANNEL pident -> 
  NEGCHANNEL pident -> 
transChannel :: Channel -> Result
transChannel x = case x of
  CHANNEL pident -> 

-}