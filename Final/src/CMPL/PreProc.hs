module CMPL.PreProc where 
  
import System.Directory  
import System.Environment
import System.IO 
import Data.List 
import Text.Regex.Posix
import System.FilePath.Posix
import System.Directory 
import qualified Data.Map as M 


-- regular expression for recognising includes
recognise_includes :: String -> (Bool,String)
recognise_includes str 
             | has_includ /= "" = (True,has_includ)
             | otherwise        = (False,"") 
              where has_includ = (str =~ "^%include [/]?[a-zA-Z][a-zA-Z0-9///_]*[/.]cmpl")::String

recognise_run :: String -> (Bool,String)
recognise_run str 
          | has_runs /= "" = (True,has_runs)
          | otherwise      = (False,"")
          where has_runs = (str =~ "^main_run")

trim :: String -> String
trim = unwords . words

-- The second argument ot this function recursively accumulates the imported files and
-- the third argument concatenates all these files

type FileList = [String]
type FileName = String
type FileContents = String
type Directory    = String 


impFile_contents :: FileName -> IO ([(FileName,FileContents)])
impFile_contents fname = do 
              currDir <- getCurrentDirectory 
              let (dirP,fileP) = splitFileName fname
                  basefname    = takeBaseName fileP 
                  incDirectory = currDir ++ "/" ++ dirP ++ "Include_" ++ basefname ++ "/"
                  absMainFile  = currDir ++ "/" ++ fname
                  fname_list   = absMainFile : []  
              map_impFiles_conts fname_list fname_list [("","")] (absMainFile,incDirectory)
                         

map_impFiles_conts :: [FileName] -> [FileName] -> [(FileName,FileContents)] -> (FileName,Directory) ->
                      IO ([(FileName,FileContents)])
map_impFiles_conts [] check_files fname_fcont_list (main_file,incDirectory)  = do 
              let flist = deleteFromList "" fname_fcont_list 
              return flist
              where 
                 deleteFromList emp [] = []
                 deleteFromList emp ((fn,fc):fs)
                             | emp == fn   = deleteFromList emp fs
                             | otherwise  = (fn,fc) : deleteFromList emp fs 


map_impFiles_conts (fileName:fileNames) check_files fname_fcont_list (main_file,incDirectory) = do
              case isAbsolute fileName of
                 True  -> do
                    let newFileName = fileName
                    contents <- readFile newFileName
                    let fnames       = get_import_files (newFileName,contents) main_file check_files
                        fileNames'   = fnames ++ fileNames
                        check_files' = check_files ++ fnames
                    map_impFiles_conts fileNames' check_files' ((newFileName,contents):fname_fcont_list)  (main_file,incDirectory)
                 False -> do 
                    let newFileName = incDirectory ++ fileName
                    contents <- readFile newFileName              
                    let fnames       = get_import_files (newFileName,contents) main_file check_files
                        fileNames'   = fnames ++ fileNames
                        check_files' = check_files ++ fnames
                    map_impFiles_conts fileNames' check_files' ((newFileName,contents):fname_fcont_list)  (main_file,incDirectory)
   
-- returns the file names that need to be included in the file 
get_import_files :: (FileName,FileContents) -> FileName ->[FileName] -> [FileName]
get_import_files (fileName,contents) main_file check_files = let l_contents = lines contents
                                                                 imp_files = get_import_files_helper (fileName,l_contents) main_file (fileName:check_files)
                                                             in imp_files   


get_import_files_helper :: (FileName ,[String]) -> FileName -> [FileName] -> [FileName]
get_import_files_helper (_ ,[]) _ _ = []
get_import_files_helper (fn,(l:ls)) ofile check_files
        | boolo && booli && bool_check_f            = fname : get_import_files_helper (fn,ls) ofile (fname:check_files) 
        | boolo && booli && not(bool_check_f)       = get_import_files_helper (fn,ls) ofile check_files   
        | boolo && not booli                        = get_import_files_helper (fn,ls) ofile check_files 
        | (not boolo) && booli && bool_check_f      = fname : get_import_files_helper  (fn,ls) ofile (fname:check_files) 
        | (not boolo) && booli && not(bool_check_f) = get_import_files_helper  (fn,ls) ofile check_files  
        | (not boolo) && (not booli) && (not boolr) = get_import_files_helper (fn,ls) ofile check_files
        | (not boolo) && (not booli) && boolr       = error $ "Error:main_run in one of the included files " ++  fn                     
        where 
           l'           = trim l 
           (booli,incl) = recognise_includes l 
           (boolr,_)    = recognise_run l
           boolo        = fn == ofile -- returns true if original file , false otherwise
           fname        = (words incl)!! 1
           bool_check_f = (not.elem fname) check_files   

