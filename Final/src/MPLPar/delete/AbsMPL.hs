

module AbsMPL where

-- Haskell module generated by the BNF converter




newtype TokUnit = TokUnit ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokSBrO = TokSBrO ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokSBrC = TokSBrC ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokDefn = TokDefn ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokRun = TokRun ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokTerm = TokTerm ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokData = TokData ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokCodata = TokCodata ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokType = TokType ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokProtocol = TokProtocol ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokCoprotocol = TokCoprotocol ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokGetProt = TokGetProt ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokPutProt = TokPutProt ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokNeg = TokNeg ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokTopBot = TokTopBot ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokFun = TokFun ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokDefault = TokDefault ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokRecord = TokRecord ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokIf = TokIf ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokFold = TokFold ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokUnfold = TokUnfold ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokCase = TokCase ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokProc = TokProc ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokClose = TokClose ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokHalt = TokHalt ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokGet = TokGet ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokPut = TokPut ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokHCase = TokHCase ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokHPut = TokHPut ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokSplit = TokSplit ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokFork = TokFork ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype TokDCare = TokDCare ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype UIdent = UIdent ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype PIdent = PIdent ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype PInteger = PInteger ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype Infix0op = Infix0op String deriving (Eq, Ord, Show, Read)
newtype Infix1op = Infix1op String deriving (Eq, Ord, Show, Read)
newtype Infix2op = Infix2op String deriving (Eq, Ord, Show, Read)
newtype Infix3op = Infix3op String deriving (Eq, Ord, Show, Read)
newtype Infix4op = Infix4op String deriving (Eq, Ord, Show, Read)
newtype Infix5op = Infix5op String deriving (Eq, Ord, Show, Read)
newtype Infix6op = Infix6op String deriving (Eq, Ord, Show, Read)
newtype Infix7op = Infix7op String deriving (Eq, Ord, Show, Read)
data MPL = MPLPROG [MPLstmt] RUNstmt
  deriving (Eq, Ord, Show, Read)

data MPLstmt
    = WHEREDEFN TokDefn [Defn] [MPLstmtAlt]
    | WOWHEREDEFN TokDefn [Defn]
    | BAREDEFN Defn
  deriving (Eq, Ord, Show, Read)

data MPLstmtAlt = MPLSTMTALT MPLstmt
  deriving (Eq, Ord, Show, Read)

data RUNstmt
    = RUNSTMTWITHType TokRun [Protocol] [Protocol] [Channel] [Channel] Process
    | RUNSTMTWITHTOUType TokRun [Channel] [Channel] Process
  deriving (Eq, Ord, Show, Read)

data Defn
    = TYPEDEF TypeDefn
    | PROTOCOLDEF CTypeDefn
    | FUNCTIONDEF FunctionDefn
    | PROCESSDEF ProcessDef
  deriving (Eq, Ord, Show, Read)

data TypeDefn
    = DATA TokData [DataClause]
    | CODATA TokCodata [CoDataClause]
    | TYPE TokType [TypeSpec] Type
  deriving (Eq, Ord, Show, Read)

data DataClause = DATACLAUSE TypeSpec UIdent [DataPhrase]
  deriving (Eq, Ord, Show, Read)

data CoDataClause = CODATACLAUSE UIdent TypeSpec [CoDataPhrase]
  deriving (Eq, Ord, Show, Read)

data DataPhrase = DATAPHRASE [Structor] [Type] UIdent
  deriving (Eq, Ord, Show, Read)

data CoDataPhrase = CODATAPHRASE [Structor] [Type] Type
  deriving (Eq, Ord, Show, Read)

data Structor = STRUCTOR UIdent
  deriving (Eq, Ord, Show, Read)

data TypeSpec
    = TYPESPEC_param UIdent [TypeParam] | TYPESPEC_basic UIdent
  deriving (Eq, Ord, Show, Read)

data TypeParam = TYPEPARAM UIdent
  deriving (Eq, Ord, Show, Read)

data Type = TYPEARROW TypeN Type | TYPENext TypeN
  deriving (Eq, Ord, Show, Read)

data TypeN
    = TYPEUNIT TokUnit
    | TYPELIST TokSBrO TypeN TokSBrC
    | TYPEDATCODAT UIdent [Type]
    | TYPECONST_VAR UIdent
    | TYPEPROD [Type]
    | TYPEBRACKET Type
  deriving (Eq, Ord, Show, Read)

data CTypeDefn
    = PROTOCOL TokProtocol ProtocolClause
    | COPROTOCOL TokCoprotocol CoProtocolClause
  deriving (Eq, Ord, Show, Read)

data ProtocolClause
    = PROTOCOLCLAUSE TypeSpec UIdent [ProtocolPhrase]
  deriving (Eq, Ord, Show, Read)

data CoProtocolClause
    = COPROTOCOLCLAUSE UIdent TypeSpec [CoProtocolPhrase]
  deriving (Eq, Ord, Show, Read)

data ProtocolPhrase = PROTOCOLPHRASE UIdent Protocol UIdent
  deriving (Eq, Ord, Show, Read)

data CoProtocolPhrase = COPROTOCOLPHRASE UIdent UIdent Protocol
  deriving (Eq, Ord, Show, Read)

data Protocol
    = PROTOCOLtensor Protocol Protocol
    | PROTOCOLpar Protocol Protocol
    | PROTOCOLget TokGetProt Type Protocol
    | PROTOCOLput TokPutProt Type Protocol
    | PROTOCOLneg Protocol
    | PROTOCOLtopbot TokTopBot
    | PROTNamedWArgs UIdent [Type]
    | PROTNamedWOArgs UIdent
  deriving (Eq, Ord, Show, Read)

