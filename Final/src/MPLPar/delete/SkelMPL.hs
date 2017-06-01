module SkelMPL where

-- Haskell module generated by the BNF converter

import AbsMPL
import ErrM
type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transTokUnit :: TokUnit -> Result
transTokUnit x = case x of
  TokUnit string -> failure x
transTokSBrO :: TokSBrO -> Result
transTokSBrO x = case x of
  TokSBrO string -> failure x
transTokSBrC :: TokSBrC -> Result
transTokSBrC x = case x of
  TokSBrC string -> failure x
transTokDefn :: TokDefn -> Result
transTokDefn x = case x of
  TokDefn string -> failure x
transTokRun :: TokRun -> Result
transTokRun x = case x of
  TokRun string -> failure x
transTokTerm :: TokTerm -> Result
transTokTerm x = case x of
  TokTerm string -> failure x
transTokData :: TokData -> Result
transTokData x = case x of
  TokData string -> failure x
transTokCodata :: TokCodata -> Result
transTokCodata x = case x of
  TokCodata string -> failure x
transTokType :: TokType -> Result
transTokType x = case x of
  TokType string -> failure x
transTokProtocol :: TokProtocol -> Result
transTokProtocol x = case x of
  TokProtocol string -> failure x
transTokCoprotocol :: TokCoprotocol -> Result
transTokCoprotocol x = case x of
  TokCoprotocol string -> failure x
transTokGetProt :: TokGetProt -> Result
transTokGetProt x = case x of
  TokGetProt string -> failure x
transTokPutProt :: TokPutProt -> Result
transTokPutProt x = case x of
  TokPutProt string -> failure x
transTokNeg :: TokNeg -> Result
transTokNeg x = case x of
  TokNeg string -> failure x
transTokTopBot :: TokTopBot -> Result
transTokTopBot x = case x of
  TokTopBot string -> failure x
transTokFun :: TokFun -> Result
transTokFun x = case x of
  TokFun string -> failure x
transTokDefault :: TokDefault -> Result
transTokDefault x = case x of
  TokDefault string -> failure x
transTokRecord :: TokRecord -> Result
transTokRecord x = case x of
  TokRecord string -> failure x
transTokIf :: TokIf -> Result
transTokIf x = case x of
  TokIf string -> failure x
transTokLet :: TokLet -> Result
transTokLet x = case x of
  TokLet string -> failure x
transTokFold :: TokFold -> Result
transTokFold x = case x of
  TokFold string -> failure x
transTokUnfold :: TokUnfold -> Result
transTokUnfold x = case x of
  TokUnfold string -> failure x
transTokCase :: TokCase -> Result
transTokCase x = case x of
  TokCase string -> failure x
transTokProc :: TokProc -> Result
transTokProc x = case x of
  TokProc string -> failure x
transTokClose :: TokClose -> Result
transTokClose x = case x of
  TokClose string -> failure x
transTokHalt :: TokHalt -> Result
transTokHalt x = case x of
  TokHalt string -> failure x
transTokGet :: TokGet -> Result
transTokGet x = case x of
  TokGet string -> failure x
transTokPut :: TokPut -> Result
transTokPut x = case x of
  TokPut string -> failure x
transTokHCase :: TokHCase -> Result
transTokHCase x = case x of
  TokHCase string -> failure x
transTokHPut :: TokHPut -> Result
transTokHPut x = case x of
  TokHPut string -> failure x
transTokSplit :: TokSplit -> Result
transTokSplit x = case x of
  TokSplit string -> failure x
transTokFork :: TokFork -> Result
transTokFork x = case x of
  TokFork string -> failure x
transTokDCare :: TokDCare -> Result
transTokDCare x = case x of
  TokDCare string -> failure x
transUIdent :: UIdent -> Result
transUIdent x = case x of
  UIdent string -> failure x
transPIdent :: PIdent -> Result
transPIdent x = case x of
  PIdent string -> failure x
transPInteger :: PInteger -> Result
transPInteger x = case x of
  PInteger string -> failure x
transInfix0op :: Infix0op -> Result
transInfix0op x = case x of
  Infix0op string -> failure x
transInfix1op :: Infix1op -> Result
transInfix1op x = case x of
  Infix1op string -> failure x
transInfix2op :: Infix2op -> Result
transInfix2op x = case x of
  Infix2op string -> failure x
transInfix3op :: Infix3op -> Result
transInfix3op x = case x of
  Infix3op string -> failure x
transInfix4op :: Infix4op -> Result
transInfix4op x = case x of
  Infix4op string -> failure x
transInfix5op :: Infix5op -> Result
transInfix5op x = case x of
  Infix5op string -> failure x
transInfix6op :: Infix6op -> Result
transInfix6op x = case x of
  Infix6op string -> failure x
transInfix7op :: Infix7op -> Result
transInfix7op x = case x of
  Infix7op string -> failure x
transMPL :: MPL -> Result
transMPL x = case x of
  MPLPROG mplstmts runstmt -> failure x
