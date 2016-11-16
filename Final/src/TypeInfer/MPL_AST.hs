{-# LANGUAGE DeriveGeneric #-}
module TypeInfer.MPL_AST where 

import Text.PrettyPrint.GenericPretty
import Text.PrettyPrint
import Data.List 

type MPL            = [Stmt]
type Process        = [ProcessCommand]

type PosnPair       = (Int,Int)
type TypeParam      = String
type ProtocolParam  = String
type EventHandleHPut= (String,String)
type TypeSynonym    = (Name,Type)
type Param          = String


type DataClause     = (DataName,[DataPhrase])
type DataPhrase     = (Name,FunType,NumArgs)

data DataName       = DataName (Name,[Param])
                     deriving (Eq,Show,Generic) 

instance () => Out (DataName)

type ProtocolClause = (ProtocolSpec,[ProtocolPhrase])
type ProtocolSpec   = (Name,[TypeParam],[ProtocolParam])
type ProtocolPhrase = (Name,Protocol)

type InfixSym       = String

type InputType      = [Type]
type OutputType     = Type

type ProcessType    = ([Type],[Protocol],[Protocol])

-- [String] is the list of existentially quantified variables.
data FunType        =  NoType 
                     | StrFType ([String],Type)
                     | IntFType ([Int],Type) 
                      deriving (Eq,Generic)  

instance () => Out (FunType)

instance Show FunType where
    show (StrFType (uvars,fType)) 
        = "forall {" ++ intercalate "," uvars ++ "}. " ++ show fType
    show (IntFType (uvars,fType)) 
        = "forall {" ++ intercalate "," (map (\x -> "V" ++ show x) uvars ) ++ "}. " ++ show fType
    show (NoType) 
        = "noType"
      
type PatternTermPhr = ([Pattern],Either Term [GuardedTerm])
type GuardedTerm    = (Term,Term)


type FoldPattern    = (Name,[Pattern],Term,PosnPair)
type ErrorMsg       = String
type NumArgs        = Int 


type PattProcessPhr = (
                        [Pattern],[PChannel],[PChannel],
                        Either GuardedProcPhrase Process
                      )

type GuardedProcPhrase  = (Term,Process)

type Name = String


data Protocol =  Get (Type,Protocol,PosnPair) 
               | Put (Type,Protocol,PosnPair)
               | Neg (Protocol,PosnPair)
               | Top PosnPair
               | Bot PosnPair
               | ProtNamed (String,([Type],[Protocol]),PosnPair)
               | ProtVar   (String,PosnPair)
               | ProtTensor (Protocol,Protocol,PosnPair)
               | ProtPar    (Protocol,Protocol,PosnPair)
               deriving (Eq,Show,Generic)

instance () => Out (Protocol)

data Type =  Unit PosnPair
           | TypeDataType (String,[Type],PosnPair)
           | TypeCodataType (String,[Type],PosnPair)
           | TypeProd ([Type],PosnPair)
           | TypeConst (BaseType,PosnPair)
           | TypeVar   (String,PosnPair)
           | TypeVarInt Int
           | TypeFun   ([Type],Type,PosnPair)
           deriving (Generic)


instance () => Out (Type)

instance Show Type where
  show (Unit _) = "Unit" 
  show (TypeVar (x,posn))
        = x 
  show (TypeVarInt n)
        = show n 
  show (TypeConst (btype,posn))
        = printConst btype
  show (TypeDataType (dname,types,posn))
        = case length types /= 0 of
              True ->
                 case dname == "List" of 
                     True  -> "[" ++ (intercalate ",".map show) types ++
                              "]"
                     False ->
                        dname ++ "(" ++ 
                        (intercalate ",".map show) types ++ ")"
              False ->
                 dname   
  show (TypeCodataType (cname,types,posn))
        = case length types /= 0 of
              True ->
                 case cname == "Exp" of 
                     True  -> 
                         "(" ++ show (head types) ++ "=>" 
                         ++ show (last types) ++ ")"
                     False ->
                         cname ++
                         "(" ++ (intercalate ",".map show) types ++ ")"
              False ->
                 cname 
  
  show (TypeProd (prods,posn))
        = "<" ++ intercalate "," (map show prods) ++ ">"


  show (TypeFun (ins,out,posn))
                      =  (intercalate ", " .map show) ins ++ 
                         "-> " ++ show out 


printConst :: BaseType -> String
printConst btype 
        = case btype of 
              BaseInt    -> "Int"
              BaseChar   -> "Char"
              BaseDouble -> "Double"
              BaseString -> "String"


instance Eq Type where
  Unit _ == Unit _ = True 

  TypeDataType (n1,t1,posn1) == TypeDataType (n2,t2,posn2)
          = (n1 == n2) && (and (zipWith (\x y -> x == y) t1 t2 ))

  TypeCodataType (n1,t1,posn1) == TypeCodataType (n2,t2,posn2)
          = (n1 == n2) && (and (zipWith (\x y -> x == y) t1 t2 ))
  
  TypeProd (t1s,posn1) == TypeProd (t2s,posn2) 
          = and (zipWith (\x y -> x == y) t1s t2s) 

  TypeConst (bt1,posn1) == TypeConst (bt2,posn2)
          = (bt1 == bt2) 
  
  TypeVar (v1,posn1) == TypeVar(v2,posn2)
          = v1 == v2 

  TypeVarInt v1 == TypeVarInt v2
          = v1 == v2 

  TypeFun (ins1,out1,posn1) == TypeFun (ins2,out2,posn2)
          = and (zipWith (\x y -> x == y) (out1:ins1) (out2:ins2))                                
  
  rem1 == rem2 = False 


data BaseType =  BaseInt 
               | BaseChar
               | BaseDouble
               | BaseString
               deriving (Eq,Show,Generic)

instance () => Out (BaseType)

data Pattern =   ConsPattern (String,[Pattern],PosnPair)
               | DestPattern (String,[Pattern],PosnPair)
               | ProdPattern ([Pattern],PosnPair)
               | VarPattern  (String,PosnPair)
               | StrConstPattern(String,PosnPair)
               | IntConstPattern(Int,PosnPair) 
               | DontCarePattern PosnPair 
               deriving (Eq,Show,Generic)

instance () => Out (Pattern)


data Term =  TRecord [(Pattern,Term,PosnPair)]
           | TCallFun (FuncName,[Term],PosnPair)  
           | TLet    (Term,[LetWhere],PosnPair)
           | TVar    (String,PosnPair)
           | TConst  (BaseVal,PosnPair)
           | TIf     (Term,Term,Term,PosnPair)
           | TCase   (Term,[PatternTermPhr],PosnPair)
           | TFold   (Term,[FoldPattern],PosnPair)
           | TUnfold (Term,FoldPattern,PosnPair)
           | TCons   (Name,[Term],PosnPair)
           | TDest   (Name,[Term],PosnPair)
           | TProd   ([Term],PosnPair)
           | TDefault PosnPair
          deriving (Eq,Show,Generic)

data LetWhere =   LetDefn Defn 
                | LetPatt (Pattern,Term)
                deriving (Eq,Show,Generic)

instance () => Out (LetWhere)

instance () => Out (Term)


data BaseVal =  ConstInt Int 
              | ConstChar Char 
              | ConstString String
              | ConstDouble Double  
              deriving (Eq,Show,Generic) 

instance () => Out (BaseVal)


data FuncName =   Custom  Name 
                | BuiltIn Func
                deriving  (Eq,Read,Generic)

instance Show FuncName where 
  show (Custom name) 
      = show name 
  show (BuiltIn func) 
      = show func 

instance () => Out (FuncName)


data ProcessCommand =  PRun   (Name,[Term],[PChannel],[PChannel],PosnPair)
                     | PClose (PChannel,PosnPair) 
                     | PHalt  (PChannel,PosnPair)
                     | PGet   (String,PChannel,PosnPair)
                     | PPut   (String,PChannel,PosnPair)
                     | PHPut  (EventHandleHPut,PChannel,PosnPair)
                     | PHCase (PChannel,[(EventHandleHPut,Process,PosnPair)])
                     | PSplit (PChannel,(PChannel,PChannel),PosnPair)
                     | PFork  (String,[(String,[PChannel],Process,PosnPair)])
                     | PPlug  [(Process,PosnPair)]
                     | PId    (PChannel,PChannel,PosnPair)
                     deriving (Eq,Show,Generic)

instance () => Out (ProcessCommand)

data Stmt =  DefnStmt ([Defn],[Stmt],PosnPair)
           | RunStmt (Maybe ProcessType,[PChannel],[PChannel],Process,PosnPair) 
           deriving (Eq,Show,Generic)

instance () => Out (Stmt)


type PChannel = String 
{-
data PChannel =  PosChan String
               | NegChan String
               deriving (Eq,Show,Generic)  
-}

{-
TERM_SYNONYTermSynonym    ::= TokTerm PIdent InfixRem PIdent "="
                                 PIdent "(" PIdent "," PIdent ")" ;
-}

type TermSynClause = (InfixDefn,InfixFun,PosnPair)
type InfixDefn = (String,String,String)
type InfixFun  = (String,String,String)



data Defn =   Data    ([DataClause],PosnPair)
            | Codata  ([DataClause],PosnPair)
            | TypeSyn ([TypeSynonym],PosnPair)   
            | ProtocolDefn   ([ProtocolClause],PosnPair)
            | CoprotocolDefn ([ProtocolClause],PosnPair)
            | FunctionDefn (FuncName,FunType,[(PatternTermPhr,PosnPair)],PosnPair)
            | ProcessDefn  (Name,Maybe ProcessType,[(PattProcessPhr,PosnPair)],PosnPair)
            | TermSyn TermSynClause
            | OperatorDefn (String,Either Int Int,PosnPair)

            deriving (Eq,Show,Generic)  
                
instance () => Out (Defn)

data Func =        Add_I
                 | Sub_I
                 | Mul_I 
                 | DivQ_I
                 | DivR_I 
                 | Eq_I
                 | Neq_I
                 | Leq_I
                 | Geq_I 
                 | LT_I
                 | GT_I
                 | Eq_C
                 | Eq_S
                 | Concat_S  
                 | Unstring_S 
                 | HeadString_S
                 | TailString_S
                 | Or_B
                 | And_B
                 deriving  (Eq,Show,Read,Generic)

instance () => Out (Func)
-- ================================================================================================
-- ================================================================================================
data TypeEqn =    TQuant (UniVars,ExistVars) [TypeEqn] 
                | TSimp  (Type,Type)
                deriving (Eq,Show,Generic)

instance () => Out (TypeEqn)

type FreeVars  = [Int] 
type UniVars   = [Int]
type ExistVar  = Int
type ExistVars = [Int]
type Package   = ((FreeVars,FreeVars),UniVars,ExistVars,SubstList)
type SubstList = [Subst]
type Subst     = (Int,Type)
type Log       = [String] 
type TypeThing = Int 

zigStyle :: Style
zigStyle = Style {mode = PageMode, lineLength = 90, ribbonsPerLine = 1.1}
