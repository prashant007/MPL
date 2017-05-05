module MPLPar.PtreeToAST_help where 

import MPLPar.AbsMPL
import qualified TypeInfer.MPL_AST as M 
import qualified TypeInfer.Gen_Eqns_CommFuns as E 

import Control.Monad.State.Lazy
import qualified Data.Set as S 
import Data.List


data Chan =  NormChan  M.PChannel
           | SplitChan M.PChannel (M.PChannel,M.PChannel) 
           deriving (Eq,Show)

compile_Plug :: [M.Process] ->[M.ProcessCommand] -> 
                M.ProcessCommand
compile_Plug (p1:ps) pcs 
    = case pcs of 
        [] -> 
            case (not.null.tail) ps of 
              True   -> 
                compile_Plug (tail ps) [cpf] 
              False  -> 
                cpf 
          where
               p2   = head ps 
               chs1 = get_Channels p1 
               chs2 = get_Channels p2 
               pchs = intersect chs1 chs2 
               pchs1= chs1 \\ pchs 
               pchs2= chs2 \\ pchs 
               cpf  = M.PPlug 
                        (
                         pchs,((pchs1,p1),(pchs2,p2)),
                         E.getProcPosn (head pcs)
                        )  

        [pc] -> 
           case ps of
             [] -> cpf             
             _  -> compile_Plug ps [cpf] 
         where        
          -- total channels of the first process
          chs_fp    = get_Channels p1  
          M.PPlug (c0,((c1,coms1),(c2,coms2)),_) = pc 
          -- total chs from already compiles processes
          chs_alcp  = c1 ++ c2 
          chs_plug  = intersect chs_alcp chs_fp 
          chs1      = chs_alcp \\  chs_plug
          chs2      = chs_fp \\ chs_plug
          cpf       = M.PPlug
                         (
                          chs_plug,
                          ((chs1,pcs),(chs2,p1)),
                          E.getProcPosn (head pcs)
                         )                          
             

get_Channels :: M.Process -> [M.PChannel]
get_Channels ppart  = collect_chns ppart 


collect_chns :: M.Process ->[M.PChannel]
collect_chns ps = chanSToChannelS ls []
    where
       ls = collect_chns_helper ps [] 

chanSToChannelS :: [Chan] -> [M.PChannel] -> [M.PChannel]
chanSToChannelS []     l = nub l 
chanSToChannelS (c:cs) l = 
    case c of 
      NormChan cname -> 
         chanSToChannelS cs (cname:l)

      SplitChan cname (c1,c2) -> 
         chanSToChannelS cs l' 
       where
         l' = (cname:l) \\ [c1,c2]

collect_chns_helper :: M.Process -> [Chan] -> [Chan] 
collect_chns_helper []  chan      = chan  
collect_chns_helper (p:ps) cp     = case p of
  ----------------------------------------------------
   M.PRun (pname,terms,chsin,chsout,_) -> 
         collect_chns_helper ps coll_chns
      where
        coll_chns = map (\x -> NormChan x) (chsin++chsout)        

   ----------------------------------------------------
   M.PClose (ch,_)  -> 
         collect_chns_helper ps updated_ch_list 
      where
        updated_ch_list = collect_chns_Comm cp ch  
   ----------------------------------------------------     
   M.PHalt (chs,_)  -> 
        collect_chns_helper ps updated_ch_list
      where 
        updated_ch_list = collect_chns_PHalt cp [chs] 
         
  ------------------------------------------------------ 
   M.PGet (_,ch,_)   -> 
      collect_chns_helper ps updated_ch_list
    where 
      updated_ch_list = collect_chns_Comm cp ch
         
  ------------------------------------------------------
   M.PPut (_,ch,_)   -> 
      collect_chns_helper ps updated_ch_list
    where 
      updated_ch_list = collect_chns_Comm cp ch
         
  ------------------------------------------------------ 
   M.PHPut (_,ch,_)   -> 
      collect_chns_helper ps updated_ch_list
    where 
      updated_ch_list = collect_chns_Comm cp ch
       
  ------------------------------------------------------ 
   M.PHCase (_,tList,_)   -> 
      collect_chns_helper ps updated_ch_list
    where 
      procI = concat $ map (\(a,b,c) -> b) tList
      chs   = collect_chns procI 
      updated_ch_list 
            = collect_chan_comms cp chs 
       
  ------------------------------------------------------ 
   M.PCase(_,pattprocs,_) -> 
      collect_chns_helper ps updated_ch_list
    where 
      procI = concat $ map (\(a,b) -> b) pattprocs
      chs   = collect_chns procI 
      updated_ch_list 
            = collect_chan_comms cp chs   
  ------------------------------------------------------
   M.PSplit (ch,(ch1,ch2),_) -> 
        collect_chns_helper ps ((SplitChan ch (ch1,ch2)):cp)         
  ------------------------------------------------------
   M.PFork (ch,(_,ch1,_):(_,ch2,_):[],_) ->  
        collect_chns_helper ps ((NormChan ch):(coll_chns ++ cp))
      where
        coll_chns = map (\x -> NormChan x) (ch1++ch2)    

  ------------------------------------------------------     
   M.PPlug (_,((chs1,_),(chs2,_)),_) -> 
        collect_chns_helper ps coll_chns
      where
        coll_chns = collect_chns_PPlug cp (chs1++chs2)
  ------------------------------------------------------
   M.PId (ch1,ch2,_) -> 
        collect_chns_helper ps coll_chns
      where
        coll_chns = collect_chns_PEqual cp (ch1,extChan ch2)
  ------------------------------------------------------
   M.PNeg (ch1,ch2,_)  ->
        collect_chns_helper ps coll_chns
      where
        coll_chns = collect_chns_PEqual cp (ch1,ch2)



