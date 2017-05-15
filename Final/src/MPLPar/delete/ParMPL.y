-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParMPL where
import AbsMPL
import LexMPL
import ErrM

}

%name pMPL MPL
%name pListMPLstmt ListMPLstmt
%name pMPLstmt MPLstmt
%name pMPLstmtAlt MPLstmtAlt
%name pListMPLstmtAlt ListMPLstmtAlt
%name pRUNstmt RUNstmt
%name pListDefn ListDefn
%name pDefn Defn
%name pTypeDefn TypeDefn
%name pListDataClause ListDataClause
%name pListCoDataClause ListCoDataClause
%name pListTypeSpec ListTypeSpec
%name pDataClause DataClause
%name pCoDataClause CoDataClause
%name pListDataPhrase ListDataPhrase
%name pListCoDataPhrase ListCoDataPhrase
%name pDataPhrase DataPhrase
%name pCoDataPhrase CoDataPhrase
%name pListStructor ListStructor
%name pListType ListType
%name pStructor Structor
%name pTypeSpec TypeSpec
%name pListTypeParam ListTypeParam
%name pTypeParam TypeParam
%name pType Type
%name pTypeN TypeN
%name pListTypeN ListTypeN
%name pListUIdent ListUIdent
%name pCTypeDefn CTypeDefn
%name pProtocolClause ProtocolClause
%name pCoProtocolClause CoProtocolClause
%name pListProtocolPhrase ListProtocolPhrase
%name pListCoProtocolPhrase ListCoProtocolPhrase
%name pProtocolPhrase ProtocolPhrase
%name pCoProtocolPhrase CoProtocolPhrase
%name pProtocol Protocol
%name pProtocol1 Protocol1
%name pListProtocol ListProtocol
%name pFunctionDefn FunctionDefn
%name pListFunctionDefn ListFunctionDefn
%name pListPattTermPharse ListPattTermPharse
%name pListPIdent ListPIdent
%name pFoldPattern FoldPattern
%name pListFoldPattern ListFoldPattern
%name pPattTermPharse PattTermPharse
%name pListGuardedTerm ListGuardedTerm
%name pGuardedTerm GuardedTerm
%name pListPattern ListPattern
%name pPattern Pattern
%name pPattern1 Pattern1
%name pTerm Term
%name pTerm1 Term1
%name pTerm2 Term2
%name pTerm3 Term3
%name pTerm4 Term4
%name pTerm5 Term5
%name pTerm6 Term6
%name pTerm7 Term7
%name pTerm8 Term8
%name pTerm9 Term9
%name pLetWhere LetWhere
%name pListLetWhere ListLetWhere
%name pPattTerm PattTerm
%name pListRecordEntry ListRecordEntry
%name pListRecordEntryAlt ListRecordEntryAlt
%name pListTerm ListTerm
%name pConstantType ConstantType
%name pRecordEntryAlt RecordEntryAlt
%name pRecordEntry RecordEntry
%name pProcessDef ProcessDef
%name pPatProcessPhr PatProcessPhr
%name pListChannel ListChannel
%name pProcess Process
%name pListProcessCommand ListProcessCommand
%name pProcessCommand ProcessCommand
%name pPlugPart PlugPart
%name pListPlugPart ListPlugPart
%name pListForkPart ListForkPart
%name pForkPart ForkPart
%name pListHandler ListHandler
%name pHandler Handler
%name pListProcessPhrase ListProcessPhrase
%name pProcessPhrase ProcessPhrase
%name pListGuardProcessPhrase ListGuardProcessPhrase
%name pGuardProcessPhrase GuardProcessPhrase
%name pPChannel PChannel
%name pChannel Channel
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  '(' { PT _ (TS _ 1) }
  '(*)' { PT _ (TS _ 2) }
  '(+)' { PT _ (TS _ 3) }
  '(:' { PT _ (TS _ 4) }
  ')' { PT _ (TS _ 5) }
  ',' { PT _ (TS _ 6) }
  '->' { PT _ (TS _ 7) }
  ':' { PT _ (TS _ 8) }
  ':)' { PT _ (TS _ 9) }
  '::' { PT _ (TS _ 10) }
  ':=' { PT _ (TS _ 11) }
  ';' { PT _ (TS _ 12) }
  '<' { PT _ (TS _ 13) }
  '=' { PT _ (TS _ 14) }
  '=>' { PT _ (TS _ 15) }
  '>' { PT _ (TS _ 16) }
  'Neg' { PT _ (TS _ 17) }
  'and' { PT _ (TS _ 18) }
  'as' { PT _ (TS _ 19) }
  'do' { PT _ (TS _ 20) }
  'else' { PT _ (TS _ 21) }
  'into' { PT _ (TS _ 22) }
  'neg' { PT _ (TS _ 23) }
  'of' { PT _ (TS _ 24) }
  'on' { PT _ (TS _ 25) }
  'plug' { PT _ (TS _ 26) }
  'switch' { PT _ (TS _ 27) }
  'then' { PT _ (TS _ 28) }
  'where' { PT _ (TS _ 29) }
  'with' { PT _ (TS _ 30) }
  '{' { PT _ (TS _ 31) }
  '|' { PT _ (TS _ 32) }
  '|=|' { PT _ (TS _ 33) }
  '}' { PT _ (TS _ 34) }

