module CMPL.STConverter_CMPL where

import qualified CMPL.TypesCoreMPL as C 
import qualified CMPL.TypesAMPL as A 
import CMPL.CMPLParserMeta

import Data.List 
import Data.Maybe 

data Chan =  NormChan  C.Channel
           | SplitChan C.Channel (C.Channel,C.Channel) 
           deriving (Eq,Show)

type TransChan = [(C.Channel,C.Channel)]

transClose :: Close -> A.PosnPair
transClose x = case x of
  Close (pn,_) -> pn   

transHalt :: Halt -> A.PosnPair
transHalt x = case x of
  Halt (pn,_) -> pn   

transGet :: Get -> A.PosnPair
transGet x = case x of
  Get (pn,_) -> pn  

transPut :: Put  -> A.PosnPair
transPut x = case x of
  Put (pn,_) -> pn  

transHput :: Hput  -> A.PosnPair
transHput x = case x of
  Hput (pn,_) -> pn  

transHcase :: Hcase -> A.PosnPair
transHcase x = case x of
  Hcase (pn,_) -> pn  

transSplit :: Split -> A.PosnPair
transSplit x = case x of
  Split (pn,_) -> pn  

transFork :: Fork -> A.PosnPair
transFork x = case x of
  Fork (pn,_) -> pn  

transPlug :: Plug -> A.PosnPair
transPlug x = case x of
  Plug (pn,_) -> pn  

transCase :: Case -> A.PosnPair
transCase x = case x of
  Case (pn,_) -> pn  

transRec :: Rec -> A.PosnPair
transRec x = case x of
  Rec (pn,_) -> pn    

transCh_ID :: Ch_ID -> A.PosnPair
transCh_ID x = case x of
  Ch_ID (pn,x) -> pn  

transData :: Data -> A.PosnPair  
transData x = case x of
  Data (pn,x) -> pn 

transCodata :: Codata -> A.PosnPair
transCodata x = case x of 
  Codata (pn,x) -> pn 

transProtocol :: Protocol -> A.PosnPair
transProtocol x = case x of
  Protocol (pn,x) -> pn 

transCoprotocol :: Coprotocol -> A.PosnPair
transCoprotocol x = case x of
  Coprotocol (pn,x) -> pn 

transFun :: Fun -> A.PosnPair
transFun x = case x of
  Fun (pn,x) -> pn 

transProc :: Proc -> A.PosnPair
transProc x = case x of 
  Proc (pn,x) -> pn   

transMainRun :: MainRun -> A.PosnPair
transMainRun x = case x of
  MainRun (pn,x) -> pn 

-----------------------------------------------------
----------------------------------------------------

transPIdent :: PIdent -> A.NamePnPair
transPIdent x = case x of
  PIdent (pair,string) -> (string,pair)

transUIdent :: UIdent -> A.NamePnPair
transUIdent x = case x of
  UIdent (pair,string)  -> (string,pair)

transCChar :: CChar -> (Char,A.PosnPair)  
transCChar x = case x of
  CChar (pair,chr) -> (read chr::Char,pair)


transCInteger :: CInteger -> (Int,A.PosnPair)
transCInteger x = case x of
  CInteger (pair,int) -> (read int::Int,pair) 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transInfix0op :: Infix0op -> (String,(Int,Int))
transInfix0op x = case x of
  Infix0op (pair,string) -> (string,pair)

transInfix1op :: Infix1op -> (String,(Int,Int))
transInfix1op x = case x of
  Infix1op (pair,string) -> (string,pair)

transInfix2op :: Infix2op -> (String,(Int,Int))
transInfix2op x = case x of
  Infix2op (pair,string) -> (string,pair)

transInfix3op :: Infix3op -> (String,(Int,Int))
transInfix3op x = case x of
  Infix3op (pair,string) -> (string,pair)
     
transInfix4op :: Infix4op -> (String,(Int,Int))
transInfix4op x = case x of
  Infix4op (pair,string) -> (string,pair)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transCMPLProgram :: CMPLProgram -> C.MPLProg
