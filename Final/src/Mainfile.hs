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
import TypeInfer.PreProcess_Let

import ToCMPL.MPLToCMPL
import ToCMPL.GenAndSolveSetEqns
import ToCMPL.LamLift_Help
import ToCMPL.PatternCompiler
import ToCMPL.LambdaLift

import qualified CMPL.CMPLtoPTree as CP 
import qualified CMPL.STConverter_AMPL as SA 
import qualified CMPL.PrintAMPL as PA 
import qualified CMPL.CompileAll as CALL
import qualified CMPL.AMPL_am as AM 





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
                  astMPL   = evalState (transMPL  pTree) []
                  preP_MPL = preprocessBefTyping astMPL

                putStrLn $ prettyStyle zigStyle preP_MPL
                case typeMPL preP_MPL of 
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
                       finMPL_AST = pattCompile preP_MPL
                     case finMPL_AST of 
                       Left mplEmsg -> 
                          putStrLn $ unlines 
                            [equalS,equalS,mplEmsg,equalS,equalS]

                       Right fMPL  -> do
                          putStrLn $ prettyStyle zigStyle fMPL
                          
                          let 
                            astCMPL   = convMPL fMPL

                            ptreeAMPL = CP.convEverything astCMPL
                            ampl_prog = PA.printTree ptreeAMPL
                            astAMPL   = SA.transAMPLCODE ptreeAMPL
                          
                            mach      = CALL.compile_all astAMPL
                          --putStrLn $ prettyStyle zigStyle cMPL_AST
                          putStrLn ampl_prog
                          ans <- evalStateT (AM.run_cm' mach) (Map.empty)
                          let ans' = prettyStyle zigStyle ans 
                          putStrLn ans' 
                           

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



--extractTerm :: Defn -> Term 
extractTerm (FunctionDefn (_,_,pt:[],_) ) = sthg 
     where
      Left sthg = (snd.fst) pt 

testSthg_s :: TypeInfer.MPL_AST.Stmt -> IO ()
testSthg_s stmt = do 
    let 
      defn = getDefnFromstmt stmt 
      var1 = lam_lift_sel defn 
      var2 = prettyStyle zigStyle (head var1) 
    putStrLn var2

getDefnFromstmt :: TypeInfer.MPL_AST.Stmt -> TypeInfer.MPL_AST.Defn 
getDefnFromstmt (DefnStmt (ds,_,_)) = head ds 


defnStmt = 
 DefnStmt ([FunctionDefn (Custom "random",
                          NoType,
                          [(([VarPattern ("x", (19, 3)),VarPattern ("y", (19, 5)),
                              VarPattern ("z", (19, 7))],
                             Left $ TLet (TConst (ConstInt 1, (20, 12)),
                                        [LetDefn (FunctionDefn (Custom "letFun",
                                                                NoType,
                                                                [(([VarPattern ("p",
                                                                                (23,
                                                                                 16))],
                                                                   Left $ TCallFun (BuiltIn Add_I,
                                                                                  [TVar ("p",
                                                                                         (23,
                                                                                          22)),
                                                                                   TVar ("z",
                                                                                         (23,
                                                                                          26))],
                                                                                  (23,
                                                                                   26))),
                                                                  (23, 16))],
                                                                (22, 13)))],
                                        (19, 12))),
                            (19, 3))],
                          (18, 1))],
           [],
           (18, 1))

letDefn_Fun1 =
  FunctionDefn (Custom "letFun",
                NoType,
                [(([VarPattern ("p",
                                (23,
                                 16))],
                   Left $ TCallFun (BuiltIn Add_I,
                                  [TVar ("p",
                                         (23,
                                          22)),
                                   TVar ("p",
                                         (23,
                                          26))],
                                  (23,
                                   26))),
                  (23, 16))],
                (22, 13))

letDefn_Fun2 =
  FunctionDefn (Custom "someFun",
                NoType,
                [(([VarPattern ("p",
                                (23,
                                 16))],
                   Left $ TCallFun (Custom "letFun",
                                  [
                                   TVar ("y",
                                         (23,
                                          26))
                                  ],
                                  (23,
                                   26))),
                  (23, 16))],
                (22, 13))

lf1 =
  FunctionDefn (Custom "f1",
                            NoType,
                            [(([VarPattern ("a",
                                            (21,
                                             16))],
                               Left $ TCallFun (BuiltIn Add_I,
                                              [TVar ("a",
                                                     (21,
                                                      22)),
                                               TCallFun (Custom "f2",
                                                         [TVar ("x",
                                                                (21,
                                                                 30))],
                                                         (21,
                                                          26))],
                                              (21,
                                               26))),
                              (21, 16))],
                            (20, 13))

lf2 = 
    FunctionDefn (Custom "f2",
                              NoType,
                              [(([VarPattern ("b",
                                              (24,
                                               16))],
                                 Left $ TCallFun (BuiltIn Add_I,
                                                [TVar ("b",
                                                       (24,
                                                        22)),
                                                 TCallFun (Custom "f3",
                                                           [TVar ("y",
                                                                  (24,
                                                                   30))],
                                                           (24,
                                                            26))],
                                                (24,
                                                 26))),
                                (24, 16))],
                              (23, 13))

lf3 =
  FunctionDefn (Custom "f3",
                          NoType,
                          [(([VarPattern ("c",
                                          (27,
                                           16))],
                             Left $ TCallFun (BuiltIn Add_I,
                                            [TVar ("c",
                                                   (27,
                                                    21)),
                                             TCallFun (Custom "f1",
                                                       [TVar ("z",
                                                              (27,
                                                               29))],
                                                       (27,
                                                        25))],
                                            (27,
                                             25))),
                            (27, 16))],
                          (26, 13))

funList  = [lf1,lf2,lf3]