L_charac { PT _ (TC $$) }
L_doubl  { PT _ (TD $$) }
L_TokUnit { PT _ (T_TokUnit _) }
L_TokSBrO { PT _ (T_TokSBrO _) }
L_TokSBrC { PT _ (T_TokSBrC _) }
L_TokDefn { PT _ (T_TokDefn _) }
L_TokRun { PT _ (T_TokRun _) }
L_TokTerm { PT _ (T_TokTerm _) }
L_TokData { PT _ (T_TokData _) }
L_TokCodata { PT _ (T_TokCodata _) }
L_TokType { PT _ (T_TokType _) }
L_TokProtocol { PT _ (T_TokProtocol _) }
L_TokCoprotocol { PT _ (T_TokCoprotocol _) }
L_TokGetProt { PT _ (T_TokGetProt _) }
L_TokPutProt { PT _ (T_TokPutProt _) }
L_TokNeg { PT _ (T_TokNeg _) }
L_TokTopBot { PT _ (T_TokTopBot _) }
L_TokFun { PT _ (T_TokFun _) }
L_TokDefault { PT _ (T_TokDefault _) }
L_TokRecord { PT _ (T_TokRecord _) }
L_TokIf { PT _ (T_TokIf _) }
L_TokLet { PT _ (T_TokLet _) }
L_TokFold { PT _ (T_TokFold _) }
L_TokUnfold { PT _ (T_TokUnfold _) }
L_TokCase { PT _ (T_TokCase _) }
L_TokProc { PT _ (T_TokProc _) }
L_TokClose { PT _ (T_TokClose _) }
L_TokHalt { PT _ (T_TokHalt _) }
L_TokGet { PT _ (T_TokGet _) }
L_TokPut { PT _ (T_TokPut _) }
L_TokHCase { PT _ (T_TokHCase _) }
L_TokHPut { PT _ (T_TokHPut _) }
L_TokSplit { PT _ (T_TokSplit _) }
L_TokFork { PT _ (T_TokFork _) }
L_TokDCare { PT _ (T_TokDCare _) }
L_TokString { PT _ (T_TokString _) }
L_UIdent { PT _ (T_UIdent _) }
L_PIdent { PT _ (T_PIdent _) }
L_PInteger { PT _ (T_PInteger _) }
L_Infix0op { PT _ (T_Infix0op $$) }
L_Infix1op { PT _ (T_Infix1op $$) }
L_Infix2op { PT _ (T_Infix2op $$) }
L_Infix3op { PT _ (T_Infix3op $$) }
L_Infix4op { PT _ (T_Infix4op $$) }
L_Infix5op { PT _ (T_Infix5op $$) }
L_Infix6op { PT _ (T_Infix6op $$) }
L_Infix7op { PT _ (T_Infix7op $$) }


%%