transCMPLProgram x = case x of
  CMPLPROGRAM includefiless cmplconstructss runconstruct -> C.MPLProg
                  includes   
                  datas
                  codatas
                  protocols
                  coprotocols
                  functions
                  processes
                  run 
         where 
              includes    = C.Includes (map transINCLUDE_Files includefiless)
              all_defns   = transCMPL_Constructs_mul cmplconstructss
              datas       = filter get_datas       all_defns
              codatas     = filter get_codatas     all_defns
              protocols   = filter get_protocols   all_defns
              coprotocols = filter get_coprotocols all_defns
              functions   = filter get_functions   all_defns
              processes   = filter get_processes   all_defns
              run         = transRun_Construct runconstruct 
                         


get_datas :: C.Defn -> Bool 
get_datas x = case x of
    C.Data d -> True
    _      -> False

get_codatas :: C.Defn -> Bool
get_codatas x = case x of
    C.Codata cd -> True
    _         -> False 

get_protocols :: C.Defn -> Bool
get_protocols x = case x of 
    C.Protocol p -> True
    _          -> False 

get_coprotocols :: C.Defn -> Bool
get_coprotocols x = case x of 
    C.CoProtocol p -> True
    _            -> False 

get_functions :: C.Defn -> Bool
get_functions x = case x of
    C.Function f -> True
    _          -> False 

get_processes :: C.Defn -> Bool
get_processes x = case x of 
    C.Process p -> True
    _          -> False 


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transINCLUDE_Files :: INCLUDE_Files -> String
transINCLUDE_Files x = case x of
  INCLUDE_FILES slash dirpath -> transSlash slash ++ transDirPath dirpath 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------                                                                  

transSlash :: Slash -> String
transSlash x = case x of
  SLASH -> "/"
  SLASH_NONE -> ""

transDirPath :: DirPath -> String
transDirPath x = case x of
  DIRPATH dirnames -> (concat.map transDirName) dirnames


transDirName :: DirName -> String
transDirName x = case x of
  L_DIRNAME ident  -> (fst.transPIdent)  ident
  U_DIRNAME uident -> (fst.transUIdent) uident 

--type Ch_Pairs = (C.Channel,C.Channel)

---------------------------------------------------------------------------
---------------------------------------------------------------------------
transCMPL_Constructs_mul :: [CMPL_Constructs] -> [C.Defn]
transCMPL_Constructs_mul []         = []

transCMPL_Constructs_mul (ccons:cs) = (defn:defns)  
                     where
                         defn  = transCMPL_Constructs ccons
                         defns = transCMPL_Constructs_mul cs 



----------------------------------------------------------------------------
----------------------------------------------------------------------------

transCMPL_Constructs :: CMPL_Constructs ->  C.Defn 
transCMPL_Constructs x  = case x of
  DATA_CONSTRUCT data1 dataname structors  ->  
                       C.Data 
                        (
                          (  transData data1, 
                             (
                               transDataName dataname,
                               map transStructor structors
                             )  
                          )   

                        ) 

  CODATA_CONSTRUCT codata1 dataname structors  ->  
                      C.Codata 
                        (
                          ( 
                            transCodata codata1, 
                            (
                             transDataName dataname,
                             map transStructor structors
                            ) 
                          )
                        )

  PROTOCOL_CONSTRUCT protocol protocolname handles  ->  
                     C.Protocol
                        (
                          (
                           transProtocol protocol,
                           (   
                             transProtocolName protocolname,
                             map transHandle handles
                           ) 
                          )
                        )

  COPROTOCOL_CONSTRUCT coprotocol protocolname handles  ->  
                      C.CoProtocol
                        (
                          (
                            transCoprotocol coprotocol ,
                            (
                             transProtocolName protocolname,
                             map transHandle handles
                            )
                          )
                        )

  FUNCTION_CONSTRUCT fun fident arguments term ->  
                      C.Function
                            (
                              transFun fun , 
                              transFIdent fident 0, -- no of args not relevant here
                              map transArgument arguments,
                              transTerm term 
                            )

  FUNCTION_CONSTRUCT_CONST fun fident term ->  
                      C.Function
                            (
                              transFun fun , 
                              transFIdent fident 0, -- no of args not relevant here
                              [],
                              transTerm term 
                            )

  PROCESS_CONSTRUCT proc ident arguments channels1 channels2 process  ->  
                      C.Process 
                          ( 
                            transProc proc,
                            transPIdent ident,
                            map transArgument arguments,
                            map transChannel channels1,
                            map transChannel channels2,
                            transProcess process
                          )


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transRun_Construct :: Run_Construct -> C.Defn 
transRun_Construct x = case x of
  RUN_CONSTRUCT mrun channels1 channels2 process  -> 
                    C.MainRun 
                          (
                            transMainRun mrun,
                            map transChannel channels1,
                            map transChannel channels2,
                            transProcess process
                          )

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transProcess :: Process ->  C.Process 
transProcess x  = case x of
  PROCESS pcoms ->  transPComs pcoms 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
