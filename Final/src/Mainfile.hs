module Main where
import LexMPL
import ParMPL
import LayoutMPL
import AbsMPL
import ErrM
import PtreeToAST

-- note that not all imports are required here. Get rid
import TypeInfer.MPL_AST
import TypeInfer.Gen_Eqns_Stmt
import TypeInfer.SolveEqns
import TypeInfer.SolveHelper
import TypeInfer.Unification
import TypeInfer.SymTab_Insert



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




runstmt
 = RunStmt (NoType,
          ["console"],
          ["intTerm1"],
          [PHPut ("GetInt", "intTerm1", (18, 12)),
           PGet (VarPattern ("num1", (19, 16)), "intTerm1", (19, 12)),
           PHPut ("GetInt", "intTerm1", (20, 12)),
           PGet (VarPattern ("num2", (21, 16)), "intTerm1", (21, 12)),
           PHPut ("Close", "intTerm1", (22, 12)),PClose ("intTerm1", (23, 12)),
           PHPut ("CloseC", "console", (24, 12)),PHalt ("console", (25, 12))],
          (17, 1))