Char    :: { Char }    : L_charac { (read ( $1)) :: Char }
Double  :: { Double }  : L_doubl  { (read ( $1)) :: Double }
TokUnit    :: { TokUnit} : L_TokUnit { TokUnit (mkPosToken $1)}
TokSBrO    :: { TokSBrO} : L_TokSBrO { TokSBrO (mkPosToken $1)}
TokSBrC    :: { TokSBrC} : L_TokSBrC { TokSBrC (mkPosToken $1)}
TokDefn    :: { TokDefn} : L_TokDefn { TokDefn (mkPosToken $1)}
TokRun    :: { TokRun} : L_TokRun { TokRun (mkPosToken $1)}
TokTerm    :: { TokTerm} : L_TokTerm { TokTerm (mkPosToken $1)}
TokData    :: { TokData} : L_TokData { TokData (mkPosToken $1)}
TokCodata    :: { TokCodata} : L_TokCodata { TokCodata (mkPosToken $1)}
TokType    :: { TokType} : L_TokType { TokType (mkPosToken $1)}
TokProtocol    :: { TokProtocol} : L_TokProtocol { TokProtocol (mkPosToken $1)}
TokCoprotocol    :: { TokCoprotocol} : L_TokCoprotocol { TokCoprotocol (mkPosToken $1)}
TokGetProt    :: { TokGetProt} : L_TokGetProt { TokGetProt (mkPosToken $1)}
TokPutProt    :: { TokPutProt} : L_TokPutProt { TokPutProt (mkPosToken $1)}
TokNeg    :: { TokNeg} : L_TokNeg { TokNeg (mkPosToken $1)}
TokTopBot    :: { TokTopBot} : L_TokTopBot { TokTopBot (mkPosToken $1)}
TokFun    :: { TokFun} : L_TokFun { TokFun (mkPosToken $1)}
TokDefault    :: { TokDefault} : L_TokDefault { TokDefault (mkPosToken $1)}
TokRecord    :: { TokRecord} : L_TokRecord { TokRecord (mkPosToken $1)}
TokIf    :: { TokIf} : L_TokIf { TokIf (mkPosToken $1)}
TokLet    :: { TokLet} : L_TokLet { TokLet (mkPosToken $1)}
TokFold    :: { TokFold} : L_TokFold { TokFold (mkPosToken $1)}
TokUnfold    :: { TokUnfold} : L_TokUnfold { TokUnfold (mkPosToken $1)}
TokCase    :: { TokCase} : L_TokCase { TokCase (mkPosToken $1)}
TokProc    :: { TokProc} : L_TokProc { TokProc (mkPosToken $1)}
TokClose    :: { TokClose} : L_TokClose { TokClose (mkPosToken $1)}
TokHalt    :: { TokHalt} : L_TokHalt { TokHalt (mkPosToken $1)}
TokGet    :: { TokGet} : L_TokGet { TokGet (mkPosToken $1)}
TokPut    :: { TokPut} : L_TokPut { TokPut (mkPosToken $1)}
TokHCase    :: { TokHCase} : L_TokHCase { TokHCase (mkPosToken $1)}
TokHPut    :: { TokHPut} : L_TokHPut { TokHPut (mkPosToken $1)}
TokSplit    :: { TokSplit} : L_TokSplit { TokSplit (mkPosToken $1)}
TokFork    :: { TokFork} : L_TokFork { TokFork (mkPosToken $1)}
TokDCare    :: { TokDCare} : L_TokDCare { TokDCare (mkPosToken $1)}
TokString    :: { TokString} : L_TokString { TokString (mkPosToken $1)}
UIdent    :: { UIdent} : L_UIdent { UIdent (mkPosToken $1)}
PIdent    :: { PIdent} : L_PIdent { PIdent (mkPosToken $1)}
PInteger    :: { PInteger} : L_PInteger { PInteger (mkPosToken $1)}
Infix0op    :: { Infix0op} : L_Infix0op { Infix0op ($1)}
Infix1op    :: { Infix1op} : L_Infix1op { Infix1op ($1)}
Infix2op    :: { Infix2op} : L_Infix2op { Infix2op ($1)}
Infix3op    :: { Infix3op} : L_Infix3op { Infix3op ($1)}
Infix4op    :: { Infix4op} : L_Infix4op { Infix4op ($1)}
Infix5op    :: { Infix5op} : L_Infix5op { Infix5op ($1)}
Infix6op    :: { Infix6op} : L_Infix6op { Infix6op ($1)}
Infix7op    :: { Infix7op} : L_Infix7op { Infix7op ($1)}

MPL :: { MPL }
MPL : ListMPLstmt RUNstmt { AbsMPL.MPLPROG (reverse $1) $2 }
ListMPLstmt :: { [MPLstmt] }
ListMPLstmt : {- empty -} { [] }
            | ListMPLstmt MPLstmt { flip (:) $1 $2 }
MPLstmt :: { MPLstmt }
MPLstmt : TokDefn 'of' '{' ListDefn '}' 'where' '{' ListMPLstmtAlt '}' { AbsMPL.WHEREDEFN $1 $4 $8 }
        | TokDefn 'of' '{' ListDefn '}' { AbsMPL.WOWHEREDEFN $1 $4 }
        | Defn { AbsMPL.BAREDEFN $1 }
