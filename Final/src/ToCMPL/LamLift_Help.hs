module LamLift_Help where 

-- this module renames functions 

freshVars_help :: [Name] -> String ->
                  State (Int,[[(Name,Name)]]) [(Name,Name)]

freshVars_help [] str 
    = return []

freshVars_help (s:ss) str = do
    (n,_) <- get 
    let 
      newVar = s ++ str ++  show n 
    modify (\(stn,stp) -> (stn+1,stp)) 
    restList <- freshVars_help ss str 
    return ((s,newVar):newVars)  

getfresh_funs :: [Name] -> State (Int,[[(Name,Name)]]) [(Name,Name)]
getfresh_funs strs = do 
    freshVars_help strs "_fun_"

renameList :: [(Name,Name)] -> Term -> Term 
renameList [] fTerm 
    = fTerm 

renameList (s:ss) term 
    = renameList ss newTerm
  where
     newTerm = renameFCall s term 


renameFCall :: (Name,Name) -> Term -> Term 
renameFCall susbt@(ofn,nfn) term 
    = case term of 
        TRecord recBodyL ->
          TRecord (map (handleRecBody subst) recBodyL)

        TCallFun (fn,terms,pn) -> 
          case fn == ofn of 
            True  ->
              TCallFun (nfn,map (renameFCall subst) terms,pn)
            False -> 
              term 

        TLet    (term,lwhrs,pn) -> 
          TLet (
                 renameFCall subst term,
                 map (renameFLWhrs subst) lwhrs,pn
               ) 

        TIf     (t1,t2,t3,pn) -> 
          TIf (
                renameFCall subst t1,
                renameFCall subst t2,
                renameFCall subst t2,pn
              )

        TCase   (term,pattTerms,pn) ->
          TCase (
                  renameFCall subst term,
                  map renameFPattTerm pattTerms,pn
                )

        TFold   (Term,[FoldPattern],PosnPair) ->
          undefined 

        TUnfold (Term,FoldPattern,PosnPair) -> 
          undefined 

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



