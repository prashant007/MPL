module MPLToCMPLConverter where 
import qualified TypesCoreMPL as C
import qualified TypeInfer.MPL_AST as M 

type PairList = [(C.Name,C.Name)]

getFTypePn :: M.FunType -> C.PosnPair 
getFTypePn fType 
    = case fType of 
        M.NoType ->
          (0,0)
        M.StrFType (_,sType) -> 
          getTypePosn sType 
        IntFType (_,itype) ->
          getTypePosn iType  

convProt :: M.Defn -> [(C.Name,C.Name)]
convProt defn 
    = case defn of 
        ProtocolDefn (pcls,pn) -> 
          undefined 
        CoprotocolDefn (pcls,pn) -> 
          undefined 

-- (ProtName,[ProtocolPhrase])
handlePcls :: [M.ProtocolClause] -> [(C.Name,C.Name)]
handlePcls pcls 
      =
  where 
      tPcls = map transPcl pcls 


transPcl :: M.ProtocolClause -> C.ProtocolClause
transPcl (pName,pPhrs) = (pnm,map () pPhrs)
    where 
      M.DataName (pnm,_) 
          = pName  


  
convData :: M.Defn -> [(C.Name,C.Name)]
convData (Data  (dcls,pn))
        = handleDecls dcls 

convData (Codata(dcls,pn))
        = handleDecls dcls 

-- (NamePnPair,[NamePnPair])

handleDecls :: [M.DataClause] -> [(C.Name,C.Name)]
handleDecls dcls
    = concat $ map (\((n,p),cs) -> map (\c -> ((fst.fst)c, n)) cs) tDcls 
  where 
      tDcls = map transDcl dcls 

transDcl :: M.DataClause -> C.DataClause
transDcl (dnm,dphrs)
        = ((dnm,dpn),conses)
    where 
       M.DataName (nm,_) 
           = dnm
       conses
           = map transDPhr dphrs 
       dpn = (snd.fst.head) nDphrs  

transDPhr :: M.DataPhrase -> C.Constructor 
transDPhr (nm,fType,num) 
        = ((nm,fPn),(num,fPn))
    where 
      fPn = getFTypePn fType 

-- ===============================================
-- ===============================================

convStmt :: M.Stmt -> [C.Defn] 
convStmt stmt 
    = case stmt of 
        M.DefnStmt (defns,stmts,pn) ->
          map convStmt stmts ++ 
          map convDefn defns 

        M.RunStmt (fType,ichs,ochs,pcoms,pn) -> 
            [C.MainRun (pn,ichsN,ochsN,pcomsN)]
          where 
            ichsN  = map (\n -> (n,pn)) ichs 
            ochsN  = map (\n -> (n,pn)) ochs 
            pcomsN = map convPCom pcoms  

-- ===============================================
-- ===============================================

convDefn :: M.Defn -> State (PairList,PairList) C.Defn 
convDefn defn
    = case defn of 
        M.Data(dcls,pn) -> do 
            let 
              tDcls = map transDcl dcls
            return $ C.Data (pn,tDcls)

        M.Codata(dcls,pn) -> do 
            let 
              tDcls = map transDcl dcls
            return $ C.Codata (pn,tDcls)

        M.TypeSyn (tsyms,pn) -> 
            undefined 

        M.ProtocolDefn (pcls,pn) -> do 
            let 
              tPcls = map transPcl pcls
            return $ C.Protocol (pn,tPcls)

        M.CoprotocolDefn (pcls,pn) -> do 
            let 
              tPcls = map transPcl pcls
            return $ C.Coprotocol (pn,tPcls)

        M.FunctionDefn (fnm,fType,pattTerms,pn) -> do 
            let 
              ((patts,eithTerm),_) 
                   = head pattTerms
              args = map pattToArgs patts 
              Left term 
                   = eithTerm              
            return $ C.Function (pn,transName pn fnm,args,term)
           

        M.ProcessDefn  (nm,_,pattProc,pn) ->
            C.Process (pn,(nm,pn),args,ichsN,ochsN,convProc proc)
          where 
            args  = map pattToArgs patts 
            (patts,inchs,ochs,proc) 
                  = pattProc
            args  = map pattToArgs patts 
            ichsN = map (\p -> (p,pn)) inchs 
            ochsN = map (\p -> (p,pn)) ochs      

        M.TermSyn termSyn ->
          undefined 

        M.OperatorDefn (str,eith,pn) ->    
          undefined       

-- ===============================================
-- ===============================================

transName :: M.PosnPair -> M.FuncName -> C.FuncName
transName pn fname 
    = case fname of 
        M.Custom nm   -> 
            C.Custom (nm,pn)

        M.BuiltIn fn  -> 
            case fn of 
              M.Add_I -> 
                C.Add_I

              M.Sub_I -> 
                C.Sub_I

              M.Mul_I ->
                C.Mul_I

              M.DivQ_I ->
                C.DivQ_I

              M.DivR_I ->
                C.DivR_I

              M.Eq_I   ->
                C.Eq_I

              M.Neq_I  ->
                undefined

              M.Leq_I  ->
                C.Leq_I

              M.Geq_I  -> 
                undefined 

              M.LT_I   ->
                undefined  

              M.GT_I   ->
                undefined 

              M.Eq_C   ->
                C.Eq_C

              M.Eq_S   ->
                C.Eq_S

              M.Concat_S -> 
                C.Concat_S 2 

              M.Unstring_S ->
                C.Unstring_S

              M.HeadString_S ->
                C.HeadString_S

              M.TailString_S ->
                C.TailString_S 

              M.Or_B  ->
                undefined 

              M.And_B ->   
                undefined            