MPLstmtAlt :: { MPLstmtAlt }
MPLstmtAlt : MPLstmt { AbsMPL.MPLSTMTALT $1 }
ListMPLstmtAlt :: { [MPLstmtAlt] }
ListMPLstmtAlt : {- empty -} { [] }
               | MPLstmtAlt { (:[]) $1 }
               | MPLstmtAlt ';' ListMPLstmtAlt { (:) $1 $3 }
RUNstmt :: { RUNstmt }
RUNstmt : TokRun '::' ListProtocol '=>' ListProtocol '=' '{' ListChannel '=>' ListChannel Process '}' { AbsMPL.RUNSTMTWITHType $1 $3 $5 $8 $10 $11 }
        | TokRun ListChannel '=>' ListChannel Process { AbsMPL.RUNSTMTWITHTOUType $1 $2 $4 $5 }
ListDefn :: { [Defn] }
ListDefn : Defn { (:[]) $1 } | Defn ';' ListDefn { (:) $1 $3 }
Defn :: { Defn }
Defn : TypeDefn { AbsMPL.TYPEDEF $1 }
     | CTypeDefn { AbsMPL.PROTOCOLDEF $1 }
     | FunctionDefn { AbsMPL.FUNCTIONDEF $1 }
     | ProcessDef { AbsMPL.PROCESSDEF $1 }
TypeDefn :: { TypeDefn }
TypeDefn : TokData ListDataClause { AbsMPL.DATA $1 $2 }
         | TokCodata ListCoDataClause { AbsMPL.CODATA $1 $2 }
         | TokType ListTypeSpec '=' '{' Type '}' { AbsMPL.TYPE $1 $2 $5 }
ListDataClause :: { [DataClause] }
ListDataClause : DataClause { (:[]) $1 }
               | DataClause 'and' ListDataClause { (:) $1 $3 }
ListCoDataClause :: { [CoDataClause] }
ListCoDataClause : CoDataClause { (:[]) $1 }
                 | CoDataClause 'and' ListCoDataClause { (:) $1 $3 }
ListTypeSpec :: { [TypeSpec] }
ListTypeSpec : {- empty -} { [] }
             | TypeSpec { (:[]) $1 }
             | TypeSpec ',' ListTypeSpec { (:) $1 $3 }
DataClause :: { DataClause }
DataClause : TypeSpec '->' UIdent '=' '{' ListDataPhrase '}' { AbsMPL.DATACLAUSE $1 $3 $6 }
CoDataClause :: { CoDataClause }
CoDataClause : UIdent '->' TypeSpec '=' '{' ListCoDataPhrase '}' { AbsMPL.CODATACLAUSE $1 $3 $6 }
ListDataPhrase :: { [DataPhrase] }
ListDataPhrase : {- empty -} { [] }
               | DataPhrase { (:[]) $1 }
               | DataPhrase ';' ListDataPhrase { (:) $1 $3 }
ListCoDataPhrase :: { [CoDataPhrase] }
ListCoDataPhrase : {- empty -} { [] }
                 | CoDataPhrase { (:[]) $1 }
                 | CoDataPhrase ';' ListCoDataPhrase { (:) $1 $3 }
DataPhrase :: { DataPhrase }
DataPhrase : ListStructor '::' ListType '->' UIdent { AbsMPL.DATAPHRASE $1 $3 $5 }
CoDataPhrase :: { CoDataPhrase }
CoDataPhrase : ListStructor '::' ListType '->' Type { AbsMPL.CODATAPHRASE $1 $3 $5 }
ListStructor :: { [Structor] }
ListStructor : Structor { (:[]) $1 }
             | Structor ',' ListStructor { (:) $1 $3 }
ListType :: { [Type] }
ListType : {- empty -} { [] }
         | Type { (:[]) $1 }
         | Type ',' ListType { (:) $1 $3 }
Structor :: { Structor }
Structor : UIdent { AbsMPL.STRUCTOR $1 }
TypeSpec :: { TypeSpec }
TypeSpec : UIdent '(' ListTypeParam ')' { AbsMPL.TYPESPEC_param $1 $3 }
         | UIdent { AbsMPL.TYPESPEC_basic $1 }
ListTypeParam :: { [TypeParam] }
ListTypeParam : {- empty -} { [] }
              | TypeParam { (:[]) $1 }
              | TypeParam ',' ListTypeParam { (:) $1 $3 }