transMPLstmt :: MPLstmt -> Result
transMPLstmt x = case x of
  WHEREDEFN tokdefn defns mplstmtalts -> failure x
  WOWHEREDEFN tokdefn defns -> failure x
  BAREDEFN defn -> failure x
transMPLstmtAlt :: MPLstmtAlt -> Result
transMPLstmtAlt x = case x of
  MPLSTMTALT mplstmt -> failure x
transRUNstmt :: RUNstmt -> Result
transRUNstmt x = case x of
  RUNSTMTWITHType tokrun protocols1 protocols2 channels1 channels2 process -> failure x
  RUNSTMTWITHTOUType tokrun channels1 channels2 process -> failure x
transDefn :: Defn -> Result
transDefn x = case x of
  TYPEDEF typedefn -> failure x
  PROTOCOLDEF ctypedefn -> failure x
  FUNCTIONDEF functiondefn -> failure x
  PROCESSDEF processdef -> failure x
transTypeDefn :: TypeDefn -> Result
transTypeDefn x = case x of
  DATA tokdata dataclauses -> failure x
  CODATA tokcodata codataclauses -> failure x
  TYPE toktype typespecs type_ -> failure x
transDataClause :: DataClause -> Result
transDataClause x = case x of
  DATACLAUSE typespec uident dataphrases -> failure x
transCoDataClause :: CoDataClause -> Result
transCoDataClause x = case x of
  CODATACLAUSE uident typespec codataphrases -> failure x
transDataPhrase :: DataPhrase -> Result
transDataPhrase x = case x of
  DATAPHRASE structors types uident -> failure x
transCoDataPhrase :: CoDataPhrase -> Result
transCoDataPhrase x = case x of
  CODATAPHRASE structors types type_ -> failure x
transStructor :: Structor -> Result
transStructor x = case x of
  STRUCTOR uident -> failure x
transTypeSpec :: TypeSpec -> Result
transTypeSpec x = case x of
  TYPESPEC_param uident typeparams -> failure x
  TYPESPEC_basic uident -> failure x
transTypeParam :: TypeParam -> Result
transTypeParam x = case x of
  TYPEPARAM uident -> failure x
transType :: Type -> Result
transType x = case x of
  TYPEARROW typen type_ -> failure x
  TYPENext typen -> failure x
transTypeN :: TypeN -> Result
transTypeN x = case x of
  TYPEUNIT tokunit -> failure x
  TYPELIST toksbro typen toksbrc -> failure x
  TYPEDATCODAT uident types -> failure x
  TYPECONST_VAR uident -> failure x
  TYPEPROD types -> failure x
  TYPEBRACKET type_ -> failure x
transCTypeDefn :: CTypeDefn -> Result
transCTypeDefn x = case x of
  PROTOCOL tokprotocol protocolclause -> failure x
  COPROTOCOL tokcoprotocol coprotocolclause -> failure x
transProtocolClause :: ProtocolClause -> Result
transProtocolClause x = case x of
  PROTOCOLCLAUSE typespec uident protocolphrases -> failure x
transCoProtocolClause :: CoProtocolClause -> Result
transCoProtocolClause x = case x of
  COPROTOCOLCLAUSE uident typespec coprotocolphrases -> failure x
transProtocolPhrase :: ProtocolPhrase -> Result
transProtocolPhrase x = case x of
  PROTOCOLPHRASE uident1 protocol uident2 -> failure x
transCoProtocolPhrase :: CoProtocolPhrase -> Result
transCoProtocolPhrase x = case x of
  COPROTOCOLPHRASE uident1 uident2 protocol -> failure x
transProtocol :: Protocol -> Result
transProtocol x = case x of
  PROTOCOLtensor protocol1 protocol2 -> failure x
  PROTOCOLpar protocol1 protocol2 -> failure x
  PROTOCOLget tokgetprot type_ protocol -> failure x
  PROTOCOLput tokputprot type_ protocol -> failure x
  PROTOCOLneg protocol -> failure x
  PROTOCOLtopbot toktopbot -> failure x
  PROTNamedWArgs uident types -> failure x
  PROTNamedWOArgs uident -> failure x
transFunctionDefn :: FunctionDefn -> Result
transFunctionDefn x = case x of
  FUNCTIONDEFNfull tokfun pident types type_ patttermpharses -> failure x
  FUNCTIONDEFNshort tokfun pident patttermpharses -> failure x
transFoldPattern :: FoldPattern -> Result
transFoldPattern x = case x of
  FOLDPATT_WOBRAC uident pidents term -> failure x
transPattTermPharse :: PattTermPharse -> Result
transPattTermPharse x = case x of
  PATTERNshort patterns term -> failure x
  PATTERNguard patterns guardedterms -> failure x
transGuardedTerm :: GuardedTerm -> Result
transGuardedTerm x = case x of
  GUARDterm term1 term2 -> failure x
  GUARDother tokdefault term -> failure x