extChan :: M.Channel -> M.PChannel 
extChan chan 
    = case chan of 
         M.PosChan ch -> ch 
         M.NegChan ch -> ch 

-- ===========================================================
-- ===========================================================

collect_chns_PFork :: [Chan] -> [M.PChannel] -> [Chan]
collect_chns_PFork chans chs 
      = nchs ++ chans
  where 
    rem_chs = filter (not.is_res_of_split chans) chs
    nchs    = map  NormChan rem_chs    

collect_chns_PHalt :: [Chan] -> [M.PChannel] -> [Chan]
collect_chns_PHalt chans chs = 
      case bool1 of 
        True  -> chans 
        False -> new_tot_chns
  where 
  bool1 = (and.map (\x -> is_res_of_split chans x)) chs 
  new_tot_chns 
        = map (\c -> NormChan c) chs ++ chans 


collect_chns_PEqual :: [Chan] -> (M.PChannel,M.PChannel) -> [Chan]
collect_chns_PEqual chans (ch1,ch2) 
    = case bool1 of 
        True  ->
            case bool2 of 
              True  -> chans  
              False -> (NormChan ch2): chans      

        False ->
          case bool2 of
            True  -> (NormChan ch1):chans 
            False -> (NormChan ch1):(NormChan ch2):chans 
  where 
    bool1 = is_res_of_split chans ch1 
    bool2 = is_res_of_split chans ch2    


collect_chns_PPlug :: [Chan] -> [M.PChannel] -> [Chan]
collect_chns_PPlug chans chs 
      = nchs ++ chans
  where 
    rem_chs = filter (not.is_res_of_split chans) chs
    nchs    = map  NormChan rem_chs    



collect_chan_comms :: [Chan] -> [M.PChannel] -> [Chan]
collect_chan_comms = collect_chns_PPlug

collect_chns_Comm :: [Chan] -> M.PChannel -> [Chan]
collect_chns_Comm chs ch = case is_res_of_split chs ch of
           True  -> chs 
           False -> (NormChan ch):chs  


-- this function tells that the Channel to be closed is
-- the result of a split or not,True if it is 
is_res_of_split :: [Chan] -> M.PChannel -> Bool
is_res_of_split [] _ 
    = False  
is_res_of_split (x:xs) ch 
    = case x of
        NormChan _  -> 
            is_res_of_split xs ch 
        SplitChan _ (sch1,sch2) -> 
            ch == sch1 || ch == sch2

-- =================================================
-- ================================================= 

getChs_proc :: M.Process -> [M.PChannel]
getChs_proc pcomms = totchs \\ remChs
    where
       pairList = map getChfromComm pcomms
       totchs   = (nub.concat.map fst) pairList
       remChs   = (nub.concat.map snd) pairList