TypeParam :: { TypeParam }
TypeParam : UIdent { AbsMPL.TYPEPARAM $1 }
Type :: { Type }
Type : TypeN '=>' Type { AbsMPL.TYPEARROW $1 $3 }
     | TypeN { AbsMPL.TYPENext $1 }
TypeN :: { TypeN }
TypeN : TokUnit { AbsMPL.TYPEUNIT $1 }
      | TokSBrO TypeN TokSBrC { AbsMPL.TYPELIST $1 $2 $3 }
      | UIdent '(' ListType ')' { AbsMPL.TYPEDATCODAT $1 $3 }
      | UIdent { AbsMPL.TYPECONST_VAR $1 }
      | '<' ListType '>' { AbsMPL.TYPEPROD $2 }
      | '(' Type ')' { AbsMPL.TYPEBRACKET $2 }
ListTypeN :: { [TypeN] }
ListTypeN : {- empty -} { [] }
          | TypeN { (:[]) $1 }
          | TypeN ',' ListTypeN { (:) $1 $3 }
ListUIdent :: { [UIdent] }
ListUIdent : {- empty -} { [] }
           | UIdent { (:[]) $1 }
           | UIdent ',' ListUIdent { (:) $1 $3 }
CTypeDefn :: { CTypeDefn }
CTypeDefn : TokProtocol ProtocolClause { AbsMPL.PROTOCOL $1 $2 }
          | TokCoprotocol CoProtocolClause { AbsMPL.COPROTOCOL $1 $2 }
ProtocolClause :: { ProtocolClause }
ProtocolClause : TypeSpec '=>' UIdent '=' '{' ListProtocolPhrase '}' { AbsMPL.PROTOCOLCLAUSE $1 $3 $6 }
CoProtocolClause :: { CoProtocolClause }
CoProtocolClause : UIdent '=>' TypeSpec '=' '{' ListCoProtocolPhrase '}' { AbsMPL.COPROTOCOLCLAUSE $1 $3 $6 }
ListProtocolPhrase :: { [ProtocolPhrase] }
ListProtocolPhrase : {- empty -} { [] }
                   | ProtocolPhrase { (:[]) $1 }
                   | ProtocolPhrase ';' ListProtocolPhrase { (:) $1 $3 }
ListCoProtocolPhrase :: { [CoProtocolPhrase] }
ListCoProtocolPhrase : {- empty -} { [] }
                     | CoProtocolPhrase { (:[]) $1 }
                     | CoProtocolPhrase ';' ListCoProtocolPhrase { (:) $1 $3 }
ProtocolPhrase :: { ProtocolPhrase }
ProtocolPhrase : UIdent '::' Protocol '=>' UIdent { AbsMPL.PROTOCOLPHRASE $1 $3 $5 }
CoProtocolPhrase :: { CoProtocolPhrase }
CoProtocolPhrase : UIdent '::' UIdent '=>' Protocol { AbsMPL.COPROTOCOLPHRASE $1 $3 $5 }
Protocol :: { Protocol }
Protocol : Protocol1 { $1 }
         | Protocol1 '(*)' Protocol { AbsMPL.PROTOCOLtensor $1 $3 }
         | Protocol1 '(+)' Protocol { AbsMPL.PROTOCOLpar $1 $3 }
Protocol1 :: { Protocol }
Protocol1 : '(' Protocol ')' { $2 }
          | TokGetProt '(' Type '|' Protocol ')' { AbsMPL.PROTOCOLget $1 $3 $5 }
          | TokPutProt '(' Type '|' Protocol ')' { AbsMPL.PROTOCOLput $1 $3 $5 }
          | 'Neg' '(' Protocol ')' { AbsMPL.PROTOCOLneg $3 }
          | TokTopBot { AbsMPL.PROTOCOLtopbot $1 }
          | UIdent '(' ListType ')' { AbsMPL.PROTNamedWArgs $1 $3 }
          | UIdent { AbsMPL.PROTNamedWOArgs $1 }
ListProtocol :: { [Protocol] }
ListProtocol : {- empty -} { [] }
             | Protocol { (:[]) $1 }
             | Protocol ',' ListProtocol { (:) $1 $3 }