pattToArgs :: M.Pattern -> C.Argument 
pattToArgs (M.VarPattern vpn) = vpn 

-- ===================================================================
-- ===================================================================

convPCom :: M.ProcessCommand -> 
            State (PairList,PairList) C.ProcessCommand
convPCom pcom 
    = case pcom of 
       M.PRun(nm,terms,ichs,ochs,pn) -> do 
          (ichsN,ochsN,pcomsN) <- genChPComTrip (ichs,ochs,[],pn)
          cTerms <- mapM convTerm terms  
          return $ C.PRun (pn,(nm,pn),cTerms,ichsN,ochsN)
                  
       M.PClose (ch,pn) -> 
          return $ C.PClose (pn,(ch,pn))

       M.PHalt  (ch,pn) ->
          return $ C.PHalt (pn,[(ch,pn)])

       M.PGet   (patt,ch,pn) ->
          return $ C.PGet (pn,pattToArgs patt,(ch,pn)) 

       M.PPut   (term,ch,pn) -> 
          return $ C.PPut (pn,convTerm term,(ch,pn))

       M.PHPut  (nm,ch,pn) -> do 
            (dcdlist,pcplist) <- get
            case lookup nm pcplist of 
              Just prot -> do 
                let 
                  handle = ((prot,pn),(nm,pn))
                return $ C.PHPut (pn,handle,(ch,pn))

              Nothing -> do 
                let 
                  emsg 
                    = "No Protocol/Coprotocol found for handle/cohandle <<" 
                       ++ nm ++ ">>" ++ Comm.printPosn pn 
                error emsg 

       M.PHCase (ch,trips,pn) -> do 
           cTrips <- mapM handleProcTrip trips 
           return $ C.PHcase (pn,(ch,pn),cTrips)  

       M.PSplit (ch,(ch1,ch2),pn) -> do 
          return $ 
             C.PSplit (pn,(ch,pn),map (\c -> (c,pn)) [ch1,ch2])

       M.PFork  (str,trips,pn) -> do 
          cTrips <- mapM handleForkTrip trips 
          return $ C.PFork (pn,(str,pn),cTrips)      

       M.PPlug  (chs,(p1,p2),pn) -> do 
          let 
            chsN = map (\c -> (c,pn)) chs
          p1N <- mapM convPCom p1 
          p2N <- mapM convPCom p2 
          return $ C.PPlug (chsN,(p1N,p2N),pn)

       PId(pch,ch,pn) ->  
          return $ PEqual (pn,pch,extractChan ch pn)    

       PCase (term,pattProcs,pn) -> do 
           pattPsN <- map handlePattProc pattProcs 
           termN   <- convTerm term 

       PNeg(pch1,pch2,pn) -> 
          undefined


extractChan :: M.Channel -> M.PosnPair -> C.Channel 
extractChan chan pn 
    = case chan of
        M.PosChan ch  -> (ch,pn) 
        M.NegChan nch -> (nch,pn)  


-- ===================================================================
-- ===================================================================

handlePattProc :: (M.Pattern,M.Process) -> 
                  State (PairList,PairList) (C.Struct_Handle ,C.Process)
handlePattProc (patt,procs) = do 
    shand  <- convPatt patt 
    cProcs <- mapM convPCom procs
    return (shand,cProcs)

{-
Important Realiation - it is important to note here that all the patterns 
that are arguments of the constructors are var patterns
-}
convPatt :: M.Pattern ->
            State (PairList,PairList)
                  (C.NamePnPair,C.NamePnPair,[C.NamePnPair])
convPatt (ConsPattern (cname,cpatts,pn)) = do  
    (dcdlist,pcplist) <- get 
    case lookup cname dcdlist of 
      Just datName -> do
          let 
            args = map (\(M.VarPattern vpn) -> vpn) cpatts   
          return ((datName,pn),(cname,pn),args) 

      Nothing -> do 
          let 
            emsg 
              = "No data type found for constructor <<" 
                 ++ cname ++ ">>" ++ Comm.printPosn pn 
          error emsg


handleProcTrip ::(M.Name,M.Process,M.PosnPair) ->
                 State (PairList,PairList) C.ProcessPhrase_hcase
handleProcTrip (hname,pcoms,pn) = do
    (dcdlist,pcplist) <- get 
    case lookup handle pcplist of 
        Just prot -> do 
          let 
            compProt = (prot,hname)
          newProcs <- mapM convPCom pcoms 
          return (compProt,newProcs)

        Nothing -> do 
          let 
            emsg 
              = "No Protocol/Coprotocol found for handle/cohandle <<" 
                 ++ nm ++ ">>" ++ Comm.printPosn pn 
          error emsg 
                  

genChPComTrip:: ([M.Channel],[M.Channel],M.Process,M.PosnPair) -> 
        State (PairList,PairList) ([C.Channel],[C.Channel],C.Process)
genChPComTrip (ichs,ochs,procs,pn) = do  
    let 
      ichsN = map (\n -> (n,pn)) ichs 
      ochsN = map (\n -> (n,pn)) ochs 
    tProcs <- mapM convPCom procs 
    return (ichsN,ochsN,tProcs)

handleForkTrip :: M.PosnPair -> (M.PChannel,[M.PChannel],M.Process) ->
      State (PairList,PairList) (C.Channel,[C.Channel],C.Process)
handleForkTrip pn (ch1,chs2,proc) = do 
    (ichs,ochs,procN) <- genChPComTrip ([ch1],chs2,proc,pn)
    return (head ichs,ochs,procN)