transPComs :: [PCom] -> C.Process
transPComs []  = []
transPComs (p:ps)  = (transPCom p):(transPComs ps)  

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transPCom :: PCom -> C.ProcessCommand 
transPCom x  = case x of
  PROCESSrun ident terms channels1 channels2  -> C.PRun 
                     ( snd tpident,
                       tpident,
                       map transTerm terms,
                       map transChannel channels1,
                       map transChannel channels2
                     )
                  where
                    tpident = transPIdent ident   

  PROCESSclose close ident  -> C.PClose
                     ( transClose close,
                       transPIdent ident
                     )

  PROCESSend halt idents  -> C.PHalt
                     ( transHalt halt ,
                       map transPIdent idents
                     )

  PROCESSget get ident channel   -> C.PGet 
                     ( transGet get , 
                       transPIdent ident,
                       transChannel channel
                     )

  PROCESSput put term channel  -> C.PPut 
                     ( transPut put, 
                       transTerm term,
                       transChannel channel
                     )

  PROCESSputevent hput eventhandle channel  -> C.PHput
                     ( transHput hput , 
                       transEventHandle eventhandle,
                       transChannel channel
                     )

  PROCESSSwitch hcase channel processphr_hcases   -> 
                  C.PHcase 
                     ( transHcase hcase ,
                       transChannel channel,
                       transProcessPhrase_hcases processphr_hcases
                     )

  PROCESSsplit split channel channels  -> C.PSplit 
                     (
                       transSplit split,
                       transChannel channel,
                       map transChannel channels
                     )

  PROCESSfork fork ident (forkpart1:forkpart2:[])   ->  
                      C.PFork ( transFork fork ,
                                 ch , ((chan1,chans1,coms1):
                                      (chan2,chans2,coms2):[]) 
                               ) 
                      where
                        ch =  transPIdent ident
                        (coms1,chan1,chans1) = transForkPart forkpart1
                        (coms2,chan2,chans2) = transForkPart forkpart2

  PROCESSplug plug ps   -> compile_Plug plug ps []                     

  PROCESScase case1 term processphrases  -> 
                  C.PCase 
                    (
                      transCase case1,
                      transTerm term,
                      transProcessPhrase_pcases processphrases
                    )

  PROCESSId ident1 chid ident2  ->  
                     C.PEqual (
                                 transCh_ID chid,
                                 transPIdent ident1,
                                 transPIdent ident2
                               )  

  PROCESSREC rec recordentryprocs ->  
              C.PRec (
                       transRec rec,
                       transRecordEntryProcs recordentryprocs
                     )                
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


compile_Plug :: Plug -> [PlugPart] ->[C.ProcessCommand] -> C.ProcessCommand
compile_Plug plug (p1:ps) pcs = case pcs of 
       [] -> case (not.null.tail) ps of 
                  True   -> compile_Plug plug (tail ps) [cpf] 
                  False  -> cpf 
          where
               cp1  = transPlugPart p1 
               p2   = head ps 
               chs1 = get_Channels p1 
               cp2  = transPlugPart p2 
               chs2 = get_Channels p2 
               pchs = intersect_cust chs1 chs2 
               pchs1= list_diff chs1 pchs 
               pchs2= list_diff chs2 pchs 
               cpf   = C.PPlug ( transPlug plug ,
                                 pchs,(pchs1,cp1),(pchs2,cp2)
                               )  

       [pc] -> case ps of
                [] -> cpf             
                _  -> compile_Plug plug ps [cpf] 
          where        
              -- total channels of the first process
              chs_fp    = get_Channels p1  
              cp1       = transPlugPart p1  
              C.PPlug (_,c0,(c1,coms1),(c2,coms2)) = pc 
              -- total chs from already compiles processes
              chs_alcp  = c1 ++ c2 
              chs_plug  = intersect_cust chs_alcp chs_fp 
              chs1      = list_diff chs_alcp chs_plug
              chs2      = list_diff chs_fp chs_plug
              cpf       = C.PPlug ((0,0),chs_plug,(chs1,pcs),(chs2,cp1))                          
             