FunctionDefn :: { FunctionDefn }
FunctionDefn : TokFun PIdent '::' ListType '->' Type '=' '{' ListPattTermPharse '}' { AbsMPL.FUNCTIONDEFNfull $1 $2 $4 $6 $9 }
             | TokFun PIdent '=' '{' ListPattTermPharse '}' { AbsMPL.FUNCTIONDEFNshort $1 $2 $5 }
ListFunctionDefn :: { [FunctionDefn] }
ListFunctionDefn : FunctionDefn { (:[]) $1 }
                 | FunctionDefn ';' ListFunctionDefn { (:) $1 $3 }
ListPattTermPharse :: { [PattTermPharse] }
ListPattTermPharse : PattTermPharse { (:[]) $1 }
                   | PattTermPharse ';' ListPattTermPharse { (:) $1 $3 }
ListPIdent :: { [PIdent] }
ListPIdent : {- empty -} { [] }
           | PIdent { (:[]) $1 }
           | PIdent ',' ListPIdent { (:) $1 $3 }
FoldPattern :: { FoldPattern }
FoldPattern : UIdent ':' ListPIdent '=' '{' Term '}' { AbsMPL.FOLDPATT_WOBRAC $1 $3 $6 }
ListFoldPattern :: { [FoldPattern] }
ListFoldPattern : {- empty -} { [] }
                | FoldPattern { (:[]) $1 }
                | FoldPattern ';' ListFoldPattern { (:) $1 $3 }
PattTermPharse :: { PattTermPharse }
PattTermPharse : ListPattern '->' Term { AbsMPL.PATTERNshort $1 $3 }
               | ListPattern '->' 'switch' '{' ListGuardedTerm '}' { AbsMPL.PATTERNguard $1 $5 }
ListGuardedTerm :: { [GuardedTerm] }
ListGuardedTerm : GuardedTerm { (:[]) $1 }
                | GuardedTerm ';' ListGuardedTerm { (:) $1 $3 }
GuardedTerm :: { GuardedTerm }
GuardedTerm : Term '=' '{' Term '}' { AbsMPL.GUARDterm $1 $4 }
            | TokDefault '=' '{' Term '}' { AbsMPL.GUARDother $1 $4 }
ListPattern :: { [Pattern] }
ListPattern : {- empty -} { [] }
            | Pattern { (:[]) $1 }
            | Pattern ',' ListPattern { (:) $1 $3 }
Pattern :: { Pattern }
Pattern : Pattern1 ':' Pattern { AbsMPL.LISTPATTERN2 $1 $3 }
        | Pattern1 { $1 }
Pattern1 :: { Pattern }
Pattern1 : UIdent '(' ListPattern ')' { AbsMPL.CONSPATTERN $1 $3 }
         | UIdent { AbsMPL.CONSPATTERN_WA $1 }
         | TokSBrO ListPattern TokSBrC { AbsMPL.LISTPATTERN1 $1 $2 $3 }
         | '<' ListPattern '>' { AbsMPL.PRODPATTERN $2 }
         | PIdent { AbsMPL.VARPATTERN $1 }
         | TokString { AbsMPL.STR_CONSTPATTERN $1 }
         | PInteger { AbsMPL.INT_CONSTPATTERN $1 }
         | TokDCare { AbsMPL.NULLPATTERN $1 }
         | '(' Pattern ')' { $2 }
Term :: { Term }
Term : Term1 ':' Term { AbsMPL.LISTTERM2 $1 $3 } | Term1 { $1 }
Term1 :: { Term }
Term1 : Term1 Infix0op Term2 { AbsMPL.Infix0TERM $1 $2 $3 }
      | Term2 { $1 }
Term2 :: { Term }
Term2 : Term2 Infix1op Term3 { AbsMPL.Infix1TERM $1 $2 $3 }
      | Term3 { $1 }
Term3 :: { Term }
Term3 : Term3 Infix2op Term4 { AbsMPL.Infix2TERM $1 $2 $3 }
      | Term4 { $1 }
Term4 :: { Term }
Term4 : Term4 Infix3op Term5 { AbsMPL.Infix3TERM $1 $2 $3 }
      | Term5 { $1 }
Term5 :: { Term }
Term5 : Term5 Infix4op Term6 { AbsMPL.Infix4TERM $1 $2 $3 }
      | Term6 { $1 }
Term6 :: { Term }
Term6 : Term6 Infix5op Term7 { AbsMPL.Infix5TERM $1 $2 $3 }
      | Term7 { $1 }
Term7 :: { Term }
Term7 : Term8 Infix6op Term7 { AbsMPL.Infix6TERM $1 $2 $3 }
      | Term8 { $1 }
