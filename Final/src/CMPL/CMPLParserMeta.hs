{-# LANGUAGE QuasiQuotes, TemplateHaskell #-}

module CMPL.CMPLParserMeta  where

import Language.LBNF.Compiletime
import Language.LBNF(lbnf, dumpCode, bnfc)


{-
To use BNFC-Meta first develop your bnfc grammar, and then do the following:

bnfc [lbnf|
  grammar
|]

This will generate via template haskell the code for the lexers and parsers.
-}
bnfc [lbnf|

comment "--" ;
comment "{-" "-}" ;

entrypoints CMPLProgram ;

layout "=" , "->" , "of" , "as" , "->>" ,":"    ;

position token Case {"case"} ;
position token Close {"close"} ;
position token Halt  {"halt"}  ;
position token Get   {"get"}   ;
position token Put   {"put"} ;
position token Hcase {"hcase"}  ;
position token Hput  {"hput"}   ;
position token Split {"split"}   ;
position token Fork  {"fork"} ;
position token Plug  {"plug"}  ;
position token Ch_ID {":=:"} ;
position token Data  {"Data"} ;
position token Codata     {"Codata"} ;
position token Protocol   {"Protocol"} ;
position token Coprotocol {"Coprotocol"} ;
position token Fun        {"fun"} ;
position token Proc       {"proc"} ;
position token Rec        {"rec"} ;   
position token MainRun    {"main_run"} ;

position token UIdent (upper (letter | digit | '_')*);
position token PIdent letter (letter | digit | '_' | '\'')* ;
--position token CString  '"' ((char - ["\"\\"]) | ('\\' ["\"\\nt"]))* '"' ;
position token CChar '\'' ((char - ["'\\"]) | ('\\' ["'\\nt"])) '\'' ;
position token CInteger digit+ ;
separator PIdent "," ;

CMPLPROGRAM        .CMPLProgram  ::= [INCLUDE_Files] [CMPL_Constructs] Run_Construct ;

separator INCLUDE_Files "" ; 
separator CMPL_Constructs "" ;

INCLUDE_FILES.INCLUDE_Files ::= "%include" Slash DirPath ".cmpl";

SLASH.Slash ::= "/";
SLASH_NONE.Slash ::= ;

DIRPATH.DirPath  ::= [DirName] ;
separator nonempty DirName "/" ;

L_DIRNAME.DirName  ::= PIdent ;
U_DIRNAME.DirName  ::= UIdent ;

---------------- Main Constructs -----------------------------------------------------

DATA_CONSTRUCT              . CMPL_Constructs ::= Data      DataName "=" "{" [Structor] "}" ;
CODATA_CONSTRUCT            . CMPL_Constructs ::= Codata    DataName "=" "{" [Structor] "}" ;
PROTOCOL_CONSTRUCT          . CMPL_Constructs ::= Protocol  ProtocolName "=" "{" [Handle] "}" ;
COPROTOCOL_CONSTRUCT        . CMPL_Constructs ::= Coprotocol ProtocolName "=" "{" [Handle] "}" ;
FUNCTION_CONSTRUCT_CONST    . CMPL_Constructs ::= Fun  FIdent "=" "{" Term "}"  ; 
FUNCTION_CONSTRUCT          . CMPL_Constructs ::= Fun  FIdent "(" [Argument] ")" "=" "{" Term "}"   ;
PROCESS_CONSTRUCT           . CMPL_Constructs ::= Proc PIdent "(" [Argument] "|" [Channel] "=>" [Channel] ")" "=" Process ;
RUN_CONSTRUCT               . Run_Construct   ::= MainRun "(" [Channel] "=>" [Channel] ")" "=" Process ; 

---------------- Process Commands Start ----------------------------------------------

PROCESS. Process ::= "{" [PCom] "}" ;
separator PCom ";" ;

PROCESSrun     . PCom       ::= PIdent "(" [Term] "|" [Channel] "=>" [Channel] ")" ;
PROCESSclose   . PCom       ::= Close PIdent ;
PROCESSend     . PCom       ::= Halt [PIdent] ;
PROCESSget     . PCom       ::= Get PIdent "on" Channel;
PROCESSput     . PCom       ::= Put Term  "on" Channel ;
PROCESSputevent. PCom       ::= Hput EventHandle "on" Channel ;
PROCESSSwitch  . PCom       ::= Hcase Channel "of" "{" [ProcessPhrase_hcase] "}" ;
PROCESSsplit   . PCom       ::= Split Channel "into" [Channel] ;
PROCESSfork    . PCom       ::= Fork PIdent "as"  "{" [ForkPart] "}" ;
PROCESSplug    . PCom       ::= Plug "as" "{" [PlugPart] "}" ;                                                                               
PROCESScase    . PCom       ::= Case Term "of" "{" [ProcessPhrase_pcase] "}" ;
PROCESSId      . PCom       ::= PIdent Ch_ID PIdent ;  
PROCESSREC     . PCom       ::= Rec "of" "{" [RecordEntryProc] "}"  ; 


PLUGPART       . PlugPart   ::= "&" ":"  Process  ; 
separator PlugPart ";" ;

separator nonempty ForkPart ";" ;

FORKPARTfull. ForkPart ::= PIdent ":"  Process  ;


PROC_PHR_PCASE . ProcessPhrase_pcase ::= Pattern "->" Process ;

PROC_PHR_HCASE . ProcessPhrase_hcase ::= EventHandle "->" Process ; 

EVENTHANDLE.EventHandle ::= UIdent "." UIdent ;

PATTERNDEFshort. PatternDef ::= Pattern "->" "{" [Term_Alt] "}" ; 
TERM_ALT . Term_Alt ::= Term ; 
separator Term_Alt ";" ; 


PATTERN_PARAM   .Pattern ::= UIdent "." UIdent "(" [PIdent] ")" ;
PATTERN_WOPARAM .Pattern ::= UIdent "." UIdent ;

separator ProcessPhrase_pcase ";" ;
separator ProcessPhrase_hcase ";" ;
separator PatternDef ";" ;


---------------- Process Commands End ----------------------------------------------

separator Channel "," ;
CHANNEL.Channel    ::= PIdent ;

LARGUMENT.Argument ::= UIdent ;
UARGUMENT.Argument ::= PIdent ;
separator Argument "," ;

separator Structor ";" ;
STRUCTOR.Structor ::= UIdent CInteger ;

position token Infix0op (('=')     ( '+' | '-' | '|' | '/' | '*' | '&' | '='| ':')*);
position token Infix1op (('|'|'&'|'^') ( '+' | '-' | '|' | '/' | '*' | '&' | '<' | '>' | '=')*);
position token Infix2op (('<'|'>')     ( '+' | '-' | '|' | '/' | '*' | '&' | '<' | '>' | '=')*);
position token Infix3op (('+'|'-')     ( '+' | '-' | '|' | '/' | '*' | '&' )*);
position token Infix4op (('*'|'/'|'%') ( '+' | '-' | '|' | '/' | '*' | '&' | '<' | '>' | '=')*);

-------------------- Names and Data Types and Codata Types-----------------------------
DATANAME_basic   . DataName    ::= UIdent ;
DATANAME_infix0op. DataName    ::= UIdent Infix0op UIdent ;
DATANAME_infix1op. DataName    ::= UIdent Infix1op UIdent ;
DATANAME_infix2op. DataName    ::= UIdent Infix2op UIdent ;
DATANAME_infix3op. DataName    ::= UIdent Infix3op UIdent ;
DATANAME_infix4op. DataName    ::= UIdent Infix4op UIdent ;

------------------- Function Names ------------------------------------------------------
ID.FIdent ::= PIdent ;
SECTION0.FIdent ::=  Infix0op ;
SECTION1.FIdent ::=  Infix1op ;
SECTION2.FIdent ::=  Infix2op ;
SECTION3.FIdent ::=  Infix3op ;
SECTION4.FIdent ::=  Infix4op ;

------------------ Protocol Names --------------------------------------------------------
PROTOCOLNAME.ProtocolName ::= UIdent ;

separator Handle ";" ;
HANDLE.Handle ::= UIdent ;

----------------- TERMS START --------------------------------------------------------------
CONSTERM_Param   . Term   ::= DataName "." UIdent  "(" [Term] ")"     ;
CONSTERM_WOParam . Term   ::= DataName "." UIdent ;
--DESTTERM_Param . Term   ::= DataName "." UIdent  "(" [Term] ")"  ;
_                . Term   ::= Term1 ;
_                . Term   ::= "(" Term ")" ;
Infix0TERM       . Term1  ::= Term1 Infix0op Term2 ;
_                . Term1  ::= Term2 ;
Infix1TERM       . Term2  ::= Term2 Infix1op Term3 ;
_                . Term2  ::= Term3 ;
Infix2TERM       . Term3  ::= Term3 Infix2op Term4 ;
_                . Term3  ::= Term4 ;
Infix3TERM       . Term4  ::= Term4 Infix3op Term5 ;
_                . Term4  ::= Term5 ;
Infix4TERM       . Term5  ::= Term5 Infix4op Term6 ;
_                . Term5  ::= Term6 ;
CASETERM         . Term6  ::= Case Term "of" "{" [PatternDef] "}" ; -- doubt 
VARTERM          . Term6  ::= PIdent ;
CONSTTERM_STR    . Term6  ::= String  ;
CONSTTERM_INT    . Term6  ::= CInteger ;
CONSTTERM_CHAR   . Term6  ::= CChar ;  
CUST_IN_FUNC     . Term6  ::= FIdent "(" [Term] ")" ;
RECORDTERMALT    . Term6  ::= Rec "of" "{" [RecordEntryAlt] "}"  ; 
PRODTERM         . Term6  ::= "<" [Term] ">" ;
GET_ELEM         . Term6  ::= "#" CInteger "(" Term6 ")" ;



------------ TERMS END ----------------------------------------------



separator RecordEntryAlt ";" ;
separator Term "," ;
separator RecordEntryProc ";" ;
RECORDENTRY_PROC.RecordEntryProc ::= Pattern "->" "{" [PCom] "}" ;
RECORDENTRY_ALT .RecordEntryAlt  ::= Pattern "->" "{" Term "}" ;


|]
