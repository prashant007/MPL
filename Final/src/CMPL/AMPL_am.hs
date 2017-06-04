module  CMPL.AMPL_am where
import  CMPL.TypesAMPL
import  CMPL.Terminal

import System.Process 
import Control.Concurrent

import Control.Monad.IO.Class
import System.Console.ANSI
import Network as N 
import Network.Socket
import System.IO

import Control.Monad.Trans.State.Lazy
import Control.Monad.Identity

import qualified Data.Map as M
----------------------------------------------------------------------
----------------------------------------------------------------------
--
--        Abstract machine for Message Passing Language (AMPL)
--
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
--
-- Command effects on the channel manager 
--    channel identifier, polarity, component to be queued, list of channels to be modified
--
----------------------------------------------------------------------

enqueue:: Int -> POLARITY -> QUEUE -> [AMPLCHANNEL] -> [AMPLCHANNEL]
enqueue _ _ _ [] = error "Error: No channels in <enqueue>!"
enqueue n pol v ((m,q,q'):chs)
       | n==m && pol==OUT = (m,putqueue v q,q'):chs
       | n==m && pol==IN = (m,q,putqueue v q'):chs
       | otherwise = (m,q,q'):(enqueue n pol v chs)
     where
        putqueue v (Q_PUT v' q) = (Q_PUT v' (putqueue v q))
        putqueue v (Q_HPUT n q) = (Q_HPUT n (putqueue  v q))
        putqueue v Q_EMPTY = v
        putqueue v _ = error "Error: Inappropriate queue state in <enqueue>!"

enqueues :: [(Int,POLARITY)] -> QUEUE -> [AMPLCHANNEL] -> [AMPLCHANNEL]
enqueues [] _ chs = chs
enqueues ((n,pol):ns) q chs = enqueues ns q (enqueue n pol q chs )

           


--  Utilities for command implementation:
--  get_ch takes a channel , a channel polarity , the process suspension 
--  and a channel manager and returns a channel manager.
--
get_ch:: Int -> POLARITY -> SUSPENSION -> CHM -> CHM
get_ch ch pol suspended (names, chs) = (names, enqueue  ch pol (Q_GET suspended) chs)

put_ch::  Int -> POLARITY -> VAL -> CHM -> CHM
put_ch ch pol val (names, chs) = (names, enqueue ch pol (Q_PUT val Q_EMPTY) chs)

-- split takes a channel and divides it into 2 channel names
split_ch:: Int -> POLARITY -> CHM -> ((Int,Int),CHM)
split_ch ch pol (names,chs) = ((ch1,ch2),(names2,chs2))
    where (ch1,names1) = newname names -- newname takes the list of used channels 
                                       -- and providesa new name
          (ch2,names2) = newname names1
          chs1 = enqueue ch pol (Q_SPLIT (ch1,ch2)) chs
          chs2 = add_channel (ch1,Q_EMPTY,Q_EMPTY) (add_channel (ch2,Q_EMPTY,Q_EMPTY) chs1)

close_ch:: Int -> POLARITY -> CHM -> CHM
close_ch ch pol (names,chs) = (names,enqueue ch pol Q_CLOSE chs)

halt_ch:: Int -> POLARITY -> CHM -> CHM
halt_ch ch pol (names,chs) = (names,enqueue ch pol Q_HALT chs)

hput_ch :: Int -> POLARITY -> Int -> CHM -> CHM
hput_ch ch pol n (names,chs) = (names, enqueue ch pol (Q_HPUT n Q_EMPTY) chs) 

-- for the global channel names
newname :: [(Int,Int)] -> (Int,[(Int,Int)])
newname names = newname' 0 names

newname' :: Int -> [(Int,Int)] -> (Int,[(Int,Int)])
newname' n [] = (n,[(n,n)])
newname' n ((m,m'):ms)
         | n<m = (n,(n,n):(m,m'):ms)
         | otherwise = (\(n',ns) -> (n',(m,m'):ns)) (newname' (n+1) ms)

remove_name _ [] = []
remove_name n (m:ms)| n==m = ms
                    | otherwise = m:(remove_name n ms)

get_from_list str list n 
    | n < 0 = error (str++"Index negative"++(show n) )
    | n >= (length list) = error $ str ++ "Index too large  " ++ (show n) ++ "  in  " ++ (show list)
    | otherwise = list !! n


-- for the translation tabf_les
--  local to global is "translation"
--  global to physical allows identification of global channels and the association of sockets

lookup_trans str [] = error "Error: translation of name not found in <lookup_trans>"
lookup_trans str ((str',pol,ch):rest)
        | str==str' = (ch,pol)
        | otherwise = lookup_trans str rest

lookup_local2physical :: CH -> TRANS -> [(CH,CH)] -> (CH,POLARITY)
lookup_local2physical str [] names = error $ "Error: translation of name, " ++ show str ++ ", not found in <lookup_local2physical>" 
lookup_local2physical str ((str',pol,ch):rest) names
        | str==str' = (lookup_global2physical ch names,pol)
        | otherwise = lookup_local2physical str rest names

lookup_global2physical n [] = error "Error: equivalent channel not found in <lookup_global2physical>"
lookup_global2physical n ((n',ch):rest)
        | n==n' = ch 
        | otherwise = lookup_global2physical n rest


remove_trans _ [] = error "Error: translation of name not found in <remove_trans>"
remove_trans str ((str',pol,ch):ms)
           | str==str' = ms
           | otherwise = (str',pol,ch):(remove_trans str ms)

remove_gtrans _ [] = []
remove_gtrans n ((n',ch):ms)
           | n==ch = remove_gtrans n ms
           | otherwise = (n',ch):(remove_gtrans n ms)

modify_gtrans n m [] = []
modify_gtrans n m ((p,q):rest) | n==q = (p,m):(modify_gtrans n m rest)
                               | otherwise = (p,q):(modify_gtrans n m rest)
                               
replace_gtrans n m [] = error "Error: channel for replacement not found by <replace_gtrans>"
replace_gtrans n m ((n',m'):rest)| n==n' = (n,m):rest
                                 | otherwise = (n',m'):(replace_gtrans n m rest)

restrict_trans [] names = []
restrict_trans ((str,pol,ch):ts) names
   | inlist str names = ((str,pol,ch):(restrict_trans ts names))
   | otherwise = (restrict_trans ts names)

compose_trans [] _ = []
compose_trans tot@((n,pol,m):rest) t | pol == pol' = (n,pol',n'):(compose_trans rest t) 
                                 | otherwise = error $ "Polarity mismatch in process call!" ++ show tot 
                                                      ++ "\n" ++ show t ++ "\n" ++ show n ++ show m ++
                                                      show n' ++ "\n" ++ show pol' 
   where (n',pol') = lookup_trans m t

inlist a [] = False
inlist a (b:rest)
   | a==b = True
   | otherwise = inlist a rest

lookup_defn:: String -> DEFNS -> AMPLCOMS
lookup_defn str [] = error ("Error: definition of name <"++str++"> not found")
lookup_defn str ((str',c):rest)
        | str==str' = c
        | otherwise = lookup_defn str rest

----------------------------------------------------------------------------------------------------------
--
--    Machine actions: using a simple process then interact cycle 
--   (this strategy starves the processing by delaying all interaction until there is no processing to be done
--    ... a better strategy for parallelism would be to arrange there are as many active processes as possible
--    i.e. by performing all interactions first)
--
run_cm':: MACH ->   StateT CH_MAP IO MACH
run_cm' (p,(chlist,queues),defns) = do 
                  let negChannel1 = get_neg_channel_list chlist 
                  chSocketMap <- liftIO $ channelMap negChannel1
                  put chSocketMap
                  run_cm (p,(chlist,queues),defns) 

run_cm:: MACH -> StateT CH_MAP IO MACH
run_cm s  = do
     nmVar <- get 
     s' <- action_ps s 
     if s == s' 
       then do
        return s 
       else do
        run_cm s' 
----------------------------------------------------------------------------------------
--action_ps:: MACH -> StateT CH_MAP IO MACH 
action_ps (p:ps,chs,defs)  = do
      (ps',chs') <- find_interact chs 
      if chs == chs'
         then do 
             let Identity ((p',chs'),_) = runStateT (process_step p) (chs,defs) 
             return (p'++ps,chs',defs)
         else do
             return(ps'++(p:ps),chs',defs)
         
action_ps ([],chs,defs)  = do
      (ps',chs') <- find_interact chs 
      return (ps',chs',defs)

---------------------------------------------------------------------------------------
-------------------Helper Functions for run_cm'----------------------------------------
get_neg_channel_list chlist = filter (\x -> x < 0 ) $ map (\(a,b) -> a) $ chlist


-- get a map of negative channel numbers with port numbers
channelMap :: [CH] -> IO (CH_MAP)
channelMap chlist = do
         let 
           chPortList =((map (\(x,y) ->(x,PortNumber y))).(zip chlist).(take len)) [44460 .. ]
           len = length chlist 
         chmap <- get_ch_prop chPortList
         return $ M.fromList chmap  
          
       
           
--associate with each channel a triple of port,socket,handle 

get_ch_prop :: [(CH,PortID)]->  IO [(CH, CHPROPERTY)]
get_ch_prop []  = return []
get_ch_prop ((ch,port):rem)  = do 
    socket  <- listenOn port
    let 
      pair = (ch,(port,socket,Nothing))
    remPair <- get_ch_prop rem
    return (pair:remPair)

----------------------------------------------------------------------------------

---------------------------------------------------------------------------------
--
-- Channel interaction step (modify to interact with terminal when channel is negative).
--
---------------------------------------------------------------------------------

find_interact:: CHM -> StateT CH_MAP IO MACH' 
---------------------------------------------------------------------------------
find_interact (names,[])  = return ([],(names,[])) 
-----------------------------------------------------------------------------
find_interact (names, (ch,q,Q_ID (ch1,ch2)):chs) 
      | (not(ch1==ch)) = error "Channel identification on inappropriate channel" 
      | otherwise = do
                 nmVar <- get 
                 case put_left q ch2 chs of
                       SS chs' -> find_interact ((modify_gtrans ch1 ch2 names),chs') 
                       FF -> do (proc,(names,chm)) <- find_interact (names,chs) 
                                return (proc,(names,(ch,q,Q_ID (ch1,ch2)):chm))
-----------------------------------------------------------------------------
find_interact (names, (ch,Q_ID (ch1,ch2),q):chs) 
      | (not(ch1==ch)) = error "Channel identification on inappropriate channel" 
      | otherwise = case put_right q ch2 chs of
                       SS chs' -> find_interact ((modify_gtrans ch1 ch2 names),chs') 
                       FF -> do (proc,(names,chm)) <- find_interact (names,chs) 
                                return (proc,(names,(ch,q,Q_ID (ch1,ch2)):chm))
---------------------------------------------------------------------------------
find_interact (names,(ch,Q_HPUT n q,Q_GET (s,t,e,(AMC_hcase coms):xs)):chs)  = 
                                    return ([(s,t,e,ci)],(names,(ch,q,Q_EMPTY):chs))
                                     where 
                                     ci = coms !! (n-1)
---------------------------------------------------------------------------------------
find_interact (names,(ch,Q_GET (s,t,e,(AMC_hcase coms):xs), Q_HPUT n q):chs)  =
                                    return ([(s,t,e,ci)],(names,(ch,Q_EMPTY,q):chs))
                                    where 
                                    ci =  get_from_list "interact!!" coms (n-1) 
---------------------------------------------------------------------------------------

find_interact (names,(ch,Q_PUT v q',Q_GET (s,t,e,c)):chs) 
                                   = return ([(v:s,t,e,c)],(names,(ch,q',Q_EMPTY):chs))
---------------------------------------------------------------------------------------
find_interact (names,(ch,Q_GET (s,t,e,c),Q_PUT v q'):chs) 
                                   = return ([(v:s,t,e,c)],(names,(ch,Q_EMPTY,q'):chs))
---------------------------------------------------------------------------------------
find_interact (names,(ch, Q_SPLIT (ch1,ch2), Q_FORK (t,e,((nam1,names1,c1),(nam2,names2,c2)))):chs)  = 
    return ([p1,p2],(names',chs))
    where
      p1 = ([],(nam1,IN,ch1):(restrict_trans t names1),e,c1)
      p2 = ([],(nam2,IN,ch2):(restrict_trans t names2),e,c2)
      names' = remove_gtrans ch names 
--------------------------------------------------------------------------------------------------
find_interact (names,(ch, Q_FORK (t,e,((nam1,names1,c1),(nam2,names2,c2))), Q_SPLIT (ch1,ch2)):chs) 
                                  = return ([p1,p2],(names',chs))
    where              
      p1 = ([],(nam1,OUT,ch1):(restrict_trans t names1),e,c1)
      p2 = ([],(nam2,OUT,ch2):(restrict_trans t names2),e,c2)
      names' = remove_gtrans ch names
-----------------------------------------------------------------------------
find_interact (names, (ch,Q_CLOSE,Q_HALT):chs)  = return ([],(remove_gtrans ch names,chs))
find_interact (names, (ch,Q_HALT ,Q_HALT):chs)  = return ([],(remove_gtrans ch names,chs))
find_interact (names, (ch,Q_CLOSE,Q_CLOSE):chs)  = return ([],(remove_gtrans ch names,chs))
find_interact (names, (ch,Q_HALT,Q_CLOSE):chs)  = return ([],(remove_gtrans ch names,chs))
find_interact (names,(xch@(ch,_,_)):chs) 
   | ch <= 0  = do     
             find_service (names,xch:chs) 

   | otherwise = do 
               (p,(names',chs')) <- find_interact (names,chs) 
               return (p,(names',xch:chs'))

filter_channels :: CHM -> [CH]
filter_channels chm = map (\(x,y) -> x) chlist
                where chlist = fst chm  



-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
---- Identifying channels
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


put_left q ch [] = FF
put_left q ch ((ch',Q_EMPTY,q'):chs) | ch == ch' = SS ((ch',q,q'):chs)
                                     | otherwise = case put_left q ch chs of
                                                     SS chs' -> SS ((ch',Q_EMPTY,q'):chs')
                                                     FF -> FF
put_left q ch (chn:chs) = case put_left q ch chs of 
                              SS chs' -> SS (chn:chs')
                              FF -> FF
put_right q ch [] = FF
put_right q ch ((ch',q',Q_EMPTY):chs) | ch == ch' = SS ((ch',q',q):chs)
                                     | otherwise = case put_right q ch chs of
                                                     SS chs' -> SS ((ch',q',Q_EMPTY):chs')
                                                     FF -> FF
put_right q ch (chn:chs) = case put_right q ch chs of 
                              SS chs' -> SS (chn:chs')
                              FF -> FF

add_channel (ch,q1,q2) [] = [(ch,q1,q2)]
add_channel (ch,q1,q2) chs@((ch',q1',q2'):chs')
               | ch > ch' = (ch,q1,q2):chs
               | otherwise = (ch',q1',q2'):(add_channel (ch,q1,q2) chs')

-----------------------------------------------------------------------------
--  SERVICES
-----------------------------------------------------------------------------

find_service :: CHM -> StateT CH_MAP IO MACH'
find_service (names,(n,Q_EMPTY,Q_HPUT 1 (Q_GET (s,t,e,c))):chs)  
    | n == 0 = do
        liftIO $ putStrLn ("Integer Console:")
        liftIO $ putStrLn "Enter the number" 
        num <- fmap (read::String -> Int) (liftIO getLine)
        return ([((V_INT num):s,t,e,c)],(names,(n,Q_EMPTY,Q_EMPTY):chs))
    | n == -100 = do
        liftIO $ putStrLn ("Character Console:")
        liftIO $ putStrLn "Enter the charcater" 
        char <- liftIO $ getChar
        return ([((V_CHAR char):s,t,e,c)],(names,(n,Q_EMPTY,Q_EMPTY):chs))

                         
---------------------------------------------------------------------------------
find_service (names,(n,Q_EMPTY,Q_HPUT 2 (Q_PUT m  q)):chs)  
   | n == 0 || n == -100  = do 
    case m of 
      V_INT m -> do    
        liftIO $ putStrLn ("Integer Console Put:")
        liftIO $ putStrLn (show m)
        return ([],(names ,(n,Q_EMPTY,q):chs))
      V_CHAR c -> do
        liftIO $ putStrLn ("Character Console Put:")
        liftIO $ putChar c 
        return ([],(names ,(n,Q_EMPTY,q):chs))

-------------------------------------------------------------------------------------
find_service (names,(n,Q_EMPTY,Q_HPUT 3 q):chs)  
    | n == 0 || n == -100 = do 
      liftIO $ putStrLn ("Console:")
      liftIO $ putStrLn ("Close")
      return ([],(names,(n,Q_CLOSE,q):chs))
-------------------------------------------------------------------------------------
find_service (names,(n,Q_HPUT 1 (Q_GET (s,t,e,c)),Q_EMPTY):chs)  = do
    liftIO $ hSetSGR stdout  [(SetConsoleIntensity BoldIntensity),(SetColor Foreground Vivid Blue)]
    mvar <- get 
    let mapping = M.lookup n mvar
    case mapping of
      Nothing ->
        error "No mapping for channel found!!!" 

      Just (port,sock,mayVal) -> do 
        case mayVal of --channel has never been used before 
          Nothing -> do 
            let 
              comm1   = "x-terminal-emulator -e "
              PortNumber port' 
                      = port 
              comm3   =  "nc  localhost " ++ show port'
              comm4   = "\"bash -c ' " ++ comm3 ++ " ' \""
              comm    = comm1 ++ comm4

            liftIO $ putStrLn $ "***************** Opening Channel ("++(show n)++
                                ") in a new terminal*******"
            liftIO $ runCommand  comm

            (handle, shost, sport) <- liftIO $ N.accept sock 

            let
              newMap  = (port,sock,Just handle)
              delmvar = M.delete n mvar
              newMVar = M.insert n newMap delmvar
              
            put newMVar
            liftIO $ printOnHandle handle n 
            val <- handle_GET n handle
            return ([(val:s,t,e,c)],(names,(n,Q_EMPTY,Q_EMPTY):chs))
                  
          Just handle -> do
            liftIO $ putStrLn $ "Enter a value on already opened" ++ (show n)
            val <- handle_GET n handle
            return ([(val:s,t,e,c)],(names,(n,Q_EMPTY,Q_EMPTY):chs))        

      

---------------------------------------------------------------------------------
find_service (names,(n,Q_HPUT 2 (Q_PUT m  q),Q_EMPTY):chs)   = do 
    liftIO $ hSetSGR stdout  [(SetConsoleIntensity BoldIntensity),(SetColor Foreground Vivid Blue)]
    mvar <- get 
    let mapping = M.lookup n mvar
    case mapping of
      Nothing ->
        error "No mapping for channel found!!!"  

      Just (port,socket,mayVal) -> do 
        case mayVal of --channel has never been used before 
          Nothing -> do
                         
            let 
              comm1  = "x-terminal-emulator -e "
              PortNumber port' 
                     = port 
              comm3  =  "nc  localhost " ++ show port'
              comm4  = "\"bash -c ' " ++ comm3 ++ " ' \""
              comm   = comm1 ++ comm4


            liftIO $ putStrLn $ "***************** Opening Channel ("++(show n)
                                ++ ") in a new terminal*******"                

            liftIO $ runCommand  comm
            (handle, shost, sport) <- liftIO $ N.accept socket 

            let
              newMap = (port,socket,Just handle)
              delmvar= M.delete n mvar
              newMVar= M.insert n newMap delmvar

            put newMVar
            liftIO $ printOnHandle handle n
            handle_PUT n m handle

          Just handle -> do
            handle_PUT n m handle
        return ([],(names ,(n,q,Q_EMPTY):chs))
                 
-------------------------------------------------------------------------------------
find_service (names,(n,Q_HPUT 3 q, Q_EMPTY):chs)  = do
    liftIO $ putStrLn ("Closing Channel "++(show n))
    liftIO $ putStrLn "*******************************************************"
    mvar <- get 
    let 
      mapping  = M.lookup n mvar
      delmvar  = M.delete n mvar
    case mapping of 
         Just (port,socket,mayHand) -> do
           case mayHand of 
              Just handle -> do 
                 liftIO $ threadDelay 100000
                 liftIO $ hClose handle
                 put delmvar
                 return ([],(names,(n,q,Q_HALT):chs))

              Nothing -> 
                 return ([],(names,(n,q,Q_HALT):chs))
           
         Nothing -> error "Error closing channel"                                     
   

-------------------------------------------------------------------------------------                            

find_service (names,xch:chs)  = do 
                    (p,(names',chs')) <- find_interact (names,chs) 
                    return (p,(names',xch:chs'))

                           
---------------------------------------------------------------------------------



-- Concurrent machine ..
---------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- helper function for  process case AMC_PLUG 
plug_chs [] chm = ([],[],chm)
plug_chs (n:ns) chm = ((n,OUT,n'):ins',(n,IN,n'):outs',chm'')
    where (ins',outs',chm') = plug_chs ns chm
          (n',chm'') = plug_ch chm'

plug_ch:: CHM -> (Int,CHM)     
plug_ch (names,chs) = (ch',(names',chs')) 
     where
         (ch',names') = newname names
         chs' = add_channel (ch',Q_EMPTY,Q_EMPTY) chs 

----------------------------------------------------------------------------

process_step:: PROCESS -> StateT (CHM,DEFNS) Identity MACH'
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--    Given a single process this describes how it modifies  
--    the channel manager and what process(es) it produces 
---------------------------------------------------------------------------------
process_step (v:s,t,e,(AMC_PUT n):cs) = do
                 ((names,chs),defs) <- get 
                 let (ch,pol) = lookup_local2physical n t names
                     chs'     = put_ch ch pol v (names,chs)
                 return ([(s,t,e,cs)], chs')
---------------------------------------------------------------
process_step (s,t,e,(AMC_GET n):cs) = do
                ((names,chs),defs) <- get
                let (ch,pol) = lookup_local2physical n t names
                    chs' = get_ch ch pol (s,t,e,cs) (names,chs)
                return ([],chs')
-----------------------------------------------------------------
process_step (s,t,e,(AMC_HPUT n cn):cs) = do
               ((names,chs),defs) <- get
               let (ch,pol) = lookup_local2physical n t names
                   chs'     = hput_ch ch pol cn (names,chs) 
               return ([(s,t,e,cs)],chs')
---------------------------------------------------------------------------
process_step (s,t,e,(AMC_HCASE n lc):cs) = do 
               ((names,chs),defs) <- get
               let (ch,pol) = lookup_local2physical n t names
                   chs'     = enqueue ch pol (Q_GET (s,t,e,[AMC_hcase lc])) chs
               return ([],(names,chs'))
---------------------------------------------------------------------------
process_step (s,t,e,(AMC_SPLIT n (n1,n2)):cs) = do
               ((names,chs),defs) <- get
               let (ch,pol) = lookup_local2physical n t names
                   ((ch1,ch2),chs') = split_ch ch pol (names,chs)
                   t' = (n1,pol,ch1):(n2,pol,ch2):(remove_trans n t)
               return ([(s,t',e,cs)],chs')
-------------------------------------------------------------------------------
process_step (s,t,e,(AMC_FORK n fork_instr):_)  = do
               ((names,chs),defs) <- get
               let (ch,pol) = lookup_local2physical n t names
                   chs' = enqueue ch pol (Q_FORK (t,e,fork_instr)) chs 
               return ([],(names,chs'))     
-----------------------------------------------------------------------------
process_step (s,t,e,(AMC_CLOSE n):cs) = do 
              ((names,chs),defs) <- get
              let (ch,pol) = lookup_local2physical n t names
                  chs'     = enqueue ch pol Q_CLOSE chs
              return ([(s,t,e,cs)],(names,chs'))      
----------------------------------------------------------------------------
process_step (_,t,e, [(AMC_HALT ns)]) = do 
              ((names,chs),defs) <- get
              let cpols = map (\n -> lookup_local2physical n t names) ns
                  chs' = enqueues cpols Q_HALT chs
              return ([],(names,chs'))     
---------------------------------------------------------------------------

process_step (s,t,e,[AMC_PLUG chs (chs1,c1) (chs2,c2)]) = do 
              (chm,defs) <- get
              let   (outchs,inchs,chm') = plug_chs chs chm
                    t1 = outchs ++(restrict_trans t chs1)
                    t2 = inchs ++ (restrict_trans t chs2) 
              return ([(s,t1,e,c1),(s,t2,e,c2)],chm')  
----------------------------------------------------------------------------
process_step (s,t,e,(AMC_RUN t' pn m):c') = do
           (chm,defs) <- get
           let e' = take m s
               s' = drop m s 
               c = lookup_defn pn defs
               t'' = compose_trans t' t
           return ([([],t'',e',c)], chm)      

-------------------------------------------------------------                          
process_step (s,t,e,[(AMC_ID st1 st2)]) = do 
           ((names,chs),defs) <- get
           let (ch,pol) = lookup_local2physical st2 t names
               (ch',pol') = lookup_local2physical st1 t names
               chs' | ch < 0 && ch' <0 = error "Error: services cannot be identified!"
                    | ch <= ch' = enqueue ch' pol' (Q_ID (ch',ch)) chs
                    | otherwise = enqueue ch pol (Q_ID (ch,ch')) chs
           return ([],(names,chs'))
-------------------------------------------------------------    
process_step (V_CLO(c',e'):s,t,e,[AMC_PRET]) = do 
         (chm,defs) <- get   
         return ([(s,t,e',c')],chm)
-------------------------------------------------------------    
process_step (s,t,e,c)  = do
        (chm,defs) <- get
        let Identity ((c',e',s'),_) = runStateT (seq_step (c,e,s)) defs 
        return ([(s',t,e',c')],chm)


-- Executing the machine until the final state is reached

eval n ([],e,s) defs = (n, (s,e))
eval n s defs = eval (n+1) triple defs
                  where 
                    Identity (triple,_) = runStateT (seq_step s) defs

type SEQAMPL = (AMPLCOMS,ENV,STACK)

---------------------------------------------------------------------------------
--
--  Sequential machine steps
--
---------------------------------------------------------------------------------
seq_step:: SEQAMPL -> StateT DEFNS Identity SEQAMPL
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
seq_step trip@((AMC_LOAD n ):c,e,s) = return (c,e,x:s)
                         where
                          s1 = show ((AMC_LOAD n):c) ++ "\n"++
                               show e ++ "\n" ++ show s  
                          x = case get_from_list ("Access!!\n" ++ s1) e (n-1) of
                                     V_CLO(c,e) ->  error $  "Closure < " ++ (show (V_CLO(c,e))) ++ " > taken from  environment!!"
                                     y -> y
------------------------------------------------------------------------------
seq_step ((AMC_STORE ):c,e,v:s) = case v of 
                                      V_CLO(c,e) -> error $  "Closure < "
                                                              ++(show (V_CLO(c,e)))++" > put in environment!!"
                                      v ->  return (c,v:e,s) --- storing a value on the stack
------------------------------------------------------------------------------
seq_step ((AMC_CALL fn n):c',e,s) = do 
                           defs <- get 
                           let c = lookup_defn fn defs
                           return (c,args,V_CLO (c',e):s')
                  where 
                    args = take n s
                    s' = drop n s
            
------------------------------------------------------------------------------
seq_step ([AMC_RET],e,v:V_CLO(c',e'):s) = return (c',e',v:s)
------------------------------------------------------------------------------
seq_step ((AMC_CONS i n ):c,e,s) 
                  | n <= length s = return (c,e,V_CONS(i,sl):s')
                  | otherwise     = error $ "Inappropriate stack state"
                   where sl = take n s 
                         s' = drop n s                          
------------------------------------------------------------------------------
seq_step ((AMC_CASE cs):c,e,V_CONS(i,sl):s) = return (ci,sl ++ e,V_CLO(c,e):s)
                          where 
                            ci = get_from_list "Case!" cs (i-1) 
------------------------------------------------------------------------------
seq_step ((AMC_REC cl):c,e,s )  = return (c,e,(V_REC(cl,e)):s) 
------------------------------------------------------------------------------
seq_step (code@((AMC_DEST i n ):c),e,s)  
                  | n+1 <= length s = return (ci,sl ++ e',V_CLO (c,e):s')
                  | otherwise       = error $ "Inappropriate stack state"
                   where sl = take n s 
                         (s',e',ci) = case drop n s of 
                                  (V_REC(cs,e'):s') -> (s',e',get_from_list "Record!" cs (i-1) )
                                  sthg -> error $ "Expected a record !!" ++ show sthg ++ "" ++
                                                   show code ++ "\n" ++ show e ++ "\n" ++ show s
                                                                                   
------------------------------------------------------------------------------
seq_step ((AMC_PROD n):c,e,s) = case n <= length s of
                 True  -> do
                            let 
                              vals = take n s 
                              s'   = drop n s 
                            return (c,e,(V_PROD vals):s')   
                 False ->  error  "Inappropriate stack state\n" 

------------------------------------------------------------------------------
seq_step ((AMC_PRODELEM n):c,e,(V_PROD vals): s) 
             = case n <= length vals of 
                  True ->
                     return (c,e,(vals !!(n-1)):s)
                  False ->  
                     error $ equals ++ "Trying to access element < " ++ show n ++
                             " > in a tuple of < " ++ show (length vals) ++ " > elements." ++ equals     
------------------------------------------------------------------------------
seq_step ((AMC_INT k):c,e,s)       = return (c,e,(V_INT k): s)
------------------------------------------------------------------------------
seq_step ((AMC_CHAR chr):c,e,s)    = return (c,e,(V_CHAR chr): s)
------------------------------------------------------------------------------
seq_step ((AMC_STRING str):c,e,s)  = return (c,e,(V_STRING str): s)
------------------------------------------------------------------------------
seq_step ((AMC_CONCAT):c,e,V_STRING str1:V_STRING str2:s) = return (c,e,V_STRING (str2 ++ str1): s)
------------------------------------------------------------------------------
seq_step ((AMC_CONCATf n):c,e,s)  = return (c,e,V_STRING str' :s')
           where conc_strs   = reverse $ take n s 
                 s'          = drop n s 
                 str'        = (concat.map remove_string_cons) conc_strs 
                 remove_string_cons :: VAL -> String
                 remove_string_cons (V_STRING str) = str 
------------------------------------------------------------------------------
seq_step (AMC_UNSTRING:c,e,(V_STRING list):s)  =
                      return (c,e,(unstring_Help list):s)
-----------------------------------------------------------------------------
seq_step (AMC_APPEND:c,e,list1:list2:s)  =
                      return (c,e,(append_Help list1 list2):s)
------------------------------------------------------------------------------
seq_step (AMC_DIVQ:c,e,V_INT n:V_INT m:s)  = return (c,e,V_INT (quot m n):s)
------------------------------------------------------------------------------
seq_step (AMC_DIVR:c,e,V_INT n:V_INT m:s)  = return (c,e,V_INT (m `mod` n):s)
------------------------------------------------------------------------------
seq_step (AMC_ADD:c,e,V_INT n:V_INT m:s)   = return (c,e,V_INT (m + n):s)
------------------------------------------------------------------------------
seq_step (AMC_SUB:c,e,V_INT n:V_INT m:s)   = return (c,e,V_INT (m - n):s)
------------------------------------------------------------------------------
seq_step (AMC_MUL:c,e,V_INT n:V_INT m:s)   = return (c,e,V_INT (m * n):s)
------------------------------------------------------------------------------
seq_step (AMC_TOSTR:c,e,val:s)  =
          case val of 
            V_CHAR char ->
              return (c,e,(V_STRING [char]):s)  
            V_INT  int  ->    
              return (c,e,(V_STRING (show int)):s)
-----------------------------------------------------------------------------
seq_step (AMC_TOINT:c,e,val:s)  =
          case val of 
            V_CHAR char ->
              case elem char "1234567890" of 
                True -> 
                   return (c,e,(V_INT (read [char]::Int)):s)  
                False ->
                   error $ stars ++ "Can't convert <<" ++ char:[] 
                           ++ ">> to integer" ++ stars
            V_STRING v  ->    
              return (c,e,(V_INT(read v::Int)):s)
-----------------------------------------------------------------------------

seq_step (AMC_LEQ:c,e,V_INT n:V_INT m:s) 
                         | m <= n     = return (c,e,V_CONS(2,[]):s)
                         | otherwise = return (c,e,V_CONS(1,[]):s)
------------------------------------------------------------------------------
seq_step (AMC_EQ:c,e,V_INT n:V_INT m:s) 
                            | n == m    = return (c,e,V_CONS(2,[]):s)
                            | otherwise = return (c,e,V_CONS(1,[]):s)
                
------------------------------------------------------------------------------
seq_step (AMC_EQC:c,e,V_CHAR n:V_CHAR m:s)  
                       | n == m    = return (c,e,V_CONS(2,[]):s)
                       | otherwise = return (c,e,V_CONS(1,[]):s)
------------------------------------------------------------------------------
seq_step (AMC_LEQC:c,e,V_CHAR n:V_CHAR m:s) 
                       | n <= m    = return (c,e,V_CONS(2,[]):s)
                       | otherwise = return (c,e,V_CONS(1,[]):s)
------------------------------------------------------------------------------
seq_step (AMC_EQS:c,e,V_STRING str1:V_STRING str2:s) 
                       | str1 == str2 = return (c,e,V_CONS(2,[]):s)
                       | otherwise    = return (c,e,V_CONS(1,[]):s)
------------------------------------------------------------------------------
seq_step (AMC_LEQS:c,e,V_STRING str1:V_STRING str2:s)
                       | str1 <= str2 = return (c,e,V_CONS(2,[]):s)
                       | otherwise    = return (c,e,V_CONS(1,[]):s)
------------------------------------------------------------------------------
seq_step ms  = return ms --error ("no sequential step from"++(show ms))


unstring_Help :: String -> VAL 
unstring_Help []
  = V_CONS(1,[])
unstring_Help (x:xs) 
  = V_CONS(2,(V_CHAR x):[unstring_Help xs])
 
check_str_validity :: String -> Int 
check_str_validity list 
    = case boolCond of 
        True  -> (read list::Int)
        False -> error $ equals ++ "Can't convert <<"  ++ show list ++
                         ">> to integer" ++ equals  
  where
    boolCond   = (and.map (\x -> elem x validElems)) list 
    validElems = ['0'..'9']
  

string_help :: VAL -> VAL 
string_help val 
    = stringify val ""
        where
          stringify :: VAL -> String -> VAL 
          stringify (V_CONS (1,[])) str
             = V_INT (check_str_validity (reverse str)) 
          stringify (V_CONS (2,(V_CHAR x):ivals)) str 
             = stringify (head ivals) (x:str)


append_Help :: VAL -> VAL -> VAL 
append_Help (V_STRING str1) (V_STRING str2)
    = V_STRING (str1 ++ str2)
append_Help list1 list2
    = case list1 of 
        V_CONS (1,[]) -> 
          list2
        V_CONS (2,e:v:[]) -> 
          V_CONS (2,e:(append_Help v list2):[])




star   = "************************************************************************\n\n"
equals = "\n========================================================================\n"
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
globalError :: (String,NamePnPair) -> ErrorMsg
globalError (fp,(fname,posn)) =
    case fp of
        "fun"       -> equals ++ "Error: Inside function < " ++ 
                       fname ++ " > defined at " ++ genLnNoErrorspcl posn  
        "proc"      -> equals ++ "Error: Inside process < " ++
                       fname ++ " > defined at " ++ genLnNoErrorspcl posn 
        "main_run"  -> equals ++ "Error:Inside main process "
                        ++ genLnNoErrorspcl posn  

genLnNoErrorspcl :: PosnPair -> ErrorMsg
genLnNoErrorspcl (line,col) = "(Line " ++ show line  
                           ++ ",Col " ++ show col ++ ")\n"