get_Channels :: PlugPart -> [C.Channel]
get_Channels ppart  = collect_chns ppart' 
       where
           ppart' = transPlugPart ppart  

collect_chns :: C.Process ->[C.Channel]
collect_chns ps = chanSToChannelS ls []
    where
       ls = collect_chns_helper ps [] 

chanSToChannelS :: [Chan] -> [C.Channel] -> [C.Channel]
chanSToChannelS []     l = l 
chanSToChannelS (c:cs) l = case c of 
         NormChan cname          -> chanSToChannelS cs (cname:l)
         SplitChan cname (c1,c2) -> chanSToChannelS cs l' 
                             where
                               l' = list_diff (cname:l) [c1,c2]

collect_chns_helper :: C.Process -> [Chan] -> [Chan] 
collect_chns_helper []  chan      = chan  
collect_chns_helper (p:ps) cp     = case p of
  ----------------------------------------------------
   C.PRun (_,pname,terms,chsin,chsout) -> collect_chns_helper ps coll_chns
        where
             coll_chns = map (\x -> NormChan x) (chsin++chsout)        

   ----------------------------------------------------
   C.PClose (_,ch)  -> collect_chns_helper ps updated_ch_list 
        where
            updated_ch_list = collect_chns_PClose cp ch  
   ----------------------------------------------------     
   C.PHalt (_,chs)  -> collect_chns_helper ps updated_ch_list
        where 
           updated_ch_list = collect_chns_PHalt cp chs 
         
  ------------------------------------------------------ 
   C.PSplit (_,ch,ch1:ch2:[]) -> 
            collect_chns_helper ps ((SplitChan ch (ch1,ch2)):cp)         
  ------------------------------------------------------
   C.PFork (_,ch,(_,ch1,_):(_,ch2,_):[]) ->  
            collect_chns_helper ps ((NormChan ch):(coll_chns ++ cp))
          where
            coll_chns = map (\x -> NormChan x) (ch1++ch2)    

  ------------------------------------------------------     
   C.PPlug (_,_,(chs1,_),(chs2,_)) -> collect_chns_helper ps coll_chns
        where
          coll_chns = collect_chns_PPlug cp (chs1++chs2)
  ------------------------------------------------------
   C.PEqual (_,ch1,ch2) -> collect_chns_helper ps coll_chns
        where
          coll_chns = collect_chns_PEqual cp (ch1,ch2)
  ------------------------------------------------------
   _                        -> collect_chns_helper ps cp 



---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
collect_chns_PFork :: [Chan] -> [C.Channel] -> [Chan]
collect_chns_PFork chans chs = nchs ++ chans
                where 
                  rem_chs = filter (not.is_res_of_split chans) chs
                  nchs    = map  NormChan rem_chs    

collect_chns_PHalt :: [Chan] -> [C.Channel] -> [Chan]
collect_chns_PHalt chans chs = case bool1 of 
                                  True  -> chans 
                                  False -> new_tot_chns
                            where 
                              bool1         = (and.map (\x -> is_res_of_split chans x)) chs 
                              new_tot_chns  = map (\c -> NormChan c) chs ++ chans 


collect_chns_PEqual :: [Chan] -> (C.Channel,C.Channel) -> [Chan]
collect_chns_PEqual chans (ch1,ch2) = case bool1 of 
                                  True  -> case bool2 of 
                                             True  -> chans  
                                             False -> (NormChan ch2): chans      
                                  False -> case bool2 of
                                             True  -> (NormChan ch1):chans 
                                             False -> (NormChan ch1):(NormChan ch2):chans 
                            where 
                              bool1 = is_res_of_split chans ch1 
                              bool2 = is_res_of_split chans ch2    

