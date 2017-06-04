module CMPL.Terminal where

import System.IO

import System.Console.ANSI
import Data.Char 

import Control.Monad
import Control.Monad.Trans.State.Lazy
import Control.Monad.IO.Class
import CMPL.TypesAMPL


equalS = replicate 80 '='
stars  = replicate 70 '*'


checkNum :: String -> Either String VAL
checkNum (v:vs)
    = case v of 
         '-' -> case validNumber vs of 
                  Right _   -> return $ V_INT (read (v:vs)::Int)
                  Left emsg -> Left emsg  
         _   -> case validNumber (v:vs) of
                  Right _   -> return $ V_INT (read (v:vs)::Int)
                  Left emsg -> Left emsg            

validNumber :: String -> Either String Bool   
validNumber strVal 
    = case (and.map isDigit) strVal of 
        True  ->
          return True

        False -> 
          Left $ strVal ++ " is not a valid number.Try again."

 
handle_GET :: CH -> Handle -> StateT CH_MAP IO VAL 
handle_GET n handle = do
    case (-99 < n) && (n <= 0)  of
        True -> do 
          liftIO $ hPutStr handle "> "
          strVal <- liftIO $ hGetLine handle
          liftIO $ putStrLn $ "Number " ++ strVal ++ " entered on channel " 
                              ++ show n  ++ "\n" ++ stars
          case checkNum strVal of 
            Left emsg -> do 
                liftIO $ hPutStrLn handle emsg 
                handle_GET n handle

            Right val ->     
                return val   
            
        False -> do
          char1 <- liftIO $ hGetChar handle   
          liftIO $ putStrLn $ "Character " ++ char1:[] ++ 
                              " entered on channel " ++ show n  ++ stars 
          let 
            val = V_CHAR char1
          return val 

handle_PUT :: CH -> VAL -> Handle -> StateT CH_MAP IO ()
handle_PUT ch m handle = do 
    case m of
      V_INT n' -> do
        liftIO $ hPutStrLn handle $  show  n'  

      V_CHAR c -> do
        liftIO $ hPutChar handle c 


printOnHandle :: Handle -> CH -> IO ()
printOnHandle h chn = do  
    let 
      uchn  = uniform_ch_length chn 
      uch   = (replicate 34 '=') ++ "CHANNEL " ++ 
              uchn ++ (replicate 34 '=')
      reprs = unlines [equalS,equalS,uch,equalS,equalS]

    hPutStrLn h reprs


uniform_ch_length :: Int -> String 
uniform_ch_length ch 
      | ch <= 0 && ch >= -9    = "-00" ++ show neg_ch
      | ch <= -10 && ch >= -99 = "-0" ++ show neg_ch 
      | otherwise =  show ch 
      where neg_ch = negate ch   