getChfromComm :: M.ProcessCommand -> ([M.PChannel],[M.PChannel])
getChfromComm pcomm 
    = case pcomm of 
          M.PRun   (_,_,ichs,ochs,_) -> 
              (ichs ++ ochs,[])
 
          M.PClose (ch,_) ->
              ([ch],[]) 

          M.PHalt  (ch,_) ->
              ([ch],[])

          M.PGet   (_,ch,_) ->
              ([ch],[])

          M.PPut   (_,ch,_) ->
              ([ch],[])

          M.PHPut  (_,ch,_) ->
              ([ch],[])

          M.PHCase (ch,tripList,_) ->
              (ch:lchs,delChs)
            where
              allPcomms = concat $ map (\(p,q,r) -> q) tripList
              pairList  = map getChfromComm allPcomms
              lchs      = concat $ map fst pairList         
              delChs    = concat $ map snd pairList

          M.PSplit (och,(sch1,sch2),_) ->
              ([och],[sch1,sch2])           
                
          M.PFork  (ch,tripList,_) ->
              (ch:allChs,[])
            where 
                allChs = (concat.map (\(a,b,c) -> b)) tripList 


          M.PPlug  (plugChs,((chs1,proc1),(chs2,proc2)),_) ->
              (
                chs1 ++ chs2,
                plugChs
              )
            {-  
            where 
                pairList1 = map getChfromComm proc1 
                pairList2 = map getChfromComm proc2 
                chs1      = concat $ map fst pairList1
                dchs1     = concat $ map snd pairList1
                chs2      = concat $ map fst pairList2
                dchs2     = concat $ map snd pairList2 
            -}

          M.PId    (ch1,ch2,_) -> 
              ([ch1,extractChan ch2],[])

          M.PNeg (ch1,ch2,pn) ->
              ([ch1,ch2],[])

          M.PCase  (_,pattPList,_) ->
              (chs,dchs)
            where
                 allPcomms= concat $ map snd pattPList
                 pairList = map getChfromComm allPcomms
                 chs      = concat $ map fst pairList
                 dchs     = concat $ map snd pairList  



convertToPlug :: [M.Process] -> M.PosnPair -> 
                 Either M.ErrorMsg M.ProcessCommand
convertToPlug procs posn 
    = case length procs == 1 of 
          True -> 
              Left $ 
                "Plug at least needs two processes. " ++
                "Incorrectly being called with one" ++
                E.printPosn posn 
          False -> do 
              let 
                (p1:p2:rest)
                    = procs 
                [chs1,chs2]
                    = map getChs_proc [p1,p2]
                (commChs,remChs)
                    = getCommonChs (chs1,chs2)
                remChs1
                    = chs1 \\ commChs
                remChs2
                    = chs2 \\ commChs
                plugComm 
                    = M.PPlug (commChs,((remChs1,p1),(remChs2,p2)),posn) 

              case rest == [] of 
                  True  -> 
                    return plugComm
                  False -> do 
                    convertToPlug ([plugComm]:rest) posn


{-
convertToPlug_Help :: [M.Process] -> (M.ProcessCommand,[M.PChannel]) ->
                      M.ProcessCommand
convertToPlug_Help [] (finalPlug,_) 
        = finalPlug
convertToPlug_Help (p:ps) (plugComm,accChs)
        = convertToPlug_Help ps (newPlugComm,remChs)
   where
     pchs  = getChs_proc p 
     pPosn = E.getProcPosn (head p) 
     (commChs,remChs)
          = getCommonChs (pchs,accChs)
     newPlugComm
          = M.PPlug (commChs,([plugComm],p),pPosn)
-}

-- output is the common channels from the input and the rest
getCommonChs :: ([M.PChannel],[M.PChannel]) -> 
                ([M.PChannel],[M.PChannel])
getCommonChs (chs1,chs2) 
        = (
           S.toList commChans,
           S.toList remChs
          )
    where
       s1 = S.fromList chs1 
       s2 = S.fromList chs2 
       commChans
          = S.intersection s1 s2 
       unionchs
          = S.union s1 s2 
       remChs
          = S.difference unionchs commChans 



extractChan :: M.Channel -> M.PChannel        
extractChan chan 
    = case chan of 
          M.PosChan p  -> p
          M.NegChan np -> np 

