module TypeInfer.TestModule where

import TypeInfer.GenEqns_MPL
import TypeInfer.SolveEqns
import TypeInfer.MPL_AST
import TypeInfer.SymTab
import TypeInfer.SymTabDataType
import TypeInfer.InitSymTab

import Control.Monad.Trans.Either
import Control.Monad.State.Lazy 
import Text.PrettyPrint.GenericPretty
import Text.PrettyPrint
import Data.List 


testFunction :: MPL -> IO () 
testFunction mplstmts = do 
    let 
      stEith  = runEitherT (takeCareofMPL mplstmts) 
      eithVal = evalState stEith (1,0,[],toBeginSymTab)    
    case eithVal of 
        Left emsg -> 
            putStrLn $ unlines
                        [
                          "\n",equalS,equalS,emsg,
                          equalS,equalS
                        ]  

        Right (symtab,tripList)  -> do
            --putStrLn $ show symtab
            putStrLn $ unlines
                         [equalS,equalS,"See types of all functions or details of one?","\n",
                          "1 for all","\n","Anything else for details of one",equalS,equalS] 
            outChoice <- getLine
            case outChoice of
                "1" -> do 
                    putStrLn $ printAllTypes tripList                  
                otherwise -> do 
                   putStrLn "Enter Function number\n"
                   funno <- fmap (\x -> (read x)::Int) getLine 
                   let 
                     partTriple = tripList !! (funno-1)              
                   putStrLn $ unlines ["1 for type","2 for Equations","3 for logs"]            
                   inchoice <- getLine
                   putStrLn $ printType partTriple inchoice


printAllTypes :: [([Defn],(Log,Package),[TypeEqn])] -> String 
printAllTypes quadList = concat $ map (\q -> printType q "1") quadList


printType :: ([Defn],(Log,Package),[TypeEqn]) -> String -> String
printType (newdefns,logpack,tEqns) choice 
        = case choice of
              "1" ->  
                  unlines [
                           equalS,"\n",
                           showtypeList,"\n",
                           equalS
                          ] 
                 where
                    showtypeList 
                      = concat $ map (\x -> (concat.(map showType).getType) x ++ "\n") newdefns  
              "2" -> 
                  unlines
                     [
                      equalS,equalS,"\n",
                      showEqns,"\n",
                      equalS,equalS
                     ]
                  where
                     showEqns = prettyStyle zigStyle tEqns

              otherwise -> do 
                  intercalate "\n" log
                where
                  (log,package)
                       = logpack 


{-
First of all find all the data and the codata statements and use it to
form the state
-}

isDatCodatStmt :: Stmt -> Bool 
isDatCodatStmt stmt 
        = case stmt of 
              RunStmt _ -> False 
              DefnStmt (defns,stmts,pn) -> 
                  case length stmts == 0 of 
                      True  ->
                           case (head defns) of 
                               Data _    -> True
                               Codata _  -> True
                               otherwise -> False
                      False -> 
                           False 


getDatCodat :: Stmt -> Defn 
getDatCodat (DefnStmt (defns,[],pn)) = head defns

takeCareofMPL :: MPL -> EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) 
                                         (SymbolTable,[([Defn],(Log,Package),[TypeEqn])])
takeCareofMPL stmts = do 
        (_,_,_,origSTab) <- get 
        let 
          alldCdstmts
                  = filter isDatCodatStmt stmts
          allDorCdDefns 
                  = map getDatCodat alldCdstmts
          symTab  = insert_ST allDorCdDefns origSTab NewScope 
          remStmts= stmts \\ alldCdstmts
        modify $ \(n,tt,c,st) -> (1,0,[],symTab)  
        triples <-  takeCareofStmtList remStmts
        (_,_,_,newsTab) <- get 
        return (newsTab,triples)  



takeCareofStmtList :: [Stmt] -> EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) 
                                                [([Defn],(Log,Package),[TypeEqn])]
takeCareofStmtList []
        = return []
takeCareofStmtList (s:ss) = do 
        ts  <- takeCareofStmt s 
        tss <- takeCareofStmtList ss 
        return $ (ts ++ tss)

takeCareofStmt :: Stmt -> EitherT ErrorMsg (State (Int,TypeThing,Context,SymbolTable)) 
                                           [([Defn],(Log,Package),[TypeEqn])]
takeCareofStmt stmt 
        = case stmt of 
              DefnStmt (defns,stmts,pn) ->
                  case length stmts == 0 && length defns == 1 of 
                      -- this is a simple defn and not a module defn
                      True  -> do 
                        (_,_,_,symTab) <- get 
                        quad <- takeCareofDefn (head defns)
                        let 
                          (newdefns,(log,package),tEqns) = quad
                          newST = insert_ST newdefns symTab OldScope
                        modify $ \(n,tt,c,st) -> (1,0,[],newST)
                        return [quad]   
                      -- this is module defn. The defns will be visible outside the
                      -- defn but the statement will be visible only inside the defn.  
                      False -> do 
                        (_,_,_,oldSymTab) <- get 
                        (symTab,quadstmList) <- takeCareofMPL stmts
                        let
                           nDefsStmts 
                               = concat $ map (\(a,b,c) -> a) quadstmList 
                           newSTStmts
                               = insert_ST nDefsStmts symTab NewScope  
                        let 
                          funDefns= getallFuns defns
                          remDefns= defns \\ funDefns
                          --lDefns  = length funDefns
                          --newVars = [0..(lDefns-1)]
                        modify $ \(n,tt,c,st) -> (1,0,[],newSTStmts)  
                        quadFDefn   <- takeCareofFunDefns funDefns 
                        modify $ \(n,tt,c,st) -> (1,0,[],symTab)                      
                        quadRestDefn <- takeCareofDefns remDefns 
                        let 
                          (finMutDefns,(mlog,mpackage),mteqns)
                               = quadFDefn 
                          finRemDefns 
                               = concat $ map (\(a,b,c) -> a) quadRestDefn 
                          newSTDefns
                               = insert_ST (finMutDefns ++ finRemDefns) oldSymTab OldScope  
                        modify $  \(n,tt,c,st) -> (1,0,[],newSTDefns)
                        return [quadFDefn]      
                           
              RunStmt _ -> undefined



showType :: (FuncName,FunType) -> String
showType (fname,fType) = show fname ++ " :: " ++ show fType


getType :: Defn -> [(FuncName,FunType)] 
getType (FunctionDefn (fname,fType,_,_)) 
        =  [(fname,fType)]




getallFuns :: [Defn] -> [Defn]
getallFuns defns = filter isFunDefn defns 

isFunDefn :: Defn -> Bool
isFunDefn defn = case defn of
        (FunctionDefn _) -> True 
        otherwise       -> False   