collect_chns_PPlug :: [Chan] -> [C.Channel] -> [Chan]
collect_chns_PPlug chans chs = nchs ++ chans
                where 
                  rem_chs = filter (not.is_res_of_split chans) chs
                  nchs    = map  NormChan rem_chs    



collect_chns_PClose :: [Chan] -> C.Channel -> [Chan]
collect_chns_PClose chs ch = case is_res_of_split chs ch of
           True  -> chs 
           False -> (NormChan ch):chs  

-- this function tells that the Channel to be closed is
-- the result of a split or not,True if it is 
is_res_of_split :: [Chan] -> C.Channel -> Bool
is_res_of_split [] _   = False  
is_res_of_split (x:xs) ch = case x of
         NormChan _  -> is_res_of_split xs ch 
         SplitChan _ (sch1,sch2) -> ch == sch1 || ch == sch2
 
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
newToOld :: [Chan] -> TransChan -> [Chan]
newToOld chans trans = map (transNewToOld trans) chans

transNewToOld ::  TransChan -> Chan -> Chan
transNewToOld trans (NormChan newchan) = 
             case lookup newchan trans of 
                    Nothing      ->
                         error $ " Unknown channel." ++ fst newchan ++ "\n" ++ show trans 
                    Just oldChan -> 
                           (NormChan oldChan)

transNewToOld trans (SplitChan newchan pairs) = 
             case lookup newchan trans of 
                    Nothing      ->
                         error $ " Unknown channel." ++ fst newchan ++ "\n" ++ show trans 
                    Just oldChan -> 
                           (SplitChan oldChan pairs)
                    

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
transPlugPart :: PlugPart -> C.Process 
transPlugPart x  = case x of
  PLUGPART process -> 
     transProcess process  
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
transProcessPhrase_pcases :: [ProcessPhrase_pcase] -> [C.ProcessPhrase_pcase] 
transProcessPhrase_pcases [] = []
transProcessPhrase_pcases (p:ps) = (transProcessPhrase_pcase p) : 
                                   (transProcessPhrase_pcases ps) 


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
transProcessPhrase_pcase :: ProcessPhrase_pcase -> C.ProcessPhrase_pcase 
transProcessPhrase_pcase x = case x of
  PROC_PHR_PCASE pattern process -> 
      (transPattern pattern, transProcess process)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transEventHandle :: EventHandle -> C.Event_Handle
transEventHandle x = case x of
  EVENTHANDLE uident1 uident2  -> ( 
                                       transUIdent uident1,
                                       transUIdent uident2
                                   )

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
transProcessPhrase_hcases :: [ProcessPhrase_hcase] -> [C.ProcessPhrase_hcase] 
transProcessPhrase_hcases [] = []
transProcessPhrase_hcases (h:hs) =  
             (transProcessPhrase_hcase h) : 
             (transProcessPhrase_hcases hs) 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transProcessPhrase_hcase :: ProcessPhrase_hcase -> C.ProcessPhrase_hcase 
transProcessPhrase_hcase x = case x of
  PROC_PHR_HCASE eventhandle process -> 
                                     (
                                       transEventHandle eventhandle,
                                       transProcess process
                                      )

-------------------------------------------------------------------------------
--------------------------------------------------------------------------------
transForkPart :: ForkPart -> (C.Process,C.Channel,[C.Channel])
transForkPart x = case x of
  FORKPARTfull ident process -> (proc',ch,chans')
                    where   
                         proc'  = transProcess process 
                         chans  = collect_chns proc' 
                         ch     = transPIdent ident
                         chans' = list_diff chans [ch] 
                           

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
transChannel :: Channel -> A.NamePnPair
transChannel x = case x of
  CHANNEL pident -> transPIdent pident
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
transArgument :: Argument -> A.NamePnPair
transArgument x = case x of
  LARGUMENT uident -> transUIdent uident
  UARGUMENT ident ->  transPIdent ident
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--transStructor :: Structor -> C.DataClause 
transStructor x = case x of
  STRUCTOR uident integer  -> (transUIdent uident,transCInteger integer)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
