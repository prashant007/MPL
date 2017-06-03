module TypeInfer.SymTab_Init where

import TypeInfer.SymTab_DataType
import TypeInfer.MPL_AST


builtInFunList :: [Func]
builtInFunList 
        = [
           Add_I,Sub_I,Mul_I,DivQ_I,DivR_I,
           Ceq,Neq,Leq,Geq,Lt,Gt,Unstring,
           Or_B,And_B,Append,ToStr,ToInt
          ]
          
funcNameList :: [FuncName]
funcNameList = map BuiltIn builtInFunList 

toBeginSymTab :: SymbolTable
toBeginSymTab = [[symFun]]
     where
        symFun = mkSymbolDefns funcNameList


mkSymbolDefns :: [FuncName] -> SymbolDefn
mkSymbolDefns fnms 
        = SymFun (map makeSymTabThing fnms) 

makeSymTabThing :: FuncName -> (FuncName,(FunType,NumArgs))
makeSymTabThing fn@(BuiltIn func)
        = case func of 
              Add_I  ->
                  (fn,commIntFunTypes "intout")
              Sub_I  -> 
                  (fn,commIntFunTypes "intout")
              Mul_I  ->
                  (fn,commIntFunTypes "intout")
              DivQ_I -> 
                  (fn,commIntFunTypes "intout")
              DivR_I ->
                  (fn,commIntFunTypes "intout")
              Ceq   -> 
                  (fn,boolGenFunType)
              Neq  -> 
                  (fn,boolGenFunType)
              Leq  -> 
                  (fn,boolGenFunType)
              Geq  -> 
                  (fn,boolGenFunType)
              Lt  -> 
                  (fn,boolGenFunType)
              Gt   ->
                  (fn,boolGenFunType)

              Or_B  ->
                  (fn,commBoolFunTypes)
              And_B ->
                  (fn,commBoolFunTypes)

              ToStr ->
                  (fn,toStr_Type)

              ToInt ->
                  (fn,toInt_Type) 

              Append ->
                  (fn,append_Type) 

              Unstring ->
                  (fn,unstr_Type) 

intType :: Type 
intType = TypeConst (BaseInt,(0,0))



boolType :: Type 
boolType = TypeDataType ("Bool",[],(0,0))

listCharType :: Type 
listCharType = TypeDataType ("List",[charType],(0,0))

charType :: Type 
charType = TypeConst (BaseChar,(0,0))

stringType :: Type 
stringType = TypeConst (BaseString,(0,0))

varType :: Type
varType = TypeVar ("A",(0,0))


unstr_Type :: (FunType,NumArgs)
unstr_Type 
      =    ( 
               StrFType (
                          [],
                          TypeFun ([stringType],listCharType,(0,0))
                        ),
               1
            ) 

toInt_Type :: (FunType,NumArgs) 
toInt_Type 
      =    ( 
               StrFType (
                          ["A"],
                          TypeFun ([varType],intType,(0,0))
                         ),1
               
            ) 

toStr_Type :: (FunType,NumArgs) 
toStr_Type 
      =    ( 
               StrFType (
                          ["A"],
                          TypeFun ([varType],stringType,(0,0))
                         ),1
               
            ) 


append_Type :: (FunType,NumArgs) 
append_Type
      =    ( 
               StrFType (
                          ["A"],
                          TypeFun ([varType,varType],varType,(0,0))
                         ),2
               
            ) 

paramFun :: Type -> (FunType,NumArgs)
paramFun otype 
      =    ( 
               StrFType (
                          [],
                          TypeFun ([intType,intType],otype,(0,0))
                         ),
               2
            ) 


boolGenFunType :: (FunType,NumArgs) 
boolGenFunType =
           ( 
               StrFType (
                          ["A"],
                          TypeFun ([varType,varType],boolType,(0,0))
                         ),
               2
            ) 

commIntFunTypes :: String -> (FunType,NumArgs)
commIntFunTypes arg = 
      case arg of 
          "intout"  -> paramFun intType
          "boolout" -> paramFun boolType 
          otherwise -> error $ "Not valid type" ++ arg 




commCharFunTypes :: (FunType,NumArgs)
commCharFunTypes = ( 
                     StrFType (
                                [],
                                TypeFun ([charType,charType],boolType,(0,0))
                               ),
                     2
                  )  

concatStrFunType :: (FunType,NumArgs)
concatStrFunType
      =    ( 
               StrFType (
                          [],
                          TypeFun ([stringType,stringType],stringType,(0,0))
                         ),
               2
            ) 


eqSStrFunType :: (FunType,NumArgs)
eqSStrFunType
      =    ( 
               StrFType (
                          [],
                          TypeFun ([stringType,stringType],boolType,(0,0))
                         ),
               2
            ) 

commStrFunType :: String -> (FunType,NumArgs)
commStrFunType arg 
      = case arg of 
           "strout"  ->
               ( 
                   StrFType (
                              [],
                              TypeFun ([stringType],listCharType,(0,0))
                             ),
                   1
                ) 

           "charout" ->
               ( 
                   StrFType (
                              [],
                              TypeFun ([stringType],charType,(0,0))
                             ),
                   1
                ) 


commBoolFunTypes :: (FunType,NumArgs)
commBoolFunTypes
      =    ( 
               StrFType (
                          [],
                          TypeFun ([boolType,boolType],boolType,(0,0))
                         ),
               2
            ) 