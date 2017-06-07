{-# LANGUAGE QuasiQuotes, TemplateHaskell #-}
module CMPL.AMPLParserMeta  where

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
comment "/*" "*/" ;

entrypoints AMPLCODE  ;

layout "=" , ":", "as" , "of"  ;

position token Store       {"store"} ;
position token Load        {"load"} ;
position token Ret         {"ret"} ;
position token Call        {"call"} ;
position token ConstInt    {"cInt"} ;
position token ConstChar   {"cChar"} ;
position token ConstString {"cString"} ;
position token ToStr    {"toStr"} ;
position token ToInt    {"toInt"}  ;  
position token And      {"And"}  ;
position token Or       {"or"}  ;
position token Append   {"appendL"} ;
position token Unstring {"unstring"} ;
position token LeqI     {"leq"} ;
position token EqI      {"eq"} ;
position token Leqc     {"leqc"} ;
position token Eqc      {"eqc"} ;
position token Leqs     {"leqs"} ;
position token Eqs      {"eqs"} ;
position token ConcatS  {"concatS"} ;
position token Add      {"add"} ;
position token Subtract {"subtract"} ;
position token Mul      {"mul"} ;
position token Quot     {"quot"} ;
position token Rem      {"rem"} ;
position token Cons     {"cons"} ;
position token Case     {"case"} ;
position token Rec      {"rec"} ;
position token Get      {"get"} ;
position token Put      {"put"} ;
position token Hput     {"hput"} ;
position token Hcase    {"hcase"} ;
position token Split    {"split"} ;
position token Fork     {"fork"} ;
position token Plug     {"plug"} ;
position token Run      {"run"} ;
position token Close    {"close"};
position token Halt     {"halt"};
position token Ch_Id    {"=="};
position token Main_run {"%run"};

position token Character '\'' ((char - ["'\\"]) | ('\\' ["'\\nt"])) '\''  ;
position token UIdent (upper (letter | digit | '_')*);
position token PIdent letter (letter | digit | '_' | '\'')* ;
--position token CString  '"' ((char - ["\"\\"]) | ('\\' ["\"\\nt"]))* '"' ;
position token PInteger digit+ ;



Main                   .AMPLCODE            ::= [AMPL_CONSTRUCTS] START  ; --modified
IMPORT_CONSTRUCT       .AMPL_CONSTRUCTS     ::= IMPORT ; 
HANDLE_CONSTRUCT       .AMPL_CONSTRUCTS     ::= HANDLES ;
COHANDLE_CONSTRUCT     .AMPL_CONSTRUCTS     ::= COHANDLES ; 
CONSTRUCTOR_CONSTRUCT  .AMPL_CONSTRUCTS     ::= CONSTRUCTORS ;
DESTRUCTOR_CONSTRUCT   .AMPL_CONSTRUCTS     ::= DESTRUCTORS ; 
PROCESSES_CONSTRUCT    .AMPL_CONSTRUCTS     ::= PROCESSES ; 
FUNCTIONS_CONSTRUCT    .AMPL_CONSTRUCTS     ::= FUNCTIONS ;

separator  AMPL_CONSTRUCTS "" ;

---------------------------------------------------------------------------------------------
 -- An AMPL code file consists of a series of specifcations which can be omitted followed by the code at which one starts.
-- The specifications are:
--      Handles: these are handle names associated with a type.  
--        They are hput on output polarity channels and hcased on input polarity channels
--      Cohandles:  these are handle names associated with a type.
--        They are hput on input polarity channels and hcased on output polarity channels
--      Constructors (and number of arguments)
--      Destructors (and number of arguments)
--      Process definitions
--      Function definitions

---------------------------------------------------------------------------------------------


Hand_spec  .HANDLE_SPEC ::= UIdent "=" "{" [Handle] "}" ;
HandName   .Handle ::= UIdent ;
separator HANDLE_SPEC ";" ;
separator nonempty Handle ";";

Imports.IMPORTS ::= [IMPORT] ; -- newly addded 

LIDENT.LUIDENT  ::= PIdent ;
UIDENT.LUIDENT  ::= UIdent ;

DIRPATH.DirPath  ::= [LUIDENT] ;
separator nonempty LUIDENT "/" ;

SLASH.Slash ::= "/";
SLASH_NONE.Slash ::= ;

separator IMPORT "" ;

Import  .IMPORT   ::= "%include" Slash DirPath ".ampl"; --newly added

Constructors. CONSTRUCTORS ::= "%constructors" ":" "{" [STRUCTOR_SPEC] "}" ;

Destructors  .DESTRUCTORS ::= "%destructors" ":" "{" [STRUCTOR_SPEC] "}"  ;

Struct_spec  .STRUCTOR_SPEC ::= UIdent "=" "{" [STRUCT] "}" ;
Struct       .STRUCT ::= UIdent PInteger ;
separator STRUCTOR_SPEC ";" ;
separator nonempty STRUCT ";";

Handles  .HANDLES ::= "%handles"  ":" "{" [HANDLE_SPEC] "}" ;

Cohandles  .COHANDLES ::= "%cohandles" ":" "{" [HANDLE_SPEC] "}" ;

Processes. PROCESSES  ::= "%processes" ":" "{" [PROCESS_SPEC] "}" ;
separator PROCESS_SPEC ";" ;

Process_spec. PROCESS_SPEC ::= PIdent "(" [Vars] "|" [PIdent] "=>" [PIdent] ")" "=" COMS ;

VName  .Vars ::= PIdent ;
separator Vars ",";

Functions  .FUNCTIONS ::= "%functions" ":" "{" [FUNCTION_SPEC] "}" ;
separator FUNCTION_SPEC ";" ;

Function_spec  .FUNCTION_SPEC ::= PIdent "(" [Vars] ")" "=" COMS    ;

 
Start  .START    ::= Main_run CHANNEL_SPEC ":" COMS ;
Start_none.START ::= ;

Channel_specf .CHANNEL_SPEC ::= "("  "|" [PIdent] "=>" [PIdent] ")";
Channel_spec .CHANNEL_SPEC ::= "(" [CInteger] "=>" [CInteger] ")";

Prog    .COMS  ::= "{" [COM] "}"; 
separator COM ";"  ;

AC_ASSIGN  .COM   ::= PIdent ":=" COM ;  
AC_STOREf  .COM   ::= Store PIdent;
AC_LOADf   .COM   ::= Load PIdent ;
AC_RET     .COM   ::= Ret ;
AC_CALLf   .COM   ::= Call PIdent "(" [PIdent] ")" ;
AC_INT     .COM   ::= ConstInt CInteger ;
AC_CHAR    .COM   ::= ConstChar Character ;
AC_STRING  .COM   ::= ConstString String ;
AC_TOSTR   .COM   ::= ToStr ;
AC_TOINT   .COM   ::= ToInt ;
AC_AND     .COM   ::= And ;
AC_OR      .COM   ::= Or ;
AC_APPEND  .COM   ::= Append ; 
AC_UNSTRING.COM   ::= Unstring ;
AC_LEQ     .COM   ::= LeqI ;
AC_EQ      .COM   ::= EqI  ;
AC_LEQC    .COM   ::= Leqc ;
AC_EQC     .COM   ::= Eqc ;
AC_LEQS    .COM   ::= Leqs ;
AC_EQS     .COM   ::= Eqs ;
AC_CONCAT  .COM   ::= ConcatS Integer ;
AC_ADD     .COM   ::= Add ;
AC_SUB     .COM   ::= Subtract ;
AC_MUL     .COM   ::= Mul ;
AC_DIVQ    .COM   ::= Quot ;
AC_DIVR    .COM   ::= Rem ; 
AC_CONS    .COM   ::= Cons "(" PInteger "," PInteger ")" ;
AC_STRUCT  .COM   ::= UIdent "." UIdent ;
AC_STRUCTas.COM   ::= UIdent "." UIdent "(" [PIdent] ")" ;
AC_CASEf   .COM   ::= Case "of"  "{" [LABELCOMS] "}"  ;
Labelcoms1 . LABELCOMS ::= UIdent "." UIdent ":" COMS ;
Labelcoms2 . LABELCOMS ::= UIdent "." UIdent "(" [PIdent] ")" ":" COMS ;
separator COMS ",";
separator LABELCOMS ";";

AC_RECORDf .COM ::= Rec "of"  "{" [LABELCOMS] "}"  ;
AC_DESTl   .COM ::= UIdent "." UIdent PIdent ;
AC_DESTlas .COM ::= UIdent "." UIdent "(" [PIdent] ")" PIdent ;
AC_GETf    .COM ::= Get PIdent "on" PIdent ; 
AC_HPUTf   .COM ::= Hput PIdent  UIdent "." UIdent;
AC_HCASEf  .COM ::= Hcase PIdent "of"  "{" [LABELCOMS] "}"  ; 
AC_PUTf    .COM ::= Put PIdent ;
AC_SPLITf  .COM ::= Split PIdent "into" PIdent PIdent    ;
AC_FORKf   .COM ::= Fork PIdent "as" "{" PIdent "with" [PIdent] ":" COMS ";" PIdent "with" [PIdent] ":" COMS "}" ;
AC_PLUGf   .COM ::= Plug [PIdent]  "as" "{" "with" "[" [PIdent] "]" ":" COMS ";" "with" "[" [PIdent] "]" ":" COMS "}" ;
AC_RUNf    .COM ::= Run PIdent "(" [PIdent] "|" [PIdent] "=>" [PIdent] ")" ;
AC_IDF     .COM ::= PIdent Ch_Id PIdent ;
AC_PROD    .COM ::= "(" [PIdent] ")" ;
AC_PRODELEM.COM ::= "#" CInteger "(" PIdent ")" ;
AC_EMSG    .COM ::= String ;



separator PIdent "," ;




AC_CLOSEf  .COM ::= Close PIdent ;
AC_HALTf   .COM ::= Halt [PIdent] ;

Positive   .CInteger ::= PInteger ;
Negative   .CInteger ::= "-" PInteger ;
separator CInteger "," ;


|]
