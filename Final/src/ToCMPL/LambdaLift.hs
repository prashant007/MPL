module ToCMPL.LambdaLift where 

import TypeInfer.MPL_AST
import qualified Data.Set as S 
import Data.List


lam_lift :: [Defn] -> [Defn]
lam_lift defns  
      = map (addExtraArgs_Defn solEqns) defns
  where 
    setEqns = genSetEqns defns  
    solEqns = solveSetEqns setEqns 


{-
All the definitons here function definitions. Only things that need to be lambda
lifted are  the defns within the where part of let statements. These
defintions can be mutually recursive.
-}

genSetEqns :: [Defn] -> [SetEqn]
genSetEqns defns 
      = map genSetEqn newDefns 
  where 
    newDefns = evalState (freshFNames_Args defns) (0,0)


getBVarDefn :: Defn -> [BVar]
getBVarDefn (FunctionDefn (Custom fn,fType,[fBody],pn))
    = map (\(VarPattern (u,pn)) -> u) fPatts
  where
      ((fPatts,fTerm),_) = fBody 







 