transDataName :: DataName -> A.NamePnPair
transDataName x = case x of
  DATANAME_basic uident  -> (name,posn)
                               where (name,posn) = transUIdent uident

  DATANAME_infix0op uident1 infixop uident2  -> ( name ++
                                                  ((fst.transInfix0op) infixop) ++
                                                  ((fst.transUIdent) uident2)
                                                  ,
                                                  posn 
                                                )  
                                              where (name,posn) = transUIdent uident1

  DATANAME_infix1op uident1 infixop uident2  -> (  name ++
                                                   ((fst.transInfix1op) infixop) ++
                                                   ((fst.transUIdent) uident2)
                                                   ,
                                                   posn 
                                                )  
                                              where (name,posn) = transUIdent uident1

  DATANAME_infix2op uident1 infixop uident2   -> (  name ++
                                                    ((fst.transInfix2op) infixop) ++
                                                    ((fst.transUIdent) uident2),
                                                    posn 
                                                  )  
                                               where (name,posn) = transUIdent uident1  

  DATANAME_infix3op uident1 infixop uident2   -> (  name ++
                                                    ((fst.transInfix3op) infixop) ++
                                                    ((fst.transUIdent) uident2),
                                                    posn 
                                                 )  
                                              where (name,posn) = transUIdent uident1  

  DATANAME_infix4op uident1 infixop uident2   -> (  name ++
                                                    ((fst.transInfix4op) infixop) ++
                                                    ((fst.transUIdent) uident2),
                                                    posn 
                                                 )  
                                              where (name,posn) = transUIdent uident1  

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

flist2args = ["addI","subI","mul_I","quot_I","rem_I","eq_I","leq_I","eq_C",
              "leq_C","eqS","leqS","concatS","and","or","toInt","toStr","appendL"]

--flis

transFIdent :: FIdent -> Int -> C.FuncName 
transFIdent x nargs = case x of
  ID pident   -> case nargs of 
                   2 -> case transPIdent pident of
                      ("addI",      pn)     -> C.Inbuilt (C.Add_I,     pn) 
                      ("subI",      pn)     -> C.Inbuilt (C.Sub_I,     pn) 
                      ("mul_I",     pn)     -> C.Inbuilt (C.Mul_I,     pn)
                      ("quot_I",    pn)     -> C.Inbuilt (C.DivQ_I,    pn)
                      ("rem_I",     pn)     -> C.Inbuilt (C.DivR_I,    pn)
                      ("eq_I",      pn)     -> C.Inbuilt (C.Eq_I,      pn) 
                      ("leq_I",     pn)     -> C.Inbuilt (C.Leq_I,     pn) 
                      ("eq_C",      pn)     -> C.Inbuilt (C.Eq_C,      pn)
                      ("leq_C",     pn)     -> C.Inbuilt (C.Leq_C,     pn) 
                      ("eqS",       pn)     -> C.Inbuilt (C.Eq_S,      pn)
                      ("leqS",      pn)     -> C.Inbuilt (C.Leq_S,     pn)
                      ("concatS",   pn)     -> C.Inbuilt (C.Concat_S nargs,pn)
                      ("toStr",     pn)     -> C.Inbuilt (C.ToStr,     pn) 
                      ("toInt",     pn)     -> C.Inbuilt (C.ToInt,     pn) 
                      ("or",        pn)     -> C.Inbuilt (C.Or_B,     pn) 
                      ("and",       pn)     -> C.Inbuilt (C.And_B,     pn)
                      ("appendL",   pn)     -> C.Inbuilt (C.Append,    pn) 
                      (str,         pn)     ->
                             case str `elem` ["unstring"] of 
                                      True  -> error $ equalsST ++ femsg pn ++ " Function " ++
                                                       str ++ " is assigned incorrect number of arguments."
                                                       ++ equalsST
                                      False -> C.Custom  (str,pn)  

                   1 -> case transPIdent pident of 
                      ("unstring",  pn)     -> C.Inbuilt (C.Unstring_S,pn)
                      ("concatS",   pn)     -> error $ equalsST ++ femsg pn ++ " Function concatS " ++ 
                                                       "should have 2 or more arguments but has been given one."
                                                       ++ equalsST
                      (str,         pn)     ->
                             case str `elem` flist2args  of  
                                      True  -> error $ equalsST ++ femsg pn ++ " Function " ++
                                                       str ++ " 2 arguments but has been given one."
                                                       ++ equalsST
                                      False -> C.Custom  (str,pn)   
                      --("reverse"   ,pn)     -> C.Inbuilt (C.Reverse_S   ,pn)
                   _ -> case transPIdent pident of 
                            ("concatS",   pn)     -> C.Inbuilt (C.Concat_S nargs,pn)
                            ("unstring",  pn)     -> error $ equalsST ++ femsg pn ++ " Function unstring " ++ 
                                                             "should have 1 argumnets but has been given more than one."
                            (str,         pn)     ->
                                 case str `elem` flist2args of   
                                          True  -> error $ equalsST ++ femsg pn ++ " Function " ++
                                                           str ++ " 2 arguments but has been given more than 2."
                                                           ++ equalsST
                                          False -> C.Custom  (str,pn)                                   
                             

  SECTION0 infixop  -> C.Custom (transInfix0op infixop)

  SECTION1 infixop  -> C.Custom $ transInfix1op infixop

  SECTION2 infixop  -> C.Custom $ transInfix2op infixop

  SECTION3 infixop  -> case t of
                        "+" -> C.Inbuilt (C.Add_I,pn)
                        "-" -> C.Inbuilt (C.Sub_I,pn)
                        _   -> C.Custom  (t,pn) 
                   where (t,pn) =  transInfix3op infixop

  SECTION4 infixop  -> case t of
                "*"      -> C.Inbuilt (C.Mul_I,pn)
                "/"      -> C.Inbuilt (C.DivQ_I,pn)
                "%"      -> C.Inbuilt (C.DivR_I,pn)
                _        -> C.Custom (t,pn) 
              where (t,pn) = transInfix4op infixop



