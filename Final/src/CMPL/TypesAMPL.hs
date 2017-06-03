{-# LANGUAGE DeriveGeneric #-}
module CMPL.TypesAMPL where

import Text.PrettyPrint.GenericPretty
import Text.PrettyPrint

import qualified  Data.Map as M

import Control.Concurrent.MVar
import Control.Concurrent.STM.TChan
import Network
import GHC.IO.Handle


----------------------------------------------------------------------
----------------------------------------------------------------------
--   DATA for the AMPL machine 
----------------------------------------------------------------------
data  SF a = FF | SS a

----------------------------------------------------------------------
--
--    The commands ... the only things allowed on the command stack C.
--
----------------------------------------------------------------------
type PosnInf = (String,NamePnPair) 

data AMPLCOM  = 
                                  -- concurrent comands
         AMC_GET CH
        |AMC_HPUT CH Int
        |AMC_HCASE CH [AMPLCOMS]
        |AMC_hcase [AMPLCOMS]
        |AMC_PUT CH
        |AMC_SPLIT CH (CH,CH)
        |AMC_FORK CH ((CH,[CH],AMPLCOMS),(CH,[CH],AMPLCOMS))
        |AMC_PLUG [CH] ([CH],AMPLCOMS)  ([CH],AMPLCOMS)
        |AMC_CLOSE CH
        |AMC_HALT [CH]
        |AMC_RUN TRANS String Int

        |AMC_LOAD Int               -- access
        |AMC_CALL String Int
        |AMC_STORE 
        |AMC_RET
        |AMC_PRET

        |AMC_STRING String -- string data types start
        |AMC_UNSTRING
        |AMC_TOSTR
        |AMC_TOINT
        |AMC_APPEND

        |AMC_OR
        |AMC_AND
 
        |AMC_INT Int -- Int data types start
        |AMC_ADD
        |AMC_SUB 
        |AMC_MUL 
        |AMC_DIVQ
        |AMC_DIVR -- Int data types end

        |AMC_LEQ
        |AMC_GEQ
        |AMC_LT 
        |AMC_GT 
        |AMC_EQ 
        |AMC_NEQ 

        |AMC_CHAR Char -- Char data types start

        |AMC_CONS Int Int 
        |AMC_CASE [AMPLCOMS] 
        |AMC_REC [AMPLCOMS]
        |AMC_DEST Int Int 
        |AMC_ID CH CH     
        |AMC_PROD Int -- no of elements in the product
        |AMC_PRODELEM Int -- here int is the element number of the tuple 
        |AMC_ERROR String   
        deriving (Eq,Ord,Show,Read,Generic)

instance () => Out (AMPLCOM )
----------------------------------------------------------------------
--
--    The values ... the only things on the stack.
--
----------------------------------------------------------------------

data VAL = V_CLO (AMPLCOMS,ENV) 
         | V_INT Int          -- currently the only built-in type
         | V_BOOL Bool
         | V_CHAR Char 
         | V_STRING String 
         | V_CONS (Int,[VAL])
         | V_REC  ([AMPLCOMS],ENV)
         | V_PROD [VAL]
          deriving (Show,Read,Generic)

instance Eq VAL where
  V_INT    n1 == V_INT    n2 = n1 == n2
  V_BOOL   b1 == V_BOOL   b2 = b1 == b2
  V_CHAR   c1 == V_CHAR   c2 = c1 == c2 
  V_STRING s1 == V_STRING s2 = s1 == s2 
  V_CONS   c1 == V_CONS c2 = handleEq_VCons (V_CONS c1) (V_CONS c2)
  _         == _         = False 

handleEq_VCons :: VAL -> VAL -> Bool 
handleEq_VCons val1 val2 
    = case (val1,val2) of 
          (V_CONS (n1,vs1),V_CONS(n2,vs2)) -> 
            case n1 == n2 of 
              True -> 
                 (and.zipWith (==) vs1) vs2
              False -> 
                 False


instance Ord VAL where
  V_INT  n1   <= V_INT  n2   = n1 <= n2
  V_BOOL b1   <= V_BOOL b2   = b1 <= b2
  V_CHAR c1   <= V_CHAR c2   = c1 <= c2 
  V_STRING s1 <= V_STRING s2 = s1 <= s2
  V_CONS c1   <= V_CONS c2 = handleLT_VCons (V_CONS c1) (V_CONS c2) 
  _           <= _         = False 

handleLT_VCons :: VAL -> VAL -> Bool 
handleLT_VCons val1 val2 
    = case (val1,val2) of 
          (V_CONS(n1,xs),V_CONS(n2,ys)) ->
            case n1 <  n2 of
              False ->
                 case n1 == n2 of 
                    True ->
                      (or.zipWith (<=) xs) ys 
                    False ->
                      False
              True -> 
                True 






instance () => Out (VAL)

----------------------------------------------------------------------
--
--    The polarities ... 
--
----------------------------------------------------------------------


data POLARITY = IN|OUT
  deriving (Eq,Ord,Show,Read,Generic)

instance () => Out (POLARITY)
----------------------------------------------------------------------
-- The queues ..
-- Allows many values to be "put" on queues but forking and plitting 
-- result in the process being suspended and attached to the channel
----------------------------------------------------------------------
data QUEUE = Q_PUT VAL QUEUE
           | Q_HPUT Int QUEUE
           | Q_SPLIT (CH,CH)
           | Q_FORK  (TRANS,ENV,((CH,[CH],AMPLCOMS),(CH,[CH],AMPLCOMS)))
           | Q_GET SUSPENSION
           | Q_CLOSE
           | Q_HALT
           | Q_EMPTY
           | Q_HCASE [AMPLCOMS]
           | Q_ID (CH,CH)
           deriving (Eq,Ord,Show,Read,Generic)

instance () => Out (QUEUE)

----------------------------------------------------------------------
--
-- The types for the channels for the channel manager 
--
----------------------------------------------------------------------

type STACK_STR = [String]
type CH = Int
type AMPLCHANNEL = (CH,QUEUE,QUEUE)   --  a channel (an identifier and an input and output queue)
type CHM = ([(CH,CH)],[AMPLCHANNEL])  --  the channel manager (a list of used channel names with identifications and a list of channels)
type TRANS = [(CH,POLARITY,CH)]      --  the tanslation from local channel names to global names (and the polarity)
type ENV = [VAL]                   --  the environmemt
type STACK = [VAL]
type SUSPENSION = PROCESS          --  a suspended process
type MACH = (PROCESSES,CHM,DEFNS)
type MACH' = (PROCESSES,CHM)
type DEFN = (String,AMPLCOMS)      -- defined process or funcion
type DEFNS = [DEFN] 
type PROCESSES = [PROCESS]
type AMPLCOMS =  [AMPLCOM ]
type PROCESS = (STACK,TRANS,ENV,AMPLCOMS)
type CHPROPERTY = (PortID,Socket,Maybe Handle) 
type CH_MAP = M.Map CH CHPROPERTY

type ErrorMsg             = String
type PosnPair             = (Int,Int)
type NamePnPair           = (String,PosnPair) 
type Name                 = String  
----------------------------------------------------------------------
----------------------------------------------------------------------
-- Types for the AMPL assembler
----------------------------------------------------------------------
----------------------------------------------------------------------

type COMS = [COM]
type CHANNEL       = NamePnPair
type CHANNELS      = [CHANNEL]
type STRUCTOR_NAME = (NamePnPair,NamePnPair)

data AMPLCODE = AMPLcode [HANDLE_SPEC] [HANDLE_SPEC] [STRUCTOR_SPEC] 
                        [STRUCTOR_SPEC] [PROCESS_SPEC] [FUNCTION_SPEC] (PosnPair,CHANNEL_SPEC,[COM])
   deriving (Eq,Ord,Show,Read,Generic )

instance () => Out (AMPLCODE)  

data AMPLCONSTRUCTS = HAND_SPEC [HANDLE_SPEC]
                    | COHAND_SPEC [HANDLE_SPEC]
                    | CONS_SPEC [STRUCTOR_SPEC]
                    | DEST_SPEC [STRUCTOR_SPEC]
                    | PROC_SPEC [PROCESS_SPEC]
                    | FUNC_SPEC [FUNCTION_SPEC]
                    | RUN_SPEC  (CHANNEL_SPEC,[COM]) 
                    | IMPORT_SPEC 

data CHANNEL_SPEC = Channel_specf [NamePnPair] [NamePnPair]
                  | Channel_spec [(Int,PosnPair)] [(Int,PosnPair)]
   deriving (Eq,Ord,Show,Read,Generic)

instance () => Out (CHANNEL_SPEC)

data HANDLE_SPEC = Handle_spec NamePnPair [NamePnPair]
   deriving (Eq,Ord,Show,Read,Generic)

instance () => Out (HANDLE_SPEC)

data STRUCTOR_SPEC = Struct_spec NamePnPair [(NamePnPair,(Int,PosnPair))]
   deriving (Eq,Ord,Show,Read,Generic)

instance () => Out (STRUCTOR_SPEC)

data PROCESS_SPEC = Process_specf NamePnPair [NamePnPair] ([NamePnPair],[NamePnPair]) COMS

   deriving (Eq,Ord,Show,Read,Generic)
-- Process_spec  String ([Int],[Int]) COMS
instance () => Out (PROCESS_SPEC)

data FUNCTION_SPEC = Function_specf NamePnPair [NamePnPair] COMS
                   | Function_spec NamePnPair COMS
   deriving (Eq,Ord,Show,Read,Generic)

instance () => Out (FUNCTION_SPEC)


---------------------------------------------------------------------------------
--  The commands:
--     commands have a basic and a fancy version
---------------------------------------------------------------------------------
data COM =
   AC_ASSIGN PosnPair NamePnPair COM 
 | AC_STOREf PosnPair NamePnPair
 | AC_LOADf  PosnPair NamePnPair
 | AC_RET    PosnPair 
 | AC_CALLf  PosnPair NamePnPair [NamePnPair]
  
 | AC_STRING   PosnPair (String,PosnPair) --String data types start
 | AC_CONCAT   PosnPair Int  
 | AC_UNSTRING PosnPair    --String data types end 

 | AC_CHAR   PosnPair (Char,PosnPair)   --character data types start
                     
 | AC_INT   PosnPair (Int,PosnPair)    --- Int data type start    
 | AC_GEQ   PosnPair
 | AC_LEQ   PosnPair 
 | AC_EQ    PosnPair 
 | AC_NEQ    PosnPair
 | AC_GT    PosnPair
 | AC_LT    PosnPair
 | AC_ADD   PosnPair 
 | AC_SUB   PosnPair 
 | AC_MUL   PosnPair 
 | AC_DIVQ  PosnPair 
 | AC_DIVR  PosnPair           -- Int data type end

 | AC_TOSTR PosnPair
 | AC_TOINT PosnPair

 | AC_OR PosnPair
 | AC_AND PosnPair

 | AC_APPEND PosnPair

 | AC_STRUCT STRUCTOR_NAME [NamePnPair]
 | AC_CASEf  PosnPair [(STRUCTOR_NAME,[NamePnPair],COMS)]
 | AC_GETf   PosnPair NamePnPair CHANNEL
 | AC_HPUTf  PosnPair NamePnPair STRUCTOR_NAME
 | AC_PUTf   PosnPair NamePnPair
 | AC_SPLITf PosnPair CHANNEL (CHANNEL,CHANNEL)
 | AC_FORKf  PosnPair CHANNEL ((CHANNEL,CHANNELS,COMS),(CHANNEL,CHANNELS,COMS))
 | AC_PLUGf  PosnPair [CHANNEL] (CHANNELS,COMS) (CHANNELS,COMS)
 | AC_IDf    PosnPair NamePnPair NamePnPair
 | AC_CLOSEf PosnPair CHANNEL
 | AC_HALTf  PosnPair [CHANNEL]
 | AC_HCASEf PosnPair CHANNEL [(STRUCTOR_NAME,[COM])]
 | AC_RUNf   PosnPair NamePnPair [NamePnPair] (CHANNELS,CHANNELS)
 | AC_RECORDf PosnPair [(STRUCTOR_NAME,[NamePnPair],COMS)]
 | AC_PROD [NamePnPair]  
 | AC_PRODELEM PosnPair Int NamePnPair
 | AC_EMSG String 
  deriving (Eq,Ord,Show,Read,Generic)

instance () => Out (COM)

