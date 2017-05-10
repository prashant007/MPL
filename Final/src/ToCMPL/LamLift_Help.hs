module LamLift_Help where 

{-
This function will generate fresh function names and arguments.
-}

freshFNames_Args :: [Defn] -> 
                    State (Int,Int) [Defn]
freshFNames_Args []
    = return []
freshFNames_Args dlist = do 
    let 
      flist = map getFunNames dlist 
    substList <- freshFunNames flist 
    let 
      newDefns = map (freshFNames_Term substList) dlist
    finDefns <- mapM freshVarsFun  newDefns
    return finDefns 

{-
This function takes a function and refreshes its arguments.
-}

freshVarsFun :: Defn -> State (Int,Int) Defn 
freshVarsFun (FunctionDefn (fnm,fT,(patts,term):[],pn)) = do 
    (sList,newPatts) <- freshVarNames patts
    let 
      newTerm = replaceVars_Term sList term
    return $ FunctionDefn (fnm,fT,(newPatts,newTerm):[],pn)


replaceVars_Term :: [(Name,Name)] -> Term -> Term 
replaceVars_Term sList term 
    = case term of
        TRecord tList ->
            TRecord newtList
          where 
            newtList = map (\(p,t,pn) -> p,replaceVars_Term sList t,pn) tList

        TCallFun (fname,terms,pn) ->
            TCallFun (fname,newTerms,pn)
          where 
            newTerms = map (replaceVars_Term sList) terms 

        TLet (Term,[LetWhere],PosnPair) ->
            undefined 

        TVar (var,pn) -> 
            case lookup var sList of 
              Nothing   -> term
              Just nVar -> TVar (nVar,pn)
             
        TIf (t1,t2,t3,pn) -> 
            TIf (
                 replaceVars_Term sList t1,replaceVars_Term sList t2,
                 replaceVars_Term sList t3,pn
                )

        TCase (term,pattList,pn) -> 
            TCase (replaceVars_Term sList term,newPattList,pn)
          where 
            newPattList = map (\(p,Left cTerm) -> (p,Left (replaceVars_Term sList cTerm))) pattList

        TFold(term,foldPatts,pn) -> 
            TFold
              (
               replaceVars_Term sList term,
               map (\(a,b,t,p) -> (a,b,replaceVars_Term sList t,p)) foldPatts,
               pn 
              )

        TCons (nm,terms,pn) ->
            TCons 
              (nm, map (\t -> replaceVars_Term sList t) terms, pn)


        TDest (nm,terms,pn) ->
            TDest
              (nm, map (\t -> replaceVars_Term sList t) terms, pn)

        TProd (terms,pn) ->
            TProd (map (\t -> replaceVars_Term sList t) terms, pn)

        otherwise -> 
            term 
          



{-
This function replaces the old function names with their 
newly coined names.
-}

freshFNames_Term :: [(Name,Name)] ->  Defn -> Defn
freshFNames_Term substList (FunctionDefn (Custom fnm,fT,pattTerms,pn)) 
    = FunctionDefn (Custom newName,fT,newPattTerms,pn)
  where 
      newName  
          = (fromJust.lookup fnm) substList
      newPattTerms
          = map (freshFNames_PattTerm substList) pattTerms

freshFNames_PattTerm :: [(Name,Name)] -> (PatternTermPhr,PosnPair) -> 
                        (PatternTermPhr,PosnPair)

freshFNames_PattTerm slist ((patts,Left term),pn)    
      = ((patts,Left newTerm),pn)
  where 
    newTerm = renameFunList slist term

getFunNames :: Defn -> Name 
getFunNames (FunctionDefn (funcName,_,_,_))
    = removeFunc funcName 

removeFunc :: FuncName -> Name
removeFunc (Custom  name)
    = name 
       


-- ===========================================================
-- ===========================================================

{-
Generate new function names for all the functions
-}

freshFunNames :: [Name] -> State (Int,Int) [(Name,Name)]
freshFunNames [] 
    = return []

freshFunNames (s:ss) = do
    (n,_) <- get 
    let 
      newVar = s ++ "_fun_" ++  show n 
    modify (\(stn,dcare) -> (stn+1,dcare)) 
    restList <- freshFunNames ss 
    return ((s,newVar):restList)  

-- ===========================================================
{-
Generate fresh variables for the arguments of the function. 
-}
freshVarNames :: [Pattern] -> [(Name,Name)] -> [Pattern] ->
                 State (Int,Int) ([(Name,Name)],[Pattern])

freshVarNames [] accList accPatt
    = (accList,accPatt)

freshVarNames ((VarPattern(v,pn)):ss) accList accPatt = do
    (_,n) <- get 
    let 
      newVar = v ++ "_lv" ++  show n 
    modify (\(dcare,stn) -> (dcare,stn+1)) 
    freshVarNames ss ((s,newVar):accList) (VarPattern(newVar,pn):accPatt)

-- ===========================================================

{-
rename the old functions with their new names.
-}
renameFunList :: [(Name,Name)] -> Term -> Term 
renameFunList [] fTerm 
    = fTerm 

renameFunList (s:ss) term 
    = renameFunList ss newTerm
  where
     newTerm = renameFCall s term 