equalsST = "\n==========================================================\n" 

femsg :: (Int,Int) -> String 
femsg (l,c) = "At (" ++ show l ++ " , " ++ show c ++ " ):"           

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transProtocolName :: ProtocolName -> A.NamePnPair
transProtocolName x = case x of
  PROTOCOLNAME uident  -> transUIdent uident

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transHandle :: Handle -> A.NamePnPair
transHandle x = case x of
  HANDLE uident  -> transUIdent uident

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transTerm :: Term -> C.Term 
transTerm x = case x of
  
  CUST_IN_FUNC fident terms -> case transFIdent fident (length terms) of 
                     C.Inbuilt (fname,pn)   -> C.TCall (C.Inbuilt (fname,pn), map transTerm terms)
                     C.Custom  (str,  pn)   -> C.TCall (C.Custom  (str,  pn), map transTerm terms)           

  CONSTERM_Param dataname uident terms  -> C.TCons 
                  (
                    ( transDataName dataname,
                      transUIdent uident
                    ),   
                    map transTerm terms
                  )

  CONSTERM_WOParam dataname uident -> C.TCons 
                  (
                    ( transDataName dataname ,
                      transUIdent uident
                    ) ,  
                    []
                  )
  

  Infix0TERM term1 infixop term2  -> C.TCall
                    (
                      C.Custom (transInfix0op infixop),
                      (transTerm term1) :
                      (transTerm term2) : [] 
                    ) 

  Infix1TERM term1 infixop term2  -> C.TCall
                  (
                    C.Custom $ (transInfix1op infixop),
                    (transTerm term1) :
                    (transTerm term2) : [] 
                  ) 

  Infix2TERM term1 infixop term2   -> C.TCall
                  (
                    C.Custom $ (transInfix2op infixop),
                    (transTerm term1) :
                    (transTerm term2) : [] 
                  ) 

  Infix3TERM term1 infixop term2   -> case t of 
       "+" -> C.TCall
                  (
                    C.Inbuilt (C.Add_I,pn),
                    (transTerm term1) :
                    (transTerm term2) : [] 
                  ) 

       "-" -> C.TCall
                  (
                    C.Inbuilt (C.Sub_I,pn),
                    (transTerm term1) :
                    (transTerm term2) : [] 
                  )    

       _   -> C.TCall
                  (
                    C.Custom (t,pn) ,
                    (transTerm term1) :
                    (transTerm term2) : [] 
                  )                   

     where (t,pn) = transInfix3op infixop            

  Infix4TERM term1 infixop term2  -> case t of 
       "*" -> C.TCall
                  (
                    C.Inbuilt (C.Mul_I,pn),
                    (transTerm term1) :
                    (transTerm term2) : [] 
                  ) 

       "/" -> C.TCall
                  (
                    C.Inbuilt (C.DivQ_I,pn),
                    (transTerm term1) :
                    (transTerm term2) : []
                  )    

       "%" -> C.TCall
                  (
                    C.Inbuilt (C.DivR_I,pn),
                    (transTerm term1) :
                    (transTerm term2) : []
                  )    

       _   -> C.TCall
                  (
                    C.Custom (t,pn),
                    (transTerm term1) :
                    (transTerm term2) : [] 
                  )                   

     where (t,pn) = transInfix4op infixop  

  CASETERM case1 term patterndefs  -> C.TCase 
                  (
                    transTerm term,
                    map transPatternDef patterndefs,
                    transCase case1
                  ) 

  VARTERM ident         -> C.TVar    (transPIdent ident)

  CONSTTERM_STR str     -> C.TConstS (str,(0,0))

  CONSTTERM_INT int     -> C.TConstI (transCInteger int)

  CONSTTERM_CHAR chr    -> C.TConstC (transCChar chr)

  RECORDTERMALT rec recordentryalts   -> 
                           C.TRec 
                             (
                              crecs,
                              (snd.fst'.fst.head) crecs
                             )  
            where 
              crecs = map transRecordEntryAlt recordentryalts                      

  PRODTERM terms -> C.TProd (
                               
                              (map transTerm terms)
                            )

  GET_ELEM cint term -> C.TProdElem (intprod,transTerm term,posn_prod) 
                where
                   (intprod,posn_prod) = transCInteger cint 

  ERROR_MSG emsg -> C.TError emsg 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transRecordEntryAlt :: RecordEntryAlt -> (C.Struct_Handle,C.Term) 
transRecordEntryAlt x = case x of
  RECORDENTRY_ALT pattern term -> (transPattern pattern,transTerm term)


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
transRecordEntryProcs :: [RecordEntryProc] -> [(C.Struct_Handle,[C.ProcessCommand])]
transRecordEntryProcs []     = []                         
transRecordEntryProcs (r:rs) = (transRecordEntryProc r):
                               (transRecordEntryProcs rs)
                       

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transRecordEntryProc :: RecordEntryProc ->(C.Struct_Handle,[C.ProcessCommand]) 
transRecordEntryProc x = case x of
  RECORDENTRY_PROC pattern pcoms ->  
             (transPattern pattern,transPComs pcoms)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

transPatternDef :: PatternDef -> (C.Struct_Handle,[C.Term])
transPatternDef x = case x of
  PATTERNDEFshort pattern alt_terms -> (
                                         transPattern pattern,
                                         map transTerm_Alt alt_terms
                                       )

transTerm_Alt :: Term_Alt -> C.Term
transTerm_Alt x = case x of 
  TERM_ALT term ->  transTerm term 

transPattern :: Pattern -> C.Struct_Handle
transPattern x = case x of
  PATTERN_PARAM uident1 uident2 idents  -> ( transUIdent uident1,
                                             transUIdent uident2,
                                             map (transPIdent) idents
                                           )
  PATTERN_WOPARAM uident1 uident2       -> (transUIdent uident1,transUIdent uident2,[])

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

list_diff :: [(String,(Int,Int))] -> [(String,(Int,Int))] -> [(String,(Int,Int))]
list_diff = deleteFirstsBy boolCond 

intersect_cust :: [(String,(Int,Int))] -> [(String,(Int,Int))] -> [(String,(Int,Int))]
intersect_cust = intersectBy boolCond 

boolCond :: (String,(Int,Int)) -> (String,(Int,Int)) -> Bool 
boolCond (a1,b1) (a2,b2) =  (a1==a2) 

fst' :: (a,b,c) -> a 
fst' (x,y,z) = x 