transPattern :: Pattern -> Result
transPattern x = case x of
  LISTPATTERN2 pattern1 pattern2 -> failure x
  CONSPATTERN uident patterns -> failure x
  CONSPATTERN_WA uident -> failure x
  LISTPATTERN1 toksbro patterns toksbrc -> failure x
  PRODPATTERN patterns -> failure x
  VARPATTERN pident -> failure x
  STR_CONSTPATTERN string -> failure x
  INT_CONSTPATTERN pinteger -> failure x
  NULLPATTERN tokdcare -> failure x
transTerm :: Term -> Result
transTerm x = case x of
  LISTTERM2 term1 term2 -> failure x
  Infix0TERM term1 infixop term2 -> failure x
  Infix1TERM term1 infixop term2 -> failure x
  Infix2TERM term1 infixop term2 -> failure x
  Infix3TERM term1 infixop term2 -> failure x
  Infix4TERM term1 infixop term2 -> failure x
  Infix5TERM term1 infixop term2 -> failure x
  Infix6TERM term1 infixop term2 -> failure x
  Infix7TERM term1 infixop term2 -> failure x
  LISTTERM toksbro terms toksbrc -> failure x
  LETTERM toklet term letwheres -> failure x
  VARTERM pident -> failure x
  CONSTTERM constanttype -> failure x
  IFTERM tokif term1 term2 term3 -> failure x
  UNFOLDTERM tokunfold pident foldpatterns -> failure x
  FOLDTERM tokfold pident foldpatterns -> failure x
  CASETERM tokcase term patttermpharses -> failure x
  GENCONSTERM_WARGS uident terms -> failure x
  GENCONSTERM_WOARGS uident -> failure x
  PRODTERM terms -> failure x
  FUNAPPTERM pident terms -> failure x
  RECORDTERM tokrecord recordentrys -> failure x
  RECORDTERMALT recordentryalts -> failure x
transLetWhere :: LetWhere -> Result
transLetWhere x = case x of
  DEFN_LetWhere defn -> failure x
  PATTTERM_LetWhere pattterm -> failure x
transPattTerm :: PattTerm -> Result
transPattTerm x = case x of
  JUSTPATTTERM pident term -> failure x
transConstantType :: ConstantType -> Result
transConstantType x = case x of
  INTEGER pinteger -> failure x
  STRING string -> failure x
  CHAR char -> failure x
  DOUBLE double -> failure x
transRecordEntryAlt :: RecordEntryAlt -> Result
transRecordEntryAlt x = case x of
  RECORDENTRY_ALT recordentry -> failure x
transRecordEntry :: RecordEntry -> Result
transRecordEntry x = case x of
  RECORDENTRY pattern term -> failure x
transProcessDef :: ProcessDef -> Result
transProcessDef x = case x of
  PROCESSDEFfull tokproc pident types protocols1 protocols2 patprocessphr -> failure x
  PROCESSDEFshort tokproc pident patprocessphr -> failure x
transPatProcessPhr :: PatProcessPhr -> Result
transPatProcessPhr x = case x of
  PROCESSPHRASEnoguard patterns channels1 channels2 process -> failure x
transProcess :: Process -> Result
transProcess x = case x of
  MANY_PROCESS processcommands -> failure x
  ONE_PROCESS processcommand -> failure x
transProcessCommand :: ProcessCommand -> Result
transProcessCommand x = case x of
  PROCESS_RUN pident terms channels1 channels2 -> failure x
  PROCESS_CLOSE tokclose channel -> failure x
  PROCESS_HALT tokhalt channel -> failure x
  PROCESS_GET tokget pident channel -> failure x
  PROCESS_HCASE tokhcase channel handlers -> failure x
  PROCESS_PUT tokput term channel -> failure x
  PROCESS_HPUT tokhput uident channel -> failure x
  PROCESS_SPLIT toksplit channel channels -> failure x
  PROCESS_FORK tokfork pident forkparts -> failure x
  Process_PLUG plugparts -> failure x
  Procss_ID channel pchannel -> failure x
  PROCESS_NEG channel1 channel2 -> failure x
  PROCESScase tokcase term processphrases -> failure x
transPlugPart :: PlugPart -> Result
transPlugPart x = case x of
  PLUGPART_MANY processcommands -> failure x
  PLUGPART_ONE processcommand -> failure x
transForkPart :: ForkPart -> Result
transForkPart x = case x of
  FORKPARTshort pident process -> failure x
transHandler :: Handler -> Result
transHandler x = case x of
  HANDLER uident process -> failure x
transProcessPhrase :: ProcessPhrase -> Result
transProcessPhrase x = case x of
  CASEPROCESSnoguard pattern process -> failure x
transGuardProcessPhrase :: GuardProcessPhrase -> Result
transGuardProcessPhrase x = case x of
  GUARDEDPROCESSterm term processcommands -> failure x
  GUARDEDPROCESSother tokdefault processcommands -> failure x
transPChannel :: PChannel -> Result
transPChannel x = case x of
  BARECHANNEL pident -> failure x
  NEGCHANNEL pident -> failure x
transChannel :: Channel -> Result
transChannel x = case x of
  CHANNEL pident -> failure x

