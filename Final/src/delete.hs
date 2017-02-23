module Main where
import LexMPL
import ParMPL
import LayoutMPL
import AbsMPL
import TypeInfer.MPL_AST
--import TypeInfer.TestModule
import ErrM
import PtreeToAST
import TypeInfer.SymTab
import TypeInfer.Gen_Eqns_Conc
import TypeInfer.Gen_Eqns_Defn
import TypeInfer.Gen_Eqns_Stmt
import TypeInfer.SolveEqns 

import System.Environment
import Control.Monad.Trans.State.Lazy
import Text.PrettyPrint
import Text.PrettyPrint.GenericPretty
import Control.Monad.Trans.Either



myLLexerMPL = resolveLayout True .myLexer

main = do 
    fname <- getLine
    conts <- readFile fname
    let 
      tokens   = myLLexerMPL conts
      errPTree = pMPL tokens
    case errPTree of 
        Ok pTree -> do 
            let 
              ast = evalState (transMPL  pTree) []
            putStrLn $ prettyStyle zigStyle ast   

        Bad s -> do 
            putStrLn $ "Error in Parsing \n" ++ show  s     



