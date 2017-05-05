module CMPL.Terminal where

import Network
import Control.Concurrent
import System.IO
import Text.Printf
import Data.IORef
import Control.Concurrent.STM.TChan
import Control.Monad.STM
import System.Cmd
import System.Console.ANSI

import Control.Monad

import CMPL.TypesAMPL

equalS = replicate 80 '='
stars  = replicate 70 '*'
 
communicateT sock h tchan bool1 ch (comm,val,num) = do
    hSetSGR h [(SetConsoleIntensity BoldIntensity),(SetColor Foreground Vivid Cyan),(SetColor Background Dull Blue)]
    let chn = uniform_ch_length ch 
    hPutStrLn h (equalS  ++ "\n" ++ equalS)  
    hPutStrLn h ((replicate 34 '=') ++ "CHANNEL " ++
                 chn ++ (replicate 34 '='))

    hPutStrLn h (equalS ++ "\n\n")
    let stars = " ****************************************" 
    hSetTitle h $ stars ++ " CHANNEL   " ++ chn  ++ stars ++ "*****************"
    hSetSGR h [(SetColor Foreground Vivid Cyan),(SetColor Background Dull Black)]
    if (comm == "put")
        then do
            case val of
                V_INT n' -> do
                       hPutStrLn h $  show n'  
                V_CHAR c -> do
                       hPutChar h c   
                                     
        else do
            hPutStr h "> "    
    communicateTHelper h tchan ch (comm,val,num)
    hClose h 
    --sClose sock

communicateTHelper h tchan ch (comm,val,n)  
         | n <= 0 && n >= -99 = do
            line <- hGetLine h
            putStrLn $ "The entered number is " ++ line
            let intVal = V_INT (read line::Int)
            atomically $ writeTChan tchan intVal
            communicateTHelper h tchan ch (comm,val,n)  
         | n <= -100  && n >= -199 = do
            char1 <- hGetChar h
            putStrLn $ "The entered character is " ++ (char1 :[])
            let charVal = V_CHAR char1
            atomically $ writeTChan tchan charVal 
            communicateTHelper h tchan ch (comm,val,n)    



communicate ::  Socket -> Bool -> CH -> (String,VAL,Int) -> IO (TChan VAL,Handle)
communicate sock bool1 ch (comm,val,num) = do
    b <- atomically $ newTChan
    --b <- newTChanIO 
    (h,host,po) <- accept sock
    --threadDelay 100000
    forkIO $ communicateT sock  h b bool1 ch  (comm,val,num)
    return (b,h) 

uniform_ch_length :: Int -> String 
uniform_ch_length ch 
      | ch <= 0 && ch >= -9    = "-00" ++ show neg_ch
      | ch <= -10 && ch >= -99 = "-0" ++ show neg_ch 
      | otherwise =  show ch 
      where neg_ch = negate ch   