renameFCall :: (Name,Name) -> Term -> Term 
renameFCall susbt@(ofn,nfn) term 
    = case term of 
        TRecord recBodyL ->
          TRecord (map (handleRecBody subst) recBodyL)

        TCallFun (fName,terms,pn) -> 
          case fName of 
            Custom fn ->
              case fn == ofn of 
                True  ->
                  TCallFun (nfn,map (renameFCall subst) terms,pn)
                False -> 
                  term

            otherwise ->
              term 

        TLet    (term,lwhrs,pn) -> 
          undefined 

         {-
          TLet (
                 renameFCall subst term,
                 map (renameFLWhrs subst) lwhrs,pn
               ) 
         -} 

        TIf     (t1,t2,t3,pn) -> 
          TIf (
                renameFCall subst t1,
                renameFCall subst t2,
                renameFCall subst t2,pn
              )

        TCase (term,pattTerms,pn) ->
          TCase (
                  renameFCall subst term,
                  map renameFPattTerm pattTerms,pn
                )

        TFold (term,foldPatts,pn) ->
          TFold (
                 renameFCall subst term,
                 map (\(n,ps,fTerm,fPn) -> (n,ps,renameFCall subst fTerm,fPn)) foldPatts,
                 pn
                ) 

        TCons   (nm,terms,pn) -> 
          TCons (nm,map (renameFCall subst) terms,pn)

        TDest   (nm,terms,pn) ->
          TDest (nm,map (renameFCall subst) terms,pn)

        TProd   (terms,pn) ->
          TProd (map (renameFCall subst) terms,pn)

        otherwise -> 
          term       

-- =================================================================
-- =================================================================

handleRecBody :: (Name,Name) -> (Pattern,Term,PosnPair) -> 
                 (Pattern,Term,PosnPair)

handleRecBody subst (p,t,pn)
    = (p,newT,pn)
  where
    newT = renameFCall susbt t 

handleFBody :: (Name,Name) -> ((Pattern,Term),PosnPair) -> 
                  ((Pattern,Term),PosnPair)

handleFBody subst ((patt,term),pn)
    = ((patt,renameFCall subst term),pn)

renameFLWhrs :: (Name,Name) ->  LetWhere -> LetWhere 
renameFLWhrs subst@(ofn,nfn) lwhr 
    = case lwhr of 
        LetDefn defn ->
          case defn of 
            FunctionDefn (fnm,fType,fbody,pn) ->
              case ofn == fnm of 
                True  ->
                  FunctionDefn ( nfn,fType,
                                 map (handleFBody subst) fbody,
                                 pn
                               )

                False ->
                  FunctionDefn ( fnm,fType,
                                 map (handleFBody subst) fbody,
                                 pn
                               )


        LetPatt (patt,term) -> 
          LetPatt (patt,renameFCall subst term)


isFunDefnL :: Defn -> Bool 
isFunDefnL (FunctionDefn _)
    = True 
isFunDefnL _ 
    = False 


-- =================================================================
-- =================================================================
-- =================================================================
-- =================================================================

{-
Once the equations have been solved, the extra arguments need to be added to 
the function definitions and function calls using the solution of the set 
equation.
-}

addExtraArgs_Defn :: [(Name,[FVar])] -> Defn ->  Defn
addExtraArgs_Defn sList (FunctionDefn (fName,fT,pattsList,pn))
      = case fName of 
          Custom nm  ->
            case lookup nm sList of 
              Nothing -> 
                  FunctionDefn (fName,fT,[newPattList],pn)
              Just fvars ->
                  FunctionDefn (fName,fT,[augPattList],pn)
                where
                  augPattList
                    = ((patts ++ map (\x -> TVar (x,pn)) fvars),newPTerm)  

          otherwise  -> 
              FunctionDefn (fName,fT,[newPattList],pn)
  where
    (patts,Left pTerm)
      = head pattsList
    newPTerm   
      = Left (addExtArgs_Term sList pTerm)
    newPattList
      = (patts,newPTerm)  



addExtArgs_Term :: [(Name,[FVar])] -> Term -> Term 
addExtArgs_Term sList term 
    = case term of 
        TRecord recList ->
            TRecord (map (\(p,t,pn) -> (p,addExtArgs_Term sList t,pn)) recList)

        TCallFun (fName,terms,pn) ->
            case fname of 
              Custom fnm ->
                case lookup fnm sList of 
                  Nothing ->
                    term 
                  Just fvars -> 
                    TCallFun (fName,terms ++ map (\x -> TVar (x,pn)) fvars,pn)  

              otherwise -> 
                term 

        TLet (term,letWhrs,pn) -> 
            undefined

        TIf (t1,t2,t3,pn) -> 
            TIf (
                  addExtArgs_Term sList t1,
                  addExtArgs_Term sList t2,
                  addExtArgs_Term sList t3,pn
                )

        TCase (term,pattsList,pn) ->
            TCase (
                    addExtArgs_Term sList term,
                    map (\(p,Left pTerm) -> (p,Left (addExtArgs_Term sList pTerm))) pattsList,
                    pn
                  )


        TFold (term,foldPatts,pn) ->
            TFold (
                   addExtArgs_Term sList term,
                   map (\(n,pt,t,p) -> (a,pt,addExtArgs_Term sList t,p)) foldPatts,pn
                  )
            
        TCons (nm,terms,pn) ->
            TCons (nm,map (addExtArgs_Term sList) terms,pn)

        TDest (nm,terms,pn) ->
            TDest (nm,map (addExtArgs_Term sList) terms,pn)

        TProd (terms,pn) ->
            TProd (map (addExtArgs_Term sList) terms,pn)

        otherwise ->
            term