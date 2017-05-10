module Main where
import MPLPar.LexMPL
import MPLPar.ParMPL
import MPLPar.LayoutMPL
import MPLPar.AbsMPL
import MPLPar.ErrM
import MPLPar.PtreeToAST

-- note that not all imports are required here. Get rid
import TypeInfer.MPL_AST
import TypeInfer.Gen_Eqns_Stmt
import TypeInfer.Gen_Eqns_CommFuns
import ToCMPL.MPLToCMPL

import qualified CMPL.CMPLtoPTree as CP 
import qualified CMPL.STConverter_AMPL as SA 
import qualified CMPL.PrintAMPL as PA 
import qualified CMPL.CompileAll as CALL
import qualified CMPL.AMPL_am as AM 


import ToCMPL.PatternCompiler
import ToCMPL.PatternComp_Help
import ToCMPL.LambdaLift


import System.Environment
import Control.Monad.Trans.State.Lazy
import Text.PrettyPrint
import Text.PrettyPrint.GenericPretty
import Control.Monad.Trans.Either
import qualified Data.Map as Map 


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
                  astMPL = evalState (transMPL  pTree) []
                putStrLn $ prettyStyle zigStyle astMPL
                case typeMPL astMPL of 
                   Left emsg -> 
                     putStrLn emsg 
                   Right typemsg -> do
                     let 
                       msg  = "Do you want to see the types?"
                       msgF = unlines 
                                [equalS,equalS,msg,equalS,equalS]
                     bool <- getChoice
                     printMsg (msgF ++ typemsg) Nothing bool
                     let 
                       finMPL_AST = pattCompile astMPL 
                     case finMPL_AST of 
                       Left mplEmsg -> 
                          putStrLn $ unlines 
                            [equalS,equalS,mplEmsg,equalS,equalS]

                       Right fMPL  -> do
                          let 
                            astCMPL   = convMPL fMPL

                            ptreeAMPL = CP.convEverything astCMPL
                            ampl_prog = PA.printTree ptreeAMPL
                            astAMPL   = SA.transAMPLCODE ptreeAMPL
                          {-
                            mach      = CALL.compile_all astAMPL
                          --putStrLn $ prettyStyle zigStyle cMPL_AST
                          putStrLn ampl_prog
                          ans <- evalStateT (AM.run_cm' mach) (Map.empty)
                          let ans' = prettyStyle zigStyle ans 
                          putStrLn ans' 
                         -}
                          putStrLn ampl_prog

                           

            Bad s -> do 
                putStrLnRed $ "Error in Parsing \n" ++ show  s     


printMsg :: String -> Maybe String ->  Bool -> IO ()
printMsg msg mayVal bool 
    = case bool of 
        True -> 
          putStrLn msg 
        False ->
          case mayVal of 
            Just msgFalse ->
              putStrLn msgFalse
            Nothing ->
              return  ()


getChoice :: IO Bool
getChoice  = do
   let 
     msg  = "Enter y/Y/Yes/yes for yes or n/N/No/no for No"
     msgF = unlines [equalS,equalS,msg,equalS,equalS]

   putStrLn msgF  
   ch <- getLine
   let 
     yess = ["y","Y","yes","Yes"]
     nos  = ["n","N","no","No"]
   case ch `elem` yess of 
      True ->
        return True 
      False ->
        case ch `elem` nos of 
          True ->
            return False 
          False -> do 
            putStrLn "Invalid Choice."
            getChoice  




