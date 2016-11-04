module Paths_Final (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/prashant/.cabal/bin"
libdir     = "/home/prashant/.cabal/lib/x86_64-linux-ghc-7.10.3/Final-0.1.0.0-7W1DWX0q6zKHkUHRdqvUpg"
datadir    = "/home/prashant/.cabal/share/x86_64-linux-ghc-7.10.3/Final-0.1.0.0"
libexecdir = "/home/prashant/.cabal/libexec"
sysconfdir = "/home/prashant/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Final_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Final_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Final_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Final_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Final_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
