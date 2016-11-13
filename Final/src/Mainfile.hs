module Main where
import LexMPL
import ParMPL
import LayoutMPL
import AbsMPL
import TypeInfer.MPL_AST
import TypeInfer.TestModule
import ErrM
import PtreeToAST
import TypeInfer.SolveEqns
import TypeInfer.SolveHelper
import TypeInfer.UnifyLam
import TypeInfer.SymTabInsert

import System.Environment
import Control.Monad.Trans.State.Lazy
import Text.PrettyPrint
import Text.PrettyPrint.GenericPretty
import Control.Monad.Trans.Either



myLLexerMPL = resolveLayout True .myLexer

main = do 
   args <- getArgs
   case args of 
     [] -> do
        putStrLn "Error:Expecting a file name as an argument.Try Again."
     (fname:xs) -> do
        conts <- readFile fname
        let 
          tokens   = myLLexerMPL conts
          errPTree = pMPL tokens
        case errPTree of 
            Ok pTree -> do 
                let 
                  ast = evalState (transMPL  pTree) []
                putStrLn $ prettyStyle zigStyle ast   
                testFunction ast   
            Bad s -> do 
                putStrLn $ "Error in Parsing \n" ++ show  s     

myPack :: Package
myPack = 
  (
    ([],[]),
    [1],
    [],
   [
    (1,TypeDataType ("Tree", [TypeVarInt 1], (21, 17)))
   ]
  ) 


