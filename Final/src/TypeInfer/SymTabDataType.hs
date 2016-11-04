module TypeInfer.SymTabDataType where

import TypeInfer.MPL_AST

type ConsVal = ((DataName,[Name]),FunType,(FunType,FunType),Int) -- Second one 
-- is the data type
type DestVal = ((DataName,[Name]),FunType,Int)
-- ((data Name,allconstructors) ,constructor type,
-- fold Type of constructor,noumber of constructor args)
type HandVal = (Name,Protocol,(Int,Int))

data SymbolDefn  =   SymData    [(Name,ConsVal)] --first is the constructor name)
                   | SymCodata  [(Name,DestVal)] 
                   | SymProt    [(Name,HandVal)]
                   | SymCoProt  [(Name,HandVal)]
                   | SymTypeSyn [(Name,Type)]
                   | SymFun     [(FuncName,(FunType,NumArgs))]
                   | SymProc    [(Name,(Maybe ProcessType,(NumArgs,NumArgs,NumArgs)))]
                  deriving (Eq,Show)

data ScopeType =  OldScope
                | NewScope 
                deriving (Eq,Show) 

type ScopeSymbols = [SymbolDefn]
type SymbolTable  = [ScopeSymbols]
type Context      = [ScopeContext] 
type ScopeContext = [(String,Type)]


-- These are the things that will be looked up in the symbol table.
data ValLookup =    Val_Cons    (Name,PosnPair)
                  | Val_Dest    (Name,PosnPair) 
                  | Val_Prot    (Name,PosnPair)
                  | Val_Coprot  (Name,PosnPair)
                  | Val_TypeSyn (Name,PosnPair) 
                  | Val_Fun     (FuncName,PosnPair) 
                  | Val_Proc    (Name,PosnPair)
                 deriving (Eq,Show)

-- The return values from the symbol table.
data ValRet =     ValRet_Cons   ((DataName,[Name]),FunType,(FunType,FunType),NumArgs)
                | ValRet_Dest   ((DataName,[Name]),FunType,NumArgs)
                | ValRet_Prot   (Name,Protocol,(Int,Int))
                | ValRet_Coprot (Name,Protocol,(Int,Int))
                | ValRet_TypeSyn Type 
                | ValRet_Fun    (FunType,NumArgs)
                | ValRet_Proc   (Maybe ProcessType,(NumArgs,NumArgs,NumArgs))
               deriving (Eq,Show) 
