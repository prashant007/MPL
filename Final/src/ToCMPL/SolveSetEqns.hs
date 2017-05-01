module ToCMPL.SolveSetEqns where

import qualified Data.Set as S 
import Data.List 



solveSetEqns :: [SetEqn] -> [(Name,[FVar])]
solveSetEqns seteqns = get_Subst finSetEqns
    where
      -- list of functions which doesn't depend on any function  
      noDepends = filter (\(_,(_,_,nms) )-> nms == []) seteqns 
      -- remaining equations
      remEqns   = seteqns \\ noDepends
      --linearize the remEqns wrt noDepends
      newRemEqs = linWrtConsts (noDepends,remEqns)
      -- systematically linearize the newRemEqs
      linNewRem = linearize_list newRemEqs (length remEqns) 
      finSetEqns= noDepends ++ linNewRem

get_Subst :: [SetEqn] -> [(Name,[FVar])]
get_Subst seqns = map (\(nm,(_,fvs,_)) -> (nm,S.toList fvs)) seqns


linearize_list :: [SetEqn] -> Int -> [SetEqn]
linearize_list setEqns 0 
    = setEqns

linearize_list setEqns num 
    = linearize_list combEqns (num-1)
  where
    befEqns' = linearize eqn befEqns
    aftEqns' = linearize eqn aftEqns
    combEqns = befEqns' ++ (eqn:aftEqns')
    (befEqns,eqn,aftEqns) 
        = mySplit num setEqns



{-
For example 
mySplit 3 [1,2,3,4,5] = ([1,2],3,[4,5])
-}
mySplit :: Int -> [a] -> ([a],a,[a])
mySplit num list 
    = (init l1,last l1,l2)
  where
     (l1,l2) = splitAt num list  

{-
This function will take set equations divided into two parts and linearize
second equation list with respect to the first equation list.
The first element of the pair are the equations that don't depend on other 
functions and second element are the the ones that do. 
-}

linWrtConsts :: ([SetEqn],[SetEqn]) -> [SetEqn]
linWrtConsts ([],fds)
        = fds 
linWrtConsts (n:ns,ds)
        = linWrtConsts (ns,linearize n ds) 


{-
Look at the places where the function name (first argument) in 
the set equation (the first argument) is present in the second argument 
and do the substitution.

linearize the list wrt to the first SetEqn
-}

linearize :: SetEqn -> [SetEqn] -> [SetEqn]
linearize sEqn []
      = []
linearize sEqn setEqns 
      = finSubsEqs ++ nosubsEqs
  where
    (fnm,_)    = sEqn
    -- equations where substitutions can happen
    subsEqns   = filter (funPresent fnm) setEqns
    -- equations where substitutions can't happen
    nosubsEqs  = setEqns \\ subsEqns
    -- equations after substitutions
    finSubsEqs = map (substitute sEqn) subsEqns
    

{-
This function will return a true if the function name which is the first 
argument is present is the fourth argument of the Seteqn.
-}
funPresent :: Name -> SetEqn -> Bool 
funPresent fnm (_,(_,_,names))
    = elem fnm names 



{-
The second SetEqn (set2) has a dependency on a function. The first argument 
(SetEqn set1) is the setEqn corresponding to that. The output is the modified 
SetEqn2. 
-}
substitute :: SetEqn -> SetEqn -> SetEqn
substitute set1 set2 
    = case elem g funs_fin of 
          False ->
            (g,(g_bvars,fvars_fin,funs_fin))  
          True ->
            (g,(g_bvars,fvars_fin,delete g funs_fin)) 
   where
     (f,(f_bvars,f_fvars,f_funs)) 
               = set1 
     (g,(g_bvars,g_fvars,g_funs)) 
               = set2
     -- final free variables
     fvars_fin = S.difference (S.union g_fvars f_fvars) g_bvars  
     funs_fin  = f_funs ++ (delete f g_funs)


eqn1 = ("f",(S.fromList ["x","i"],S.fromList ["y"],["g","p"]))
eqn2 = ("g",(S.fromList ["y"],S.fromList ["z"],["h"]))
eqn3 = ("h",(S.fromList ["z"],S.fromList ["x"],["f"]))
eqn4 = ("p",(S.fromList ["j"],S.fromList ["x","i"],[]))

eqns = [eqn1,eqn2,eqn3,eqn4]

test = do 
    let 
      oval = solveSetEqns eqns 
    mapM_ (putStrLn.show) oval