data FunctionDefn
    = FUNCTIONDEFNfull TokFun PIdent [Type] Type [PattTermPharse]
    | FUNCTIONDEFNshort TokFun PIdent [PattTermPharse]
  deriving (Eq, Ord, Show, Read)

data FoldPattern = FOLDPATT_WOBRAC UIdent [PIdent] Term
  deriving (Eq, Ord, Show, Read)

data PattTermPharse
    = PATTERNshort [Pattern] Term
    | PATTERNguard [Pattern] [GuardedTerm]
  deriving (Eq, Ord, Show, Read)

data GuardedTerm = GUARDterm Term Term | GUARDother TokDefault Term
  deriving (Eq, Ord, Show, Read)

data Pattern
    = LISTPATTERN2 Pattern Pattern
    | CONSPATTERN UIdent [Pattern]
    | CONSPATTERN_WA UIdent
    | LISTPATTERN1 TokSBrO [Pattern] TokSBrC
    | PRODPATTERN [Pattern]
    | VARPATTERN PIdent
    | STR_CONSTPATTERN String
    | INT_CONSTPATTERN PInteger
    | NULLPATTERN TokDCare
  deriving (Eq, Ord, Show, Read)

data Term
    = LISTTERM2 Term Term
    | LETTERM Term [LetWhere]
    | Infix0TERM Term Infix0op Term
    | Infix1TERM Term Infix1op Term
    | Infix2TERM Term Infix2op Term
    | Infix3TERM Term Infix3op Term
    | Infix4TERM Term Infix4op Term
    | Infix5TERM Term Infix5op Term
    | Infix6TERM Term Infix6op Term
    | Infix7TERM Term Infix7op Term
    | LISTTERM TokSBrO [Term] TokSBrC
    | VARTERM PIdent
    | CONSTTERM ConstantType
    | IFTERM TokIf Term Term Term
    | UNFOLDTERM TokUnfold PIdent [FoldPattern]
    | FOLDTERM TokFold PIdent [FoldPattern]
    | CASETERM TokCase Term [PattTermPharse]
    | GENCONSTERM_WARGS UIdent [Term]
    | GENCONSTERM_WOARGS UIdent
    | PRODTERM [Term]
    | FUNAPPTERM PIdent [Term]
    | RECORDTERM TokRecord [RecordEntry]
    | RECORDTERMALT [RecordEntryAlt]
  deriving (Eq, Ord, Show, Read)

data LetWhere = DEFN_LetWhere Defn | PATTTERM_LetWhere PattTerm
  deriving (Eq, Ord, Show, Read)

data PattTerm = JUSTPATTTERM PIdent Term
  deriving (Eq, Ord, Show, Read)

data ConstantType
    = INTEGER PInteger | STRING String | CHAR Char | DOUBLE Double
  deriving (Eq, Ord, Show, Read)

data RecordEntryAlt = RECORDENTRY_ALT RecordEntry
  deriving (Eq, Ord, Show, Read)

data RecordEntry = RECORDENTRY Pattern Term
  deriving (Eq, Ord, Show, Read)

data ProcessDef
    = PROCESSDEFfull TokProc PIdent [Type] [Protocol] [Protocol] PatProcessPhr
    | PROCESSDEFshort TokProc PIdent PatProcessPhr
  deriving (Eq, Ord, Show, Read)

data PatProcessPhr
    = PROCESSPHRASEnoguard [Pattern] [Channel] [Channel] Process
  deriving (Eq, Ord, Show, Read)

data Process
    = MANY_PROCESS [ProcessCommand] | ONE_PROCESS ProcessCommand
  deriving (Eq, Ord, Show, Read)

data ProcessCommand
    = PROCESS_RUN PIdent [Term] [Channel] [Channel]
    | PROCESS_CLOSE TokClose Channel
    | PROCESS_HALT TokHalt Channel
    | PROCESS_GET TokGet PIdent Channel
    | PROCESS_HCASE TokHCase Channel [Handler]
    | PROCESS_PUT TokPut Term Channel
    | PROCESS_HPUT TokHPut UIdent Channel
    | PROCESS_SPLIT TokSplit Channel [Channel]
    | PROCESS_FORK TokFork PIdent [ForkPart]
    | Process_PLUG [PlugPart]
    | Procss_ID Channel PChannel
    | PROCESS_NEG Channel Channel
    | PROCESScase TokCase Term [ProcessPhrase]
  deriving (Eq, Ord, Show, Read)

data PlugPart
    = PLUGPART_MANY [ProcessCommand] | PLUGPART_ONE ProcessCommand
  deriving (Eq, Ord, Show, Read)

data ForkPart = FORKPARTshort PIdent Process
  deriving (Eq, Ord, Show, Read)

data Handler = HANDLER UIdent Process
  deriving (Eq, Ord, Show, Read)

data ProcessPhrase = CASEPROCESSnoguard Pattern Process
  deriving (Eq, Ord, Show, Read)

data GuardProcessPhrase
    = GUARDEDPROCESSterm Term [ProcessCommand]
    | GUARDEDPROCESSother TokDefault [ProcessCommand]
  deriving (Eq, Ord, Show, Read)

data PChannel = BARECHANNEL PIdent | NEGCHANNEL PIdent
  deriving (Eq, Ord, Show, Read)

data Channel = CHANNEL PIdent
  deriving (Eq, Ord, Show, Read)