Term8 :: { Term }
Term8 : Term8 Infix7op Term9 { AbsMPL.Infix7TERM $1 $2 $3 }
      | Term9 { $1 }
Term9 :: { Term }
Term9 : TokSBrO ListTerm TokSBrC { AbsMPL.LISTTERM $1 $2 $3 }
      | TokLet Term 'where' '{' ListLetWhere '}' { AbsMPL.LETTERM $1 $2 $5 }
      | PIdent { AbsMPL.VARTERM $1 }
      | ConstantType { AbsMPL.CONSTTERM $1 }
      | TokIf Term 'then' Term 'else' '{' Term '}' { AbsMPL.IFTERM $1 $2 $4 $7 }
      | TokUnfold PIdent 'with' '{' ListFoldPattern '}' { AbsMPL.UNFOLDTERM $1 $2 $5 }
      | TokFold PIdent 'of' '{' ListFoldPattern '}' { AbsMPL.FOLDTERM $1 $2 $5 }
      | TokCase Term 'of' '{' ListPattTermPharse '}' { AbsMPL.CASETERM $1 $2 $5 }
      | UIdent '(' ListTerm ')' { AbsMPL.GENCONSTERM_WARGS $1 $3 }
      | UIdent { AbsMPL.GENCONSTERM_WOARGS $1 }
      | '<' ListTerm '>' { AbsMPL.PRODTERM $2 }
      | PIdent '(' ListTerm ')' { AbsMPL.FUNAPPTERM $1 $3 }
      | TokRecord 'of' '{' ListRecordEntry '}' { AbsMPL.RECORDTERM $1 $4 }
      | '(:' ListRecordEntryAlt ':)' { AbsMPL.RECORDTERMALT $2 }
      | '(' Term ')' { $2 }
LetWhere :: { LetWhere }
LetWhere : Defn { AbsMPL.DEFN_LetWhere $1 }
         | PattTerm { AbsMPL.PATTTERM_LetWhere $1 }
ListLetWhere :: { [LetWhere] }
ListLetWhere : LetWhere { (:[]) $1 }
             | LetWhere ';' ListLetWhere { (:) $1 $3 }
PattTerm :: { PattTerm }
PattTerm : PIdent '=' '{' Term '}' { AbsMPL.JUSTPATTTERM $1 $4 }
ListRecordEntry :: { [RecordEntry] }
ListRecordEntry : {- empty -} { [] }
                | RecordEntry { (:[]) $1 }
                | RecordEntry ';' ListRecordEntry { (:) $1 $3 }
ListRecordEntryAlt :: { [RecordEntryAlt] }
ListRecordEntryAlt : {- empty -} { [] }
                   | RecordEntryAlt { (:[]) $1 }
                   | RecordEntryAlt ',' ListRecordEntryAlt { (:) $1 $3 }
ListTerm :: { [Term] }
ListTerm : {- empty -} { [] }
         | Term { (:[]) $1 }
         | Term ',' ListTerm { (:) $1 $3 }
ConstantType :: { ConstantType }
ConstantType : PInteger { AbsMPL.INTEGER $1 }
             | TokString { AbsMPL.STRING $1 }
             | Char { AbsMPL.CHAR $1 }
             | Double { AbsMPL.DOUBLE $1 }
RecordEntryAlt :: { RecordEntryAlt }
RecordEntryAlt : RecordEntry { AbsMPL.RECORDENTRY_ALT $1 }
RecordEntry :: { RecordEntry }
RecordEntry : Pattern ':=' Term { AbsMPL.RECORDENTRY $1 $3 }
ProcessDef :: { ProcessDef }
ProcessDef : TokProc PIdent '::' ListType '|' ListProtocol '=>' ListProtocol '=' '{' PatProcessPhr '}' { AbsMPL.PROCESSDEFfull $1 $2 $4 $6 $8 $11 }
           | TokProc PIdent '=' '{' PatProcessPhr '}' { AbsMPL.PROCESSDEFshort $1 $2 $5 }
PatProcessPhr :: { PatProcessPhr }
PatProcessPhr : ListPattern '|' ListChannel '=>' ListChannel Process { AbsMPL.PROCESSPHRASEnoguard $1 $3 $5 $6 }
ListChannel :: { [Channel] }
ListChannel : {- empty -} { [] }
            | Channel { (:[]) $1 }
            | Channel ',' ListChannel { (:) $1 $3 }
Process :: { Process }
Process : '->' 'do' '{' ListProcessCommand '}' { AbsMPL.MANY_PROCESS $4 }
        | '->' ProcessCommand { AbsMPL.ONE_PROCESS $2 }
ListProcessCommand :: { [ProcessCommand] }
ListProcessCommand : {- empty -} { [] }
                   | ProcessCommand { (:[]) $1 }
                   | ProcessCommand ';' ListProcessCommand { (:) $1 $3 }
ProcessCommand :: { ProcessCommand }
ProcessCommand : PIdent '(' ListTerm '|' ListChannel '=>' ListChannel ')' { AbsMPL.PROCESS_RUN $1 $3 $5 $7 }
               | TokClose Channel { AbsMPL.PROCESS_CLOSE $1 $2 }
               | TokHalt Channel { AbsMPL.PROCESS_HALT $1 $2 }
               | TokGet PIdent 'on' Channel { AbsMPL.PROCESS_GET $1 $2 $4 }
               | TokHCase Channel 'of' '{' ListHandler '}' { AbsMPL.PROCESS_HCASE $1 $2 $5 }
               | TokPut Term 'on' Channel { AbsMPL.PROCESS_PUT $1 $2 $4 }
               | TokHPut UIdent 'on' Channel { AbsMPL.PROCESS_HPUT $1 $2 $4 }
               | TokSplit Channel 'into' ListChannel { AbsMPL.PROCESS_SPLIT $1 $2 $4 }
               | TokFork PIdent 'as' '{' ListForkPart '}' { AbsMPL.PROCESS_FORK $1 $2 $5 }
               | 'plug' '{' ListPlugPart '}' { AbsMPL.Process_PLUG $3 }
               | Channel '|=|' PChannel { AbsMPL.Procss_ID $1 $3 }
               | Channel '=' '{' 'neg' Channel '}' { AbsMPL.PROCESS_NEG $1 $5 }
               | TokCase Term 'of' '{' ListProcessPhrase '}' { AbsMPL.PROCESScase $1 $2 $5 }
PlugPart :: { PlugPart }
PlugPart : 'do' '{' ListProcessCommand '}' { AbsMPL.PLUGPART_MANY $3 }
         | ProcessCommand { AbsMPL.PLUGPART_ONE $1 }
ListPlugPart :: { [PlugPart] }
ListPlugPart : PlugPart { (:[]) $1 }
             | PlugPart ';' ListPlugPart { (:) $1 $3 }
ListForkPart :: { [ForkPart] }
ListForkPart : ForkPart { (:[]) $1 }
             | ForkPart ';' ListForkPart { (:) $1 $3 }
ForkPart :: { ForkPart }
ForkPart : PIdent Process { AbsMPL.FORKPARTshort $1 $2 }
ListHandler :: { [Handler] }
ListHandler : {- empty -} { [] }
            | Handler { (:[]) $1 }
            | Handler ';' ListHandler { (:) $1 $3 }
Handler :: { Handler }
Handler : UIdent Process { AbsMPL.HANDLER $1 $2 }
ListProcessPhrase :: { [ProcessPhrase] }
ListProcessPhrase : {- empty -} { [] }
                  | ProcessPhrase { (:[]) $1 }
                  | ProcessPhrase ';' ListProcessPhrase { (:) $1 $3 }
ProcessPhrase :: { ProcessPhrase }
ProcessPhrase : Pattern Process { AbsMPL.CASEPROCESSnoguard $1 $2 }
ListGuardProcessPhrase :: { [GuardProcessPhrase] }
ListGuardProcessPhrase : GuardProcessPhrase { (:[]) $1 }
                       | GuardProcessPhrase ';' ListGuardProcessPhrase { (:) $1 $3 }
GuardProcessPhrase :: { GuardProcessPhrase }
GuardProcessPhrase : Term '=' '{' ListProcessCommand '}' { AbsMPL.GUARDEDPROCESSterm $1 $4 }
                   | TokDefault '=' '{' ListProcessCommand '}' { AbsMPL.GUARDEDPROCESSother $1 $4 }
PChannel :: { PChannel }
PChannel : PIdent { AbsMPL.BARECHANNEL $1 }
         | 'neg' PIdent { AbsMPL.NEGCHANNEL $2 }
Channel :: { Channel }
Channel : PIdent { AbsMPL.CHANNEL $1 }
{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map (id . prToken) (take 4 ts))

myLexer = tokens
}

