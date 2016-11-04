{-# OPTIONS_GHC -w #-}
{-# OPTIONS -fglasgow-exts -cpp #-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParMPL where
import AbsMPL
import LexMPL
import ErrM
import qualified Data.Array as Happy_Data_Array
import qualified GHC.Exts as Happy_GHC_Exts
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

newtype HappyAbsSyn  = HappyAbsSyn HappyAny
#if __GLASGOW_HASKELL__ >= 607
type HappyAny = Happy_GHC_Exts.Any
#else
type HappyAny = forall a . a
#endif
happyIn93 :: (Integer) -> (HappyAbsSyn )
happyIn93 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn93 #-}
happyOut93 :: (HappyAbsSyn ) -> (Integer)
happyOut93 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut93 #-}
happyIn94 :: (Double) -> (HappyAbsSyn )
happyIn94 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn94 #-}
happyOut94 :: (HappyAbsSyn ) -> (Double)
happyOut94 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut94 #-}
happyIn95 :: (TokUnit) -> (HappyAbsSyn )
happyIn95 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn95 #-}
happyOut95 :: (HappyAbsSyn ) -> (TokUnit)
happyOut95 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut95 #-}
happyIn96 :: (TokDefn) -> (HappyAbsSyn )
happyIn96 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn96 #-}
happyOut96 :: (HappyAbsSyn ) -> (TokDefn)
happyOut96 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut96 #-}
happyIn97 :: (TokRun) -> (HappyAbsSyn )
happyIn97 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn97 #-}
happyOut97 :: (HappyAbsSyn ) -> (TokRun)
happyOut97 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut97 #-}
happyIn98 :: (TokTerm) -> (HappyAbsSyn )
happyIn98 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn98 #-}
happyOut98 :: (HappyAbsSyn ) -> (TokTerm)
happyOut98 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut98 #-}
happyIn99 :: (TokData) -> (HappyAbsSyn )
happyIn99 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn99 #-}
happyOut99 :: (HappyAbsSyn ) -> (TokData)
happyOut99 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut99 #-}
happyIn100 :: (TokCodata) -> (HappyAbsSyn )
happyIn100 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn100 #-}
happyOut100 :: (HappyAbsSyn ) -> (TokCodata)
happyOut100 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut100 #-}
happyIn101 :: (TokType) -> (HappyAbsSyn )
happyIn101 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn101 #-}
happyOut101 :: (HappyAbsSyn ) -> (TokType)
happyOut101 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut101 #-}
happyIn102 :: (TokProtocol) -> (HappyAbsSyn )
happyIn102 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn102 #-}
happyOut102 :: (HappyAbsSyn ) -> (TokProtocol)
happyOut102 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut102 #-}
happyIn103 :: (TokCoprotocol) -> (HappyAbsSyn )
happyIn103 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn103 #-}
happyOut103 :: (HappyAbsSyn ) -> (TokCoprotocol)
happyOut103 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut103 #-}
happyIn104 :: (TokGetProt) -> (HappyAbsSyn )
happyIn104 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn104 #-}
happyOut104 :: (HappyAbsSyn ) -> (TokGetProt)
happyOut104 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut104 #-}
happyIn105 :: (TokPutProt) -> (HappyAbsSyn )
happyIn105 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn105 #-}
happyOut105 :: (HappyAbsSyn ) -> (TokPutProt)
happyOut105 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut105 #-}
happyIn106 :: (TokNeg) -> (HappyAbsSyn )
happyIn106 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn106 #-}
happyOut106 :: (HappyAbsSyn ) -> (TokNeg)
happyOut106 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut106 #-}
happyIn107 :: (TokTop) -> (HappyAbsSyn )
happyIn107 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn107 #-}
happyOut107 :: (HappyAbsSyn ) -> (TokTop)
happyOut107 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut107 #-}
happyIn108 :: (TokBot) -> (HappyAbsSyn )
happyIn108 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn108 #-}
happyOut108 :: (HappyAbsSyn ) -> (TokBot)
happyOut108 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut108 #-}
happyIn109 :: (TokFun) -> (HappyAbsSyn )
happyIn109 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn109 #-}
happyOut109 :: (HappyAbsSyn ) -> (TokFun)
happyOut109 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut109 #-}
happyIn110 :: (TokDefault) -> (HappyAbsSyn )
happyIn110 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn110 #-}
happyOut110 :: (HappyAbsSyn ) -> (TokDefault)
happyOut110 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut110 #-}
happyIn111 :: (TokRecord) -> (HappyAbsSyn )
happyIn111 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn111 #-}
happyOut111 :: (HappyAbsSyn ) -> (TokRecord)
happyOut111 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut111 #-}
happyIn112 :: (TokLet) -> (HappyAbsSyn )
happyIn112 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn112 #-}
happyOut112 :: (HappyAbsSyn ) -> (TokLet)
happyOut112 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut112 #-}
happyIn113 :: (TokIf) -> (HappyAbsSyn )
happyIn113 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn113 #-}
happyOut113 :: (HappyAbsSyn ) -> (TokIf)
happyOut113 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut113 #-}
happyIn114 :: (TokFold) -> (HappyAbsSyn )
happyIn114 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn114 #-}
happyOut114 :: (HappyAbsSyn ) -> (TokFold)
happyOut114 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut114 #-}
happyIn115 :: (TokUnfold) -> (HappyAbsSyn )
happyIn115 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn115 #-}
happyOut115 :: (HappyAbsSyn ) -> (TokUnfold)
happyOut115 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut115 #-}
happyIn116 :: (TokCase) -> (HappyAbsSyn )
happyIn116 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn116 #-}
happyOut116 :: (HappyAbsSyn ) -> (TokCase)
happyOut116 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut116 #-}
happyIn117 :: (TokProc) -> (HappyAbsSyn )
happyIn117 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn117 #-}
happyOut117 :: (HappyAbsSyn ) -> (TokProc)
happyOut117 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut117 #-}
happyIn118 :: (TokClose) -> (HappyAbsSyn )
happyIn118 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn118 #-}
happyOut118 :: (HappyAbsSyn ) -> (TokClose)
happyOut118 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut118 #-}
happyIn119 :: (TokHalt) -> (HappyAbsSyn )
happyIn119 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn119 #-}
happyOut119 :: (HappyAbsSyn ) -> (TokHalt)
happyOut119 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut119 #-}
happyIn120 :: (TokGet) -> (HappyAbsSyn )
happyIn120 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn120 #-}
happyOut120 :: (HappyAbsSyn ) -> (TokGet)
happyOut120 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut120 #-}
happyIn121 :: (TokPut) -> (HappyAbsSyn )
happyIn121 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn121 #-}
happyOut121 :: (HappyAbsSyn ) -> (TokPut)
happyOut121 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut121 #-}
happyIn122 :: (TokHCase) -> (HappyAbsSyn )
happyIn122 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn122 #-}
happyOut122 :: (HappyAbsSyn ) -> (TokHCase)
happyOut122 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut122 #-}
happyIn123 :: (TokHPut) -> (HappyAbsSyn )
happyIn123 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn123 #-}
happyOut123 :: (HappyAbsSyn ) -> (TokHPut)
happyOut123 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut123 #-}
happyIn124 :: (TokSplit) -> (HappyAbsSyn )
happyIn124 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn124 #-}
happyOut124 :: (HappyAbsSyn ) -> (TokSplit)
happyOut124 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut124 #-}
happyIn125 :: (TokFork) -> (HappyAbsSyn )
happyIn125 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn125 #-}
happyOut125 :: (HappyAbsSyn ) -> (TokFork)
happyOut125 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut125 #-}
happyIn126 :: (TokDCare) -> (HappyAbsSyn )
happyIn126 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn126 #-}
happyOut126 :: (HappyAbsSyn ) -> (TokDCare)
happyOut126 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut126 #-}
happyIn127 :: (TokString) -> (HappyAbsSyn )
happyIn127 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn127 #-}
happyOut127 :: (HappyAbsSyn ) -> (TokString)
happyOut127 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut127 #-}
happyIn128 :: (UIdent) -> (HappyAbsSyn )
happyIn128 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn128 #-}
happyOut128 :: (HappyAbsSyn ) -> (UIdent)
happyOut128 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut128 #-}
happyIn129 :: (PIdent) -> (HappyAbsSyn )
happyIn129 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn129 #-}
happyOut129 :: (HappyAbsSyn ) -> (PIdent)
happyOut129 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut129 #-}
happyIn130 :: (InfixRem) -> (HappyAbsSyn )
happyIn130 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn130 #-}
happyOut130 :: (HappyAbsSyn ) -> (InfixRem)
happyOut130 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut130 #-}
happyIn131 :: (PInteger) -> (HappyAbsSyn )
happyIn131 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn131 #-}
happyOut131 :: (HappyAbsSyn ) -> (PInteger)
happyOut131 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut131 #-}
happyIn132 :: (MPL) -> (HappyAbsSyn )
happyIn132 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn132 #-}
happyOut132 :: (HappyAbsSyn ) -> (MPL)
happyOut132 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut132 #-}
happyIn133 :: ([MPLstmt]) -> (HappyAbsSyn )
happyIn133 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn133 #-}
happyOut133 :: (HappyAbsSyn ) -> ([MPLstmt])
happyOut133 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut133 #-}
happyIn134 :: (MPLstmt) -> (HappyAbsSyn )
happyIn134 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn134 #-}
happyOut134 :: (HappyAbsSyn ) -> (MPLstmt)
happyOut134 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut134 #-}
happyIn135 :: (MPLstmtAlt) -> (HappyAbsSyn )
happyIn135 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn135 #-}
happyOut135 :: (HappyAbsSyn ) -> (MPLstmtAlt)
happyOut135 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut135 #-}
happyIn136 :: ([MPLstmtAlt]) -> (HappyAbsSyn )
happyIn136 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn136 #-}
happyOut136 :: (HappyAbsSyn ) -> ([MPLstmtAlt])
happyOut136 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut136 #-}
happyIn137 :: (RUNstmt) -> (HappyAbsSyn )
happyIn137 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn137 #-}
happyOut137 :: (HappyAbsSyn ) -> (RUNstmt)
happyOut137 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut137 #-}
happyIn138 :: ([Defn]) -> (HappyAbsSyn )
happyIn138 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn138 #-}
happyOut138 :: (HappyAbsSyn ) -> ([Defn])
happyOut138 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut138 #-}
happyIn139 :: (Defn) -> (HappyAbsSyn )
happyIn139 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn139 #-}
happyOut139 :: (HappyAbsSyn ) -> (Defn)
happyOut139 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut139 #-}
happyIn140 :: (OperatorDefn) -> (HappyAbsSyn )
happyIn140 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn140 #-}
happyOut140 :: (HappyAbsSyn ) -> (OperatorDefn)
happyOut140 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut140 #-}
happyIn141 :: (TermSynonym) -> (HappyAbsSyn )
happyIn141 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn141 #-}
happyOut141 :: (HappyAbsSyn ) -> (TermSynonym)
happyOut141 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut141 #-}
happyIn142 :: (TypeDefn) -> (HappyAbsSyn )
happyIn142 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn142 #-}
happyOut142 :: (HappyAbsSyn ) -> (TypeDefn)
happyOut142 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut142 #-}
happyIn143 :: ([DataClause]) -> (HappyAbsSyn )
happyIn143 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn143 #-}
happyOut143 :: (HappyAbsSyn ) -> ([DataClause])
happyOut143 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut143 #-}
happyIn144 :: ([CoDataClause]) -> (HappyAbsSyn )
happyIn144 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn144 #-}
happyOut144 :: (HappyAbsSyn ) -> ([CoDataClause])
happyOut144 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut144 #-}
happyIn145 :: ([TypeSpec]) -> (HappyAbsSyn )
happyIn145 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn145 #-}
happyOut145 :: (HappyAbsSyn ) -> ([TypeSpec])
happyOut145 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut145 #-}
happyIn146 :: (DataClause) -> (HappyAbsSyn )
happyIn146 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn146 #-}
happyOut146 :: (HappyAbsSyn ) -> (DataClause)
happyOut146 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut146 #-}
happyIn147 :: (CoDataClause) -> (HappyAbsSyn )
happyIn147 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn147 #-}
happyOut147 :: (HappyAbsSyn ) -> (CoDataClause)
happyOut147 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut147 #-}
happyIn148 :: ([DataPhrase]) -> (HappyAbsSyn )
happyIn148 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn148 #-}
happyOut148 :: (HappyAbsSyn ) -> ([DataPhrase])
happyOut148 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut148 #-}
happyIn149 :: ([CoDataPhrase]) -> (HappyAbsSyn )
happyIn149 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn149 #-}
happyOut149 :: (HappyAbsSyn ) -> ([CoDataPhrase])
happyOut149 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut149 #-}
happyIn150 :: (DataPhrase) -> (HappyAbsSyn )
happyIn150 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn150 #-}
happyOut150 :: (HappyAbsSyn ) -> (DataPhrase)
happyOut150 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut150 #-}
happyIn151 :: (CoDataPhrase) -> (HappyAbsSyn )
happyIn151 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn151 #-}
happyOut151 :: (HappyAbsSyn ) -> (CoDataPhrase)
happyOut151 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut151 #-}
happyIn152 :: ([Structor]) -> (HappyAbsSyn )
happyIn152 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn152 #-}
happyOut152 :: (HappyAbsSyn ) -> ([Structor])
happyOut152 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut152 #-}
happyIn153 :: ([Type]) -> (HappyAbsSyn )
happyIn153 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn153 #-}
happyOut153 :: (HappyAbsSyn ) -> ([Type])
happyOut153 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut153 #-}
happyIn154 :: (Structor) -> (HappyAbsSyn )
happyIn154 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn154 #-}
happyOut154 :: (HappyAbsSyn ) -> (Structor)
happyOut154 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut154 #-}
happyIn155 :: (TypeSpec) -> (HappyAbsSyn )
happyIn155 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn155 #-}
happyOut155 :: (HappyAbsSyn ) -> (TypeSpec)
happyOut155 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut155 #-}
happyIn156 :: ([TypeParam]) -> (HappyAbsSyn )
happyIn156 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn156 #-}
happyOut156 :: (HappyAbsSyn ) -> ([TypeParam])
happyOut156 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut156 #-}
happyIn157 :: (TypeParam) -> (HappyAbsSyn )
happyIn157 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn157 #-}
happyOut157 :: (HappyAbsSyn ) -> (TypeParam)
happyOut157 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut157 #-}
happyIn158 :: (Type) -> (HappyAbsSyn )
happyIn158 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn158 #-}
happyOut158 :: (HappyAbsSyn ) -> (Type)
happyOut158 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut158 #-}
happyIn159 :: (TypeN) -> (HappyAbsSyn )
happyIn159 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn159 #-}
happyOut159 :: (HappyAbsSyn ) -> (TypeN)
happyOut159 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut159 #-}
happyIn160 :: ([TypeN]) -> (HappyAbsSyn )
happyIn160 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn160 #-}
happyOut160 :: (HappyAbsSyn ) -> ([TypeN])
happyOut160 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut160 #-}
happyIn161 :: ([UIdent]) -> (HappyAbsSyn )
happyIn161 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn161 #-}
happyOut161 :: (HappyAbsSyn ) -> ([UIdent])
happyOut161 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut161 #-}
happyIn162 :: (CTypeDefn) -> (HappyAbsSyn )
happyIn162 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn162 #-}
happyOut162 :: (HappyAbsSyn ) -> (CTypeDefn)
happyOut162 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut162 #-}
happyIn163 :: ([ProtocolClause]) -> (HappyAbsSyn )
happyIn163 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn163 #-}
happyOut163 :: (HappyAbsSyn ) -> ([ProtocolClause])
happyOut163 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut163 #-}
happyIn164 :: ([CoProtocolClause]) -> (HappyAbsSyn )
happyIn164 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn164 #-}
happyOut164 :: (HappyAbsSyn ) -> ([CoProtocolClause])
happyOut164 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut164 #-}
happyIn165 :: (ProtocolClause) -> (HappyAbsSyn )
happyIn165 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn165 #-}
happyOut165 :: (HappyAbsSyn ) -> (ProtocolClause)
happyOut165 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut165 #-}
happyIn166 :: (CoProtocolClause) -> (HappyAbsSyn )
happyIn166 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn166 #-}
happyOut166 :: (HappyAbsSyn ) -> (CoProtocolClause)
happyOut166 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut166 #-}
happyIn167 :: ([ProtocolPhrase]) -> (HappyAbsSyn )
happyIn167 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn167 #-}
happyOut167 :: (HappyAbsSyn ) -> ([ProtocolPhrase])
happyOut167 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut167 #-}
happyIn168 :: ([CoProtocolPhrase]) -> (HappyAbsSyn )
happyIn168 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn168 #-}
happyOut168 :: (HappyAbsSyn ) -> ([CoProtocolPhrase])
happyOut168 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut168 #-}
happyIn169 :: (ProtocolTypeSpec) -> (HappyAbsSyn )
happyIn169 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn169 #-}
happyOut169 :: (HappyAbsSyn ) -> (ProtocolTypeSpec)
happyOut169 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut169 #-}
happyIn170 :: ([ProtocolParam]) -> (HappyAbsSyn )
happyIn170 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn170 #-}
happyOut170 :: (HappyAbsSyn ) -> ([ProtocolParam])
happyOut170 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut170 #-}
happyIn171 :: (ProtocolParam) -> (HappyAbsSyn )
happyIn171 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn171 #-}
happyOut171 :: (HappyAbsSyn ) -> (ProtocolParam)
happyOut171 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut171 #-}
happyIn172 :: (ProtocolPhrase) -> (HappyAbsSyn )
happyIn172 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn172 #-}
happyOut172 :: (HappyAbsSyn ) -> (ProtocolPhrase)
happyOut172 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut172 #-}
happyIn173 :: (CoProtocolPhrase) -> (HappyAbsSyn )
happyIn173 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn173 #-}
happyOut173 :: (HappyAbsSyn ) -> (CoProtocolPhrase)
happyOut173 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut173 #-}
happyIn174 :: ([EventHandle]) -> (HappyAbsSyn )
happyIn174 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn174 #-}
happyOut174 :: (HappyAbsSyn ) -> ([EventHandle])
happyOut174 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut174 #-}
happyIn175 :: (EventHandle) -> (HappyAbsSyn )
happyIn175 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn175 #-}
happyOut175 :: (HappyAbsSyn ) -> (EventHandle)
happyOut175 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut175 #-}
happyIn176 :: (EventHandleHPUT) -> (HappyAbsSyn )
happyIn176 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn176 #-}
happyOut176 :: (HappyAbsSyn ) -> (EventHandleHPUT)
happyOut176 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut176 #-}
happyIn177 :: (Protocol) -> (HappyAbsSyn )
happyIn177 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn177 #-}
happyOut177 :: (HappyAbsSyn ) -> (Protocol)
happyOut177 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut177 #-}
happyIn178 :: (Protocol) -> (HappyAbsSyn )
happyIn178 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn178 #-}
happyOut178 :: (HappyAbsSyn ) -> (Protocol)
happyOut178 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut178 #-}
happyIn179 :: (Protocol) -> (HappyAbsSyn )
happyIn179 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn179 #-}
happyOut179 :: (HappyAbsSyn ) -> (Protocol)
happyOut179 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut179 #-}
happyIn180 :: ([Protocol]) -> (HappyAbsSyn )
happyIn180 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn180 #-}
happyOut180 :: (HappyAbsSyn ) -> ([Protocol])
happyOut180 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut180 #-}
happyIn181 :: (FunctionDefn) -> (HappyAbsSyn )
happyIn181 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn181 #-}
happyOut181 :: (HappyAbsSyn ) -> (FunctionDefn)
happyOut181 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut181 #-}
happyIn182 :: ([FunctionDefn]) -> (HappyAbsSyn )
happyIn182 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn182 #-}
happyOut182 :: (HappyAbsSyn ) -> ([FunctionDefn])
happyOut182 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut182 #-}
happyIn183 :: ([PattTermPharse]) -> (HappyAbsSyn )
happyIn183 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn183 #-}
happyOut183 :: (HappyAbsSyn ) -> ([PattTermPharse])
happyOut183 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut183 #-}
happyIn184 :: ([PIdent]) -> (HappyAbsSyn )
happyIn184 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn184 #-}
happyOut184 :: (HappyAbsSyn ) -> ([PIdent])
happyOut184 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut184 #-}
happyIn185 :: (FoldPattern) -> (HappyAbsSyn )
happyIn185 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn185 #-}
happyOut185 :: (HappyAbsSyn ) -> (FoldPattern)
happyOut185 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut185 #-}
happyIn186 :: ([FoldPattern]) -> (HappyAbsSyn )
happyIn186 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn186 #-}
happyOut186 :: (HappyAbsSyn ) -> ([FoldPattern])
happyOut186 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut186 #-}
happyIn187 :: (PattTermPharse) -> (HappyAbsSyn )
happyIn187 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn187 #-}
happyOut187 :: (HappyAbsSyn ) -> (PattTermPharse)
happyOut187 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut187 #-}
happyIn188 :: ([GuardedTerm]) -> (HappyAbsSyn )
happyIn188 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn188 #-}
happyOut188 :: (HappyAbsSyn ) -> ([GuardedTerm])
happyOut188 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut188 #-}
happyIn189 :: (GuardedTerm) -> (HappyAbsSyn )
happyIn189 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn189 #-}
happyOut189 :: (HappyAbsSyn ) -> (GuardedTerm)
happyOut189 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut189 #-}
happyIn190 :: ([Pattern]) -> (HappyAbsSyn )
happyIn190 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn190 #-}
happyOut190 :: (HappyAbsSyn ) -> ([Pattern])
happyOut190 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut190 #-}
happyIn191 :: (Pattern) -> (HappyAbsSyn )
happyIn191 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn191 #-}
happyOut191 :: (HappyAbsSyn ) -> (Pattern)
happyOut191 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut191 #-}
happyIn192 :: (Pattern) -> (HappyAbsSyn )
happyIn192 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn192 #-}
happyOut192 :: (HappyAbsSyn ) -> (Pattern)
happyOut192 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut192 #-}
happyIn193 :: (Term) -> (HappyAbsSyn )
happyIn193 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn193 #-}
happyOut193 :: (HappyAbsSyn ) -> (Term)
happyOut193 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut193 #-}
happyIn194 :: (Term) -> (HappyAbsSyn )
happyIn194 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn194 #-}
happyOut194 :: (HappyAbsSyn ) -> (Term)
happyOut194 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut194 #-}
happyIn195 :: (Term) -> (HappyAbsSyn )
happyIn195 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn195 #-}
happyOut195 :: (HappyAbsSyn ) -> (Term)
happyOut195 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut195 #-}
happyIn196 :: ([RecordEntry]) -> (HappyAbsSyn )
happyIn196 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn196 #-}
happyOut196 :: (HappyAbsSyn ) -> ([RecordEntry])
happyOut196 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut196 #-}
happyIn197 :: ([RecordEntryAlt]) -> (HappyAbsSyn )
happyIn197 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn197 #-}
happyOut197 :: (HappyAbsSyn ) -> ([RecordEntryAlt])
happyOut197 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut197 #-}
happyIn198 :: ([Term]) -> (HappyAbsSyn )
happyIn198 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn198 #-}
happyOut198 :: (HappyAbsSyn ) -> ([Term])
happyOut198 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut198 #-}
happyIn199 :: ([Term]) -> (HappyAbsSyn )
happyIn199 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn199 #-}
happyOut199 :: (HappyAbsSyn ) -> ([Term])
happyOut199 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut199 #-}
happyIn200 :: (ConstantType) -> (HappyAbsSyn )
happyIn200 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn200 #-}
happyOut200 :: (HappyAbsSyn ) -> (ConstantType)
happyOut200 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut200 #-}
happyIn201 :: (RecordEntryAlt) -> (HappyAbsSyn )
happyIn201 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn201 #-}
happyOut201 :: (HappyAbsSyn ) -> (RecordEntryAlt)
happyOut201 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut201 #-}
happyIn202 :: (RecordEntry) -> (HappyAbsSyn )
happyIn202 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn202 #-}
happyOut202 :: (HappyAbsSyn ) -> (RecordEntry)
happyOut202 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut202 #-}
happyIn203 :: (ProcessDef) -> (HappyAbsSyn )
happyIn203 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn203 #-}
happyOut203 :: (HappyAbsSyn ) -> (ProcessDef)
happyOut203 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut203 #-}
happyIn204 :: ([PatProcessPhr]) -> (HappyAbsSyn )
happyIn204 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn204 #-}
happyOut204 :: (HappyAbsSyn ) -> ([PatProcessPhr])
happyOut204 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut204 #-}
happyIn205 :: (PatProcessPhr) -> (HappyAbsSyn )
happyIn205 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn205 #-}
happyOut205 :: (HappyAbsSyn ) -> (PatProcessPhr)
happyOut205 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut205 #-}
happyIn206 :: ([Channel]) -> (HappyAbsSyn )
happyIn206 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn206 #-}
happyOut206 :: (HappyAbsSyn ) -> ([Channel])
happyOut206 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut206 #-}
happyIn207 :: (Process) -> (HappyAbsSyn )
happyIn207 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn207 #-}
happyOut207 :: (HappyAbsSyn ) -> (Process)
happyOut207 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut207 #-}
happyIn208 :: ([ProcessCommand]) -> (HappyAbsSyn )
happyIn208 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn208 #-}
happyOut208 :: (HappyAbsSyn ) -> ([ProcessCommand])
happyOut208 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut208 #-}
happyIn209 :: (ProcessCommand) -> (HappyAbsSyn )
happyIn209 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn209 #-}
happyOut209 :: (HappyAbsSyn ) -> (ProcessCommand)
happyOut209 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut209 #-}
happyIn210 :: (PlugPart) -> (HappyAbsSyn )
happyIn210 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn210 #-}
happyOut210 :: (HappyAbsSyn ) -> (PlugPart)
happyOut210 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut210 #-}
happyIn211 :: ([PlugPart]) -> (HappyAbsSyn )
happyIn211 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn211 #-}
happyOut211 :: (HappyAbsSyn ) -> ([PlugPart])
happyOut211 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut211 #-}
happyIn212 :: ([ForkPart]) -> (HappyAbsSyn )
happyIn212 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn212 #-}
happyOut212 :: (HappyAbsSyn ) -> ([ForkPart])
happyOut212 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut212 #-}
happyIn213 :: (ForkPart) -> (HappyAbsSyn )
happyIn213 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn213 #-}
happyOut213 :: (HappyAbsSyn ) -> (ForkPart)
happyOut213 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut213 #-}
happyIn214 :: ([Handler]) -> (HappyAbsSyn )
happyIn214 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn214 #-}
happyOut214 :: (HappyAbsSyn ) -> ([Handler])
happyOut214 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut214 #-}
happyIn215 :: (Handler) -> (HappyAbsSyn )
happyIn215 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn215 #-}
happyOut215 :: (HappyAbsSyn ) -> (Handler)
happyOut215 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut215 #-}
happyIn216 :: ([ProcessPhrase]) -> (HappyAbsSyn )
happyIn216 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn216 #-}
happyOut216 :: (HappyAbsSyn ) -> ([ProcessPhrase])
happyOut216 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut216 #-}
happyIn217 :: (ProcessPhrase) -> (HappyAbsSyn )
happyIn217 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn217 #-}
happyOut217 :: (HappyAbsSyn ) -> (ProcessPhrase)
happyOut217 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut217 #-}
happyIn218 :: ([GuardProcessPhrase]) -> (HappyAbsSyn )
happyIn218 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn218 #-}
happyOut218 :: (HappyAbsSyn ) -> ([GuardProcessPhrase])
happyOut218 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut218 #-}
happyIn219 :: (GuardProcessPhrase) -> (HappyAbsSyn )
happyIn219 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn219 #-}
happyOut219 :: (HappyAbsSyn ) -> (GuardProcessPhrase)
happyOut219 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut219 #-}
happyIn220 :: (PChannel) -> (HappyAbsSyn )
happyIn220 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn220 #-}
happyOut220 :: (HappyAbsSyn ) -> (PChannel)
happyOut220 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut220 #-}
happyIn221 :: (Channel) -> (HappyAbsSyn )
happyIn221 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn221 #-}
happyOut221 :: (HappyAbsSyn ) -> (Channel)
happyOut221 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut221 #-}
happyInTok :: (Token) -> (HappyAbsSyn )
happyInTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> (Token)
happyOutTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOutTok #-}


happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x00\x00\x00\x00\x40\x09\x40\x09\x40\x09\x08\x09\x4d\x09\x4d\x09\x84\x03\x06\x09\x10\x04\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xbb\x03\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xbb\x03\xba\x03\xba\x03\xe5\x08\x2a\x02\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xe5\x08\xa9\x01\xa9\x01\xa9\x01\xa9\x01\xf5\x08\xf5\x08\x0f\x04\xe3\x08\xe0\x08\xe0\x08\x0f\x04\x59\x07\x59\x07\x0f\x04\x0f\x04\x0f\x04\x60\x07\x9e\x07\x9e\x07\xe0\x08\xe0\x08\x60\x07\x9e\x07\x3e\x02\xe0\x08\xe0\x08\xe7\x08\xf8\x03\x0f\x04\xdd\x08\x1b\x09\x11\x09\x11\x09\x05\x09\x05\x09\xd7\x08\xd7\x08\xd6\x08\xd6\x08\x30\x02\x0f\x04\x59\x07\x59\x07\x3f\x01\xcf\x08\xf0\x08\x00\x00\x00\x00\xd0\x08\x00\x00\x00\x00\xd0\x08\xc9\x08\x00\x00\x07\x09\xee\x08\x60\x07\x60\x07\xb0\x08\xb0\x08\x60\x07\x00\x00\x02\x09\xf6\x08\x00\x00\xe8\x08\x00\x00\xaa\x08\x00\x00\x9f\x08\x60\x07\xa1\x08\x60\x07\x9e\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9c\x08\xdc\x08\x00\x00\x00\x00\xe6\x08\x00\x00\x00\x00\xda\x08\xdf\x08\xdb\x08\x95\x08\x0f\x04\x0f\x04\x00\x00\x95\x08\xd1\x08\xd8\x08\xd5\x08\x8c\x08\x8c\x08\xcc\x08\x74\x00\x88\x08\x88\x08\xc3\x08\x60\x07\x84\x08\x84\x08\x84\x08\x60\x07\x84\x08\x82\x08\x80\x08\x80\x08\xc6\x08\x00\x00\xba\x08\x78\x08\xb3\x08\x97\x08\x96\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6b\x08\x6b\x08\x6b\x08\xab\x08\x67\x08\xf9\x08\x67\x08\xac\x08\x76\x08\x66\x08\x66\x08\x91\x08\x54\x08\x64\x08\x00\x00\x94\x08\x5f\x08\x5f\x08\x00\x00\x5f\x08\x8e\x08\x59\x08\x8d\x08\x53\x08\x53\x08\x8a\x08\x4f\x08\x83\x08\x41\x08\x41\x08\x41\x08\x41\x08\x41\x08\x41\x08\x7f\x08\x3e\x08\x7c\x08\x3c\x08\x77\x08\x37\x08\x7b\x08\x73\x08\x68\x08\x24\x08\x24\x08\x65\x08\x0b\x08\x0b\x08\x51\x08\x09\x08\x4e\x08\x02\x08\x00\x00\x02\x08\x4d\x08\x48\x08\x47\x08\x00\x00\x00\x00\x45\x08\xc5\x03\x43\x08\x00\x00\xf7\x07\xa9\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf7\x07\x6e\x00\x7f\x00\xf7\x07\x00\x00\xf7\x07\xf7\x07\x3b\x08\xe7\x07\x28\x08\xe2\x07\x23\x08\x00\x00\xdb\x07\xdb\x07\x1e\x08\x21\x08\xcb\x07\xcb\x07\x07\x08\xc5\x07\x05\x08\xf5\x07\xb5\x07\xb5\x07\xc1\x07\xb1\x07\xe4\x07\xb0\x07\xe3\x07\x8d\x07\x8d\x07\x82\x07\x00\x00\x00\x00\xc4\x07\x7a\x07\x00\x00\xc7\x07\xbe\x07\x76\x07\xba\x03\xba\x03\x00\x00\x76\x07\x76\x07\x00\x00\xba\x03\x00\x00\x76\x07\x76\x07\xbc\x07\xc0\x07\x73\x07\x00\x00\x73\x07\x73\x07\xb6\x07\x6e\x07\xa9\x07\x61\x07\xa2\x07\x5a\x07\x9b\x07\x57\x07\x94\x07\x4a\x07\x83\x07\x87\x07\x38\x07\x38\x07\x78\x07\x26\x07\x64\x07\x15\x07\x48\x07\x08\x07\x42\x07\x0b\x07\x0b\x07\x0b\x07\x05\x07\x00\x00\x00\x00\x00\x00\xfa\x06\x04\x07\x00\x00\x04\x07\x02\x07\x02\x07\xf6\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf6\x06\x2b\x07\x89\x00\xf0\x06\x00\x00\x11\x07\x00\x00\x1f\x07\xd5\x06\x00\x00\x00\x00\xd5\x06\xd5\x06\x92\x08\xd5\x06\x34\x09\x00\x00\x00\x00\x40\x09\xf7\x06\x03\x07\xa9\x01\x4d\x09\xeb\x06\x00\x00\xeb\x06\xce\x06\xfb\x06\x00\x00\x00\x00\xc5\x06\xc5\x06\xc5\x06\xc5\x06\xc5\x06\xc5\x06\xc5\x06\x4a\x03\x4a\x03\xc5\x06\x4a\x03\xc5\x06\xc5\x06\x0b\x00\xf9\x06\xf4\x06\x01\x07\x40\x03\x1e\x03\xb1\x06\x00\x00\x00\x00\xb1\x06\xb1\x06\xb1\x06\xb1\x06\xb1\x06\xb1\x06\xb1\x06\xb1\x06\xa9\x01\xb1\x06\xb1\x06\xa9\x01\xa9\x01\xd5\x03\xa9\x01\x1e\x03\xa9\x01\x1e\x03\x1e\x03\xc7\x06\x4b\x03\x0f\x04\xa7\x06\x9e\x06\x99\x06\x41\x07\x0f\x07\xc8\x06\xc6\x06\x9b\x06\x9b\x06\x60\x07\x9e\x07\x97\x06\x35\x03\xd3\x03\x97\x06\x97\x06\x00\x00\xb8\x06\x11\x09\xc8\x08\x11\x09\x3f\x01\xc8\x08\x60\x07\xc4\x06\xc0\x06\xb5\x06\xa3\x06\xaa\x06\xa6\x06\x00\x00\x00\x00\xa2\x06\x6e\x06\x00\x00\x6e\x06\x6c\x06\x00\x00\x6c\x06\x76\x03\xa1\x06\xa9\x06\x0f\x04\x0f\x04\x00\x00\xbc\x08\x0f\x04\x0f\x07\x9a\x06\x90\x06\x8a\x06\xc0\x02\x9e\x07\x74\x06\x60\x07\x60\x07\x6d\x06\x63\x06\x67\x06\x57\x06\x55\x06\x1d\x06\x46\x06\x00\x00\x11\x09\x2f\x06\x2c\x06\x60\x07\x27\x06\x26\x06\x24\x06\x40\x06\x3b\x06\x11\x09\x00\x00\x00\x00\x60\x07\x00\x00\x00\x00\x00\x00\x00\x00\x36\x06\x17\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x06\x00\x00\x15\x06\xe1\x05\xe1\x05\x03\x06\xc6\x05\xc6\x05\xde\x05\xdb\x05\x00\x00\x00\x00\xe2\x05\xd9\x05\x00\x00\x11\x09\x00\x00\xee\x05\x00\x00\x1e\x03\xcc\x05\xda\x05\x00\x00\x00\x00\x00\x00\x00\x00\x60\x07\x60\x07\x00\x00\x00\x00\xc8\x05\xcb\x05\x00\x00\x00\x00\x00\x00\x1e\x03\xbb\x05\x00\x00\xb1\x05\xaf\x05\x28\x03\xac\x05\x00\x00\x00\x00\x00\x00\xd0\x05\x00\x00\xc0\x05\x41\x03\x00\x00\xaa\x05\x00\x00\x00\x00\xb6\x05\x9d\x05\x00\x00\x00\x00\x00\x00\xbc\x05\x00\x00\x00\x00\x00\x00\x1d\x03\x00\x00\xba\x05\x00\x00\x00\x00\xa2\x05\x89\x05\x00\x00\x00\x00\x91\x05\x81\x05\x00\x00\x00\x00\x00\x00\x59\x05\x35\x05\x00\x00\x00\x00\x00\x00\x6e\x05\x31\x05\x4d\x09\x00\x00\x51\x05\x6d\x05\xa9\x01\x65\x05\xb1\x02\x37\x05\x32\x05\x0a\x05\xb1\x02\x00\x00\x4d\x05\x00\x00\x25\x05\x24\x05\xed\x04\xed\x04\xa9\x01\xa9\x01\x00\x00\xa9\x01\xa9\x01\x0f\x04\x2e\x05\xf8\x04\x0f\x07\x0c\x05\xfe\x04\x07\x05\x34\x06\xf0\x04\xc9\x04\xea\x04\x00\x00\x00\x00\xc4\x04\xc4\x04\x00\x00\x00\x00\xbd\x04\x00\x00\x00\x00\xc5\x05\x00\x00\x0f\x07\x00\x00\xff\x04\xd9\x04\x00\x00\x00\x00\x0f\x04\xa6\x04\xa6\x04\xc3\x04\x4d\x09\x00\x00\xd8\x04\x00\x00\xd3\x04\xaa\x04\xcc\x04\xcb\x04\xbc\x04\x00\x00\x00\x00\xb1\x04\xb0\x04\xa5\x04\xa3\x04\xb5\x04\x00\x00\xaf\x04\xa9\x01\x8d\x04\x83\x04\x00\x00\x00\x00\x79\x04\x60\x07\xb1\x02\x69\x04\xbf\x02\x65\x02\x81\x04\x67\x04\x00\x00\x50\x04\x11\x04\x11\x04\x00\x00\x00\x00\x00\x00\x11\x04\x11\x04\x2b\x04\x19\x04\x3e\x04\x00\x00\x28\x04\x20\x04\x08\x04\x05\x04\x00\x00\x0e\x04\x0c\x04\x0b\x04\xf9\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x04\xe0\x03\x00\x00\x60\x07\x00\x00\xf3\x03\x00\x00\xae\x08\xac\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x60\x07\x00\x00\xd0\x03\xe1\x03\xc1\x03\xa9\x01\xbc\x03\x00\x00\xb3\x03\x00\x00\x00\x00\x00\x00\x00\x00\x67\x03\x67\x03\x40\x09\xae\x03\xc0\x03\xa2\x03\x0f\x04\x00\x00\x79\x03\x0f\x07\x00\x00\x00\x00\x9c\x03\x4d\x03\x6f\x03\x2e\x03\x2e\x03\x00\x00\x62\x03\x4c\x03\x00\x00\x0f\x05\x00\x00\x32\x03\x00\x00\x22\x03\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x1e\x00\xd8\x02\xc7\x01\x5d\x01\x27\x01\x50\x01\x82\x05\x9c\x05\xe5\x02\xd0\x01\xc6\x02\x04\x06\xd9\x06\x08\x05\xa4\x01\x04\x01\xed\x08\x99\x08\x4b\x07\xce\x05\xd3\x07\x74\x08\xd1\x02\x35\x02\xa8\x04\x13\x01\x32\x06\x78\x04\xc9\x02\x12\x00\xd1\x00\xa6\x05\x6a\x04\xad\x02\x26\x01\x36\x08\x7b\x07\x1f\x01\x38\x03\xff\xff\x82\x04\x9a\x01\x5b\x02\x82\x00\xf4\x00\xd6\x07\xe0\x07\xfa\x07\xea\x06\x61\x00\xd6\x01\xfd\x07\x61\x01\xee\x00\xe7\x01\x0e\x07\x10\x02\x27\x02\x4c\x08\x17\x05\x60\x05\x95\x04\xdf\x04\xf6\x04\xea\x01\xe6\x01\x06\x03\xc8\x04\x32\x00\xbc\x00\x4f\x00\x46\x00\xf5\x05\x3b\x02\x5d\x00\x89\x02\x7f\x06\xaf\x06\x71\x06\xdc\x05\xa6\x00\x71\x00\xf0\x00\xd2\x00\x06\x04\xec\x00\x2d\x00\x9b\x00\x28\x00\x0e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc7\x02\x00\x00\x00\x00\x00\x00\x7e\x04\x61\x04\xc1\x02\xb3\x02\x4a\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3d\x02\x00\x00\x00\x00\x24\x04\xa3\x01\xef\x02\xac\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x69\x02\x00\x00\x00\x00\x00\x00\x46\x08\x40\x08\x00\x00\x00\x00\x00\x00\x00\x00\x42\x02\x00\x00\x00\x00\x00\x00\x37\x02\x00\x00\x00\x00\x00\x00\x00\x04\x0d\x00\x05\x00\x71\x02\xe9\x03\x04\x00\x86\x00\xe3\xff\x4d\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8b\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x28\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd1\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x62\x05\x56\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2c\x03\xac\x02\x00\x00\x00\x00\x00\x00\x00\x00\x92\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x93\x05\x7d\x06\x80\x04\x00\x00\x00\x00\x00\x00\x00\x00\x08\x02\x00\x00\x00\x00\x00\x00\x0b\x02\xe9\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x58\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x91\x01\x00\x00\xf3\x00\x00\x00\x00\x00\xbd\x00\x00\x00\x00\x00\xd1\x06\x68\x05\xed\x01\x00\x00\xc9\x01\x9e\x01\x00\x00\x00\x00\x00\x00\xca\x04\x2a\x03\x90\x03\x9b\x01\x96\x01\xe1\x08\x5e\x08\x63\x08\x50\x08\xf8\x06\x39\x08\x4c\x04\x12\x04\x00\x00\x00\x00\x00\x00\x00\x00\x46\x02\xe8\x06\xe6\xff\x00\x00\x00\x00\xe4\x04\x9d\x02\x6f\x01\xf8\x00\x30\x06\x9d\x06\x24\x02\x11\x03\xc6\x07\x57\x01\xf4\x01\x09\x07\x65\x01\x00\x00\xc9\x06\xbf\x06\xab\x07\x30\x04\xd7\x03\xe3\x00\x00\x00\xf3\x07\xad\x00\x8b\x01\xac\x00\xc9\x03\x07\x02\x00\x00\x00\x00\xb9\x00\xf1\x00\xa4\x02\x89\x01\x94\x00\x00\x00\xfc\x04\x33\x00\x26\x00\x00\x00\x00\x00\x51\x06\xc9\x05\x43\x06\x10\x00\x9e\x05\x8d\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x92\x00\x00\x00\x0c\x00\xe2\x00\x00\x00\xf5\x00\x9b\x02\x00\x00\x00\x00\x5a\x04\x1c\x08\x00\x00\x8b\x06\x16\x08\x25\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6d\x01\x00\x00\x84\x02\x6d\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x97\x00\x00\x00\x00\x00\x13\x06\x00\x00\x00\x00\xa3\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x05\x06\x00\x00\x00\x00\x8c\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd6\x00\x00\x00\x00\x00\xe2\xff\xe0\xff\x00\x00\xdf\xff\xeb\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc3\x02\x00\x00\x00\x00\x00\x00\x70\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x03\x6c\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x52\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1e\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x19\x01\x00\x00\x00\x00\x00\x00\x00\x00\xea\xff\x39\x05\x00\x00\x00\x00\x45\x00\xae\x06\x00\x00\xb2\x03\x00\x00\x00\x00\xaf\x00\xfd\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf2\x01\xa8\x00\xa6\x07\xf7\x05\x00\x00\x69\x07\x2d\x07\xe9\x07\x00\x00\x00\x00\xf0\x01\x00\x00\x00\x00\x00\x00\x76\x04\x00\x00\xe9\xff\x00\x00\x00\x00\x00\x00\xe8\xff\x5f\x00\x00\x00\x00\x00\xc7\x00\x00\x00\x00\x00\x82\x01\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xcf\x07\x84\x01\xe9\x00\x00\x00\x1f\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x36\x00\x56\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x26\x03\x3c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2b\x03\xf2\x05\x00\x00\x00\x00\x00\x00\x28\x05\x2c\x07\x00\x00\x19\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0f\x03\x00\x00\x00\x00\x00\x00\x8b\x06\xe4\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xce\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa5\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfd\xff\xe1\xff\x70\x00\x00\x00\x00\x00\x00\x00\x7a\x05\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf5\xff\xdd\xff\x00\x00\x99\xff\x00\x00\x00\x00\x55\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\x7c\xff\x7c\xff\x00\x00\x00\x00\x76\xff\x00\x00\x71\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5e\xff\x00\x00\x00\x00\x59\xff\x56\xff\x00\x00\x00\x00\x00\x00\x4f\xff\x00\x00\x00\x00\x49\xff\x00\x00\x00\x00\x00\x00\x3e\xff\x3b\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x30\xff\x2d\xff\x00\x00\x28\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\xff\x00\x00\x00\x00\xfc\xfe\x09\xff\x00\x00\x05\xff\xfc\xfe\x00\x00\x00\x00\xfc\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdd\xfe\xda\xfe\xd7\xfe\xd4\xfe\x00\x00\x00\x00\x00\x00\x00\x00\xfc\xfe\xfc\xfe\xc5\xfe\x00\x00\xc0\xfe\x00\x00\x00\x00\xaf\xfe\x00\x00\x00\x00\xa8\xfe\x00\x00\xfc\xfe\xfc\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa5\xff\x99\xfe\x00\x00\x81\xff\x9b\xfe\x00\x00\x00\x00\xcf\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd0\xfe\xe1\xfe\xe8\xfe\xd1\xfe\x00\x00\xee\xfe\xec\xfe\xe7\xfe\x00\x00\x00\x00\xda\xfe\xd7\xfe\xd4\xfe\xa4\xff\x94\xff\x93\xff\x92\xff\x91\xff\x90\xff\x8f\xff\x8e\xff\x83\xff\x82\xff\x7f\xff\x00\x00\x9f\xfe\xf1\xfe\xf3\xfe\x00\x00\xf4\xfe\xf2\xfe\x00\x00\xfb\xfe\xf8\xfe\x00\x00\xfc\xfe\xfc\xfe\x84\xff\x00\x00\xa3\xfe\x00\x00\x00\x00\x00\x00\x00\x00\xa7\xfe\x00\x00\x00\x00\x00\x00\xac\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9b\xfe\xb0\xfe\xae\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x8c\xff\x8b\xff\x8a\xff\x89\xff\x88\xff\x87\xff\x86\xff\x85\xff\x00\x00\x00\x00\x00\x00\xbf\xfe\x00\x00\x00\x00\x00\x00\xc4\xfe\x00\x00\x00\x00\x00\x00\xc9\xfe\x00\x00\x00\x00\x8d\xff\x00\x00\x00\x00\x00\x00\xce\xfe\x00\x00\xd3\xfe\x00\x00\xd6\xfe\x00\x00\x00\x00\xd9\xfe\x00\x00\xdc\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xff\x00\x00\x00\x00\x00\x00\x04\xff\x00\x00\x00\x00\x08\xff\x00\x00\x00\x00\x0b\xff\x00\x00\x0d\xff\x00\x00\x95\xff\x00\x00\x00\x00\x00\x00\x00\x00\x16\xff\x15\xff\x13\xff\x11\xff\x1e\xff\x1c\xff\x00\x00\x00\x00\x9a\xff\x99\xff\x98\xff\x97\xff\x96\xff\x00\x00\x00\x00\x00\x00\x00\x00\x20\xff\x00\x00\x00\x00\x22\xff\x00\x00\x00\x00\x00\x00\x00\x00\x25\xff\x00\x00\x00\x00\x27\xff\x29\xff\x00\x00\x00\x00\x2c\xff\x00\x00\x2f\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x34\xff\x00\x00\x36\xff\x00\x00\x00\x00\x00\x00\x9c\xff\x9b\xff\x3a\xff\x00\x00\x43\xff\x40\xff\x3d\xff\x00\x00\x00\x00\x00\x00\xa3\xff\x00\x00\x00\x00\x44\xff\x3e\xff\x46\xff\x00\x00\x00\x00\x48\xff\x4a\xff\x00\x00\x4c\xff\x00\x00\x00\x00\x4e\xff\x00\x00\x51\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x55\xff\x00\x00\x58\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5d\xff\x00\x00\x60\xff\x00\x00\x62\xff\x00\x00\x00\x00\x5e\xff\x00\x00\x9f\xff\x9e\xff\x9d\xff\x00\x00\x00\x00\xa0\xff\x00\x00\x00\x00\x00\x00\x00\x00\x6b\xff\x69\xff\x6e\xff\x6d\xff\x6c\xff\x6a\xff\x00\x00\x70\xff\xc5\xfe\x00\x00\xa1\xff\x00\x00\x77\xff\x75\xff\x00\x00\x78\xff\xa2\xff\x00\x00\x00\x00\x00\x00\x00\x00\x7d\xff\x7b\xff\x7e\xff\x76\xff\x00\x00\x00\x00\x12\xff\x71\xff\x00\x00\x80\xff\x00\x00\x00\x00\x00\x00\x64\xff\x65\xff\x00\x00\x00\x00\x5e\xff\x00\x00\x00\x00\x59\xff\x56\xff\x4f\xff\x4f\xff\x00\x00\x4f\xff\x49\xff\x49\xff\x3d\xff\x00\x00\x00\x00\x00\x00\x3e\xff\x4f\xff\x3b\xff\x37\xff\x38\xff\x00\x00\x00\x00\x00\x00\x00\x00\x30\xff\x2d\xff\x49\xff\x28\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\xff\x4f\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\xfe\x09\xff\x05\xff\x09\xff\x00\x00\x00\x00\x00\x00\x00\x00\xdd\xfe\xda\xfe\xd7\xfe\xd4\xfe\x09\xff\x00\x00\xfc\xfe\xc5\xfe\xc5\xfe\xc1\xfe\x00\x00\xc0\xfe\xaf\xfe\xc0\xfe\x00\x00\xaf\xfe\xd7\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbb\xfe\xbc\xfe\x00\x00\x00\x00\xa9\xfe\xc5\xfe\xa8\xfe\xa5\xfe\x00\x00\xfc\xfe\x00\x00\x00\x00\x00\x00\xfc\xfe\xa0\xfe\x00\x00\xfc\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd7\xfe\xd7\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdd\xfe\x00\x00\x9a\xfe\xc0\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc0\xfe\xed\xfe\xde\xfe\x00\x00\xef\xfe\xe0\xfe\xea\xfe\x9e\xfe\x00\x00\x00\x00\xfa\xfe\xf9\xfe\xf5\xfe\xf6\xfe\xa2\xfe\x1f\xff\xa6\xfe\x00\x00\xab\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc5\xfe\x00\x00\x00\x00\xad\xfe\xb3\xfe\x00\x00\x00\x00\xbe\xfe\xc0\xfe\xc3\xfe\x00\x00\xc8\xfe\x4f\xff\x00\x00\x00\x00\xd2\xfe\xd5\xfe\xd8\xfe\xdb\xfe\x00\x00\x00\x00\xff\xfe\x02\xff\x00\x00\x00\x00\x03\xff\x07\xff\x0a\xff\x4f\xff\x00\x00\x0c\xff\x00\x00\x00\x00\x00\x00\x00\x00\x10\xff\x1a\xff\x1b\xff\x1d\xff\x21\xff\x00\x00\x00\x00\x26\xff\x00\x00\x2b\xff\x2e\xff\x00\x00\x00\x00\x33\xff\x35\xff\x39\xff\x00\x00\x3c\xff\x3f\xff\x42\xff\x00\x00\x47\xff\x00\x00\x4d\xff\x50\xff\x00\x00\x00\x00\x54\xff\x57\xff\x00\x00\x00\x00\x5c\xff\x5f\xff\x61\xff\x00\x00\x00\x00\x68\xff\x67\xff\x6f\xff\x00\x00\xc5\xfe\x71\xff\x74\xff\x00\x00\x00\x00\x12\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4b\xff\x00\x00\x41\xff\x00\x00\x00\x00\x28\xff\x00\x00\x00\x00\x12\xff\x17\xff\x00\x00\x00\x00\xfc\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\xfe\x00\x00\xc5\xfe\x00\x00\xb4\xfe\xb1\xfe\xc5\xfe\x00\x00\xb6\xfe\xb7\xfe\xa8\xfe\xb8\xfe\xba\xfe\xfc\xfe\xaa\xfe\x00\x00\xf7\xfe\x00\x00\x00\x00\xdf\xfe\xe2\xfe\xfc\xfe\x05\xff\x05\xff\x00\x00\x71\xff\xf0\xfe\x00\x00\x9c\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9d\xfe\xeb\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc2\xfe\x00\x00\x12\xff\x00\x00\x00\x00\xfd\xfe\xfe\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x23\xff\x24\xff\x00\x00\x2d\xff\x30\xff\x45\xff\x52\xff\x53\xff\x56\xff\x59\xff\x00\x00\x00\x00\x00\x00\x72\xff\x79\xff\x00\x00\x00\x00\x00\x00\x63\xff\x00\x00\x00\x00\x00\x00\x00\x00\x2a\xff\x14\xff\x18\xff\x19\xff\x0e\xff\x00\x00\x00\x00\x01\xff\x00\x00\xcb\xfe\x00\x00\xc6\xfe\x00\x00\xc5\xfe\xb5\xfe\xb9\xfe\xb2\xfe\xa1\xfe\xe3\xfe\xe5\xfe\xe4\xfe\x00\x00\xe9\xfe\x00\x00\x00\x00\x00\x00\x12\xff\x00\x00\x06\xff\x00\x00\x31\xff\x32\xff\x5a\xff\x5b\xff\x00\x00\xc5\xfe\x76\xff\x00\x00\x00\x00\x00\x00\xfc\xfe\xcd\xfe\x00\x00\x00\x00\xbd\xfe\xe6\xfe\x00\x00\x00\x00\x00\x00\x00\x00\xc5\xfe\x7a\xff\x00\x00\x00\x00\x0f\xff\xfc\xfe\xc7\xfe\x00\x00\x66\xff\x00\x00\x73\xff\xcc\xfe"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x24\x00\x01\x00\x24\x00\x24\x00\x24\x00\x24\x00\x24\x00\x24\x00\x23\x00\x01\x00\x72\x00\x24\x00\x24\x00\x24\x00\x24\x00\x05\x00\x06\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x24\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x24\x00\x23\x00\x22\x00\x23\x00\x24\x00\x01\x00\x26\x00\x24\x00\x24\x00\x44\x00\x22\x00\x23\x00\x24\x00\x01\x00\x26\x00\x24\x00\x24\x00\x24\x00\x01\x00\x24\x00\x23\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x24\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x27\x00\x28\x00\x22\x00\x23\x00\x24\x00\x24\x00\x26\x00\x24\x00\x4e\x00\x71\x00\x22\x00\x23\x00\x24\x00\x71\x00\x26\x00\x22\x00\x71\x00\x44\x00\x24\x00\x26\x00\x71\x00\x71\x00\x71\x00\x71\x00\x80\x00\x18\x00\x80\x00\x80\x00\x80\x00\x80\x00\x80\x00\x80\x00\x64\x00\x65\x00\x66\x00\x80\x00\x80\x00\x80\x00\x80\x00\x6b\x00\x64\x00\x65\x00\x66\x00\x02\x00\x10\x00\x23\x00\x03\x00\x6b\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x07\x00\x24\x00\x71\x00\x7d\x00\x7e\x00\x10\x00\x24\x00\x03\x00\x24\x00\x80\x00\x80\x00\x7d\x00\x7e\x00\x18\x00\x64\x00\x65\x00\x66\x00\x80\x00\x80\x00\x80\x00\x7f\x00\x6b\x00\x64\x00\x65\x00\x66\x00\x0b\x00\x24\x00\x22\x00\x71\x00\x6b\x00\x29\x00\x2a\x00\x2b\x00\x01\x00\x6b\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x7d\x00\x7e\x00\x71\x00\x23\x00\x80\x00\x7f\x00\x72\x00\x23\x00\x7d\x00\x7e\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x80\x00\x6e\x00\x45\x00\x24\x00\x72\x00\x24\x00\x58\x00\x23\x00\x4d\x00\x6d\x00\x22\x00\x23\x00\x24\x00\x03\x00\x26\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x58\x00\x71\x00\x24\x00\x23\x00\x4d\x00\x10\x00\x71\x00\x01\x00\x24\x00\x24\x00\x23\x00\x4a\x00\x52\x00\x18\x00\x77\x00\x78\x00\x80\x00\x53\x00\x09\x00\x0a\x00\x23\x00\x80\x00\x6e\x00\x23\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x29\x00\x2a\x00\x2b\x00\x78\x00\x23\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x5b\x00\x22\x00\x23\x00\x24\x00\x10\x00\x26\x00\x23\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x67\x00\x64\x00\x65\x00\x66\x00\x45\x00\x10\x00\x6d\x00\x23\x00\x6b\x00\x5b\x00\x5b\x00\x77\x00\x78\x00\x18\x00\x23\x00\x21\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x23\x00\x23\x00\x58\x00\x45\x00\x23\x00\x23\x00\x7e\x00\x53\x00\x23\x00\x29\x00\x77\x00\x78\x00\x2c\x00\x67\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x53\x00\x6d\x00\x23\x00\x6c\x00\x6d\x00\x03\x00\x6e\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x64\x00\x65\x00\x66\x00\x53\x00\x23\x00\x10\x00\x45\x00\x6b\x00\x36\x00\x58\x00\x59\x00\x24\x00\x02\x00\x18\x00\x79\x00\x7a\x00\x23\x00\x53\x00\x4c\x00\x5c\x00\x5d\x00\x53\x00\x72\x00\x23\x00\x5c\x00\x58\x00\x7a\x00\x61\x00\x62\x00\x63\x00\x29\x00\x2a\x00\x2b\x00\x40\x00\x04\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x68\x00\x1b\x00\x79\x00\x7a\x00\x6c\x00\x6d\x00\x23\x00\x03\x00\x6e\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x7c\x00\x79\x00\x7a\x00\x4c\x00\x45\x00\x10\x00\x01\x00\x49\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x18\x00\x21\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x2c\x00\x41\x00\x42\x00\x58\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x24\x00\x29\x00\x2a\x00\x23\x00\x4a\x00\x01\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x03\x00\x6e\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x10\x00\x45\x00\x21\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x18\x00\x01\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x58\x00\x61\x00\x62\x00\x63\x00\x23\x00\x29\x00\x56\x00\x5b\x00\x23\x00\x23\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x25\x00\x6f\x00\x70\x00\x23\x00\x23\x00\x23\x00\x00\x00\x03\x00\x6e\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x65\x00\x66\x00\x3e\x00\x05\x00\x45\x00\x10\x00\x6b\x00\x35\x00\x31\x00\x32\x00\x33\x00\x34\x00\x35\x00\x18\x00\x5c\x00\x5d\x00\x3e\x00\x61\x00\x62\x00\x63\x00\x10\x00\x5c\x00\x5d\x00\x58\x00\x50\x00\x51\x00\x52\x00\x00\x00\x65\x00\x66\x00\x29\x00\x01\x00\x49\x00\x6a\x00\x6b\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x54\x00\x55\x00\x56\x00\x57\x00\x7b\x00\x7c\x00\x6e\x00\x30\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x23\x00\x23\x00\x68\x00\x45\x00\x23\x00\x25\x00\x6c\x00\x6d\x00\x01\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x23\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x58\x00\x02\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x22\x00\x23\x00\x24\x00\x24\x00\x26\x00\x58\x00\x59\x00\x25\x00\x01\x00\x22\x00\x23\x00\x24\x00\x6e\x00\x26\x00\x24\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x4d\x00\x4e\x00\x23\x00\x12\x00\x5c\x00\x5d\x00\x51\x00\x52\x00\x23\x00\x02\x00\x22\x00\x23\x00\x24\x00\x24\x00\x26\x00\x68\x00\x5f\x00\x60\x00\x67\x00\x6c\x00\x6d\x00\x64\x00\x65\x00\x66\x00\x6d\x00\x23\x00\x2f\x00\x30\x00\x6b\x00\x21\x00\x22\x00\x23\x00\x24\x00\x42\x00\x26\x00\x25\x00\x3f\x00\x40\x00\x27\x00\x5f\x00\x60\x00\x03\x00\x23\x00\x05\x00\x64\x00\x65\x00\x66\x00\x01\x00\x5f\x00\x60\x00\x24\x00\x6b\x00\x3e\x00\x64\x00\x65\x00\x66\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x6b\x00\x4c\x00\x4d\x00\x23\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x48\x00\x60\x00\x42\x00\x43\x00\x4c\x00\x64\x00\x65\x00\x66\x00\x01\x00\x22\x00\x23\x00\x24\x00\x6b\x00\x26\x00\x02\x00\x24\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x61\x00\x62\x00\x63\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x22\x00\x23\x00\x24\x00\x72\x00\x26\x00\x70\x00\x51\x00\x52\x00\x02\x00\x22\x00\x23\x00\x24\x00\x01\x00\x26\x00\x72\x00\x23\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x21\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x03\x00\x12\x00\x05\x00\x05\x00\x22\x00\x23\x00\x24\x00\x09\x00\x26\x00\x02\x00\x06\x00\x07\x00\x08\x00\x23\x00\x23\x00\x64\x00\x65\x00\x66\x00\x42\x00\x43\x00\x69\x00\x24\x00\x6b\x00\x28\x00\x17\x00\x72\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x47\x00\x24\x00\x49\x00\x24\x00\x64\x00\x65\x00\x66\x00\x24\x00\x23\x00\x69\x00\x42\x00\x6b\x00\x01\x00\x64\x00\x65\x00\x66\x00\x23\x00\x48\x00\x69\x00\x31\x00\x6b\x00\x4c\x00\x49\x00\x72\x00\x61\x00\x62\x00\x63\x00\x02\x00\x28\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x64\x00\x65\x00\x66\x00\x42\x00\x43\x00\x69\x00\x3d\x00\x6b\x00\x01\x00\x22\x00\x23\x00\x24\x00\x2f\x00\x26\x00\x7b\x00\x7c\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x01\x00\x23\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x22\x00\x23\x00\x24\x00\x03\x00\x26\x00\x05\x00\x02\x00\x12\x00\x12\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x73\x00\x74\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x41\x00\x42\x00\x0b\x00\x01\x00\x7f\x00\x0e\x00\x03\x00\x28\x00\x28\x00\x25\x00\x22\x00\x23\x00\x24\x00\x01\x00\x26\x00\x23\x00\x23\x00\x23\x00\x0f\x00\x05\x00\x12\x00\x64\x00\x65\x00\x66\x00\x0b\x00\x25\x00\x69\x00\x0e\x00\x6b\x00\x23\x00\x12\x00\x33\x00\x4d\x00\x4e\x00\x36\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x49\x00\x49\x00\x28\x00\x07\x00\x64\x00\x65\x00\x66\x00\x01\x00\x42\x00\x69\x00\x23\x00\x6b\x00\x28\x00\x64\x00\x65\x00\x66\x00\x4b\x00\x01\x00\x4a\x00\x23\x00\x6b\x00\x50\x00\x51\x00\x52\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x4d\x00\x4e\x00\x0e\x00\x12\x00\x49\x00\x64\x00\x65\x00\x66\x00\x01\x00\x22\x00\x23\x00\x24\x00\x6b\x00\x26\x00\x49\x00\x25\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x25\x00\x18\x00\x19\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x22\x00\x23\x00\x24\x00\x06\x00\x26\x00\x54\x00\x55\x00\x56\x00\x57\x00\x22\x00\x23\x00\x24\x00\x4a\x00\x26\x00\x23\x00\x02\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x01\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x25\x00\x4c\x00\x4d\x00\x34\x00\x22\x00\x23\x00\x24\x00\x03\x00\x26\x00\x01\x00\x06\x00\x12\x00\x12\x00\x3e\x00\x0f\x00\x64\x00\x65\x00\x66\x00\x25\x00\x01\x00\x23\x00\x23\x00\x6b\x00\x03\x00\x02\x00\x05\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x25\x00\x28\x00\x28\x00\x23\x00\x12\x00\x05\x00\x64\x00\x65\x00\x66\x00\x01\x00\x22\x00\x23\x00\x24\x00\x6b\x00\x26\x00\x64\x00\x65\x00\x66\x00\x41\x00\x42\x00\x25\x00\x4a\x00\x6b\x00\x25\x00\x01\x00\x23\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x0f\x00\x49\x00\x49\x00\x25\x00\x01\x00\x64\x00\x65\x00\x66\x00\x12\x00\x22\x00\x23\x00\x24\x00\x6b\x00\x26\x00\x01\x00\x0e\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x41\x00\x42\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x25\x00\x4c\x00\x4d\x00\x12\x00\x22\x00\x23\x00\x24\x00\x01\x00\x26\x00\x21\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x64\x00\x65\x00\x66\x00\x25\x00\x25\x00\x02\x00\x25\x00\x6b\x00\x23\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x2c\x00\x2d\x00\x2e\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x23\x00\x4c\x00\x4d\x00\x22\x00\x23\x00\x24\x00\x21\x00\x26\x00\x01\x00\x0e\x00\x64\x00\x65\x00\x66\x00\x25\x00\x3f\x00\x40\x00\x23\x00\x6b\x00\x05\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x49\x00\x4c\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x4a\x00\x64\x00\x65\x00\x66\x00\x61\x00\x62\x00\x63\x00\x03\x00\x6b\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x41\x00\x42\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x23\x00\x02\x00\x21\x00\x22\x00\x23\x00\x24\x00\x01\x00\x26\x00\x7b\x00\x7c\x00\x22\x00\x23\x00\x24\x00\x05\x00\x26\x00\x64\x00\x65\x00\x66\x00\x3f\x00\x40\x00\x23\x00\x25\x00\x6b\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x21\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x47\x00\x25\x00\x49\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x23\x00\x23\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x64\x00\x65\x00\x66\x00\x47\x00\x25\x00\x49\x00\x34\x00\x6b\x00\x07\x00\x22\x00\x23\x00\x24\x00\x42\x00\x26\x00\x62\x00\x63\x00\x3e\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x0f\x00\x64\x00\x65\x00\x66\x00\x25\x00\x01\x00\x25\x00\x23\x00\x6b\x00\x23\x00\x22\x00\x23\x00\x24\x00\x4f\x00\x26\x00\x51\x00\x52\x00\x25\x00\x25\x00\x61\x00\x62\x00\x63\x00\x17\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x25\x00\x64\x00\x65\x00\x66\x00\x6f\x00\x70\x00\x3f\x00\x40\x00\x6b\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x49\x00\x25\x00\x25\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x01\x00\x25\x00\x64\x00\x65\x00\x66\x00\x32\x00\x25\x00\x25\x00\x35\x00\x6b\x00\x22\x00\x23\x00\x24\x00\x05\x00\x26\x00\x49\x00\x23\x00\x3e\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x4a\x00\x25\x00\x01\x00\x65\x00\x66\x00\x4a\x00\x24\x00\x0e\x00\x6a\x00\x6b\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x21\x00\x22\x00\x23\x00\x24\x00\x12\x00\x26\x00\x25\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x46\x00\x23\x00\x48\x00\x65\x00\x66\x00\x10\x00\x4c\x00\x25\x00\x6a\x00\x6b\x00\x25\x00\x07\x00\x49\x00\x18\x00\x21\x00\x22\x00\x23\x00\x24\x00\x34\x00\x26\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x65\x00\x66\x00\x3e\x00\x23\x00\x23\x00\x10\x00\x6b\x00\x23\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x18\x00\x05\x00\x49\x00\x02\x00\x23\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x23\x00\x4c\x00\x66\x00\x61\x00\x62\x00\x63\x00\x38\x00\x6b\x00\x3a\x00\x3b\x00\x45\x00\x3d\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x6f\x00\x70\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x0e\x00\x07\x00\x23\x00\x25\x00\x58\x00\x10\x00\x62\x00\x63\x00\x4a\x00\x23\x00\x0f\x00\x45\x00\x4a\x00\x18\x00\x21\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x6e\x00\x3c\x00\x0e\x00\x07\x00\x58\x00\x10\x00\x41\x00\x42\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x18\x00\x21\x00\x22\x00\x23\x00\x24\x00\x0e\x00\x26\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x6e\x00\x46\x00\x07\x00\x48\x00\x0e\x00\x10\x00\x45\x00\x4c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x18\x00\x17\x00\x23\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x05\x00\x58\x00\x05\x00\x24\x00\x63\x00\x0e\x00\x32\x00\x01\x00\x45\x00\x35\x00\x23\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x24\x00\x0f\x00\x24\x00\x3e\x00\x02\x00\x24\x00\x5a\x00\x24\x00\x6e\x00\x12\x00\x5e\x00\x0e\x00\x58\x00\x61\x00\x62\x00\x63\x00\x23\x00\x05\x00\x17\x00\x45\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x25\x00\x23\x00\x46\x00\x24\x00\x48\x00\x23\x00\x6e\x00\x23\x00\x4c\x00\x17\x00\x58\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x0f\x00\x25\x00\x24\x00\x24\x00\x23\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x25\x00\x3a\x00\x3b\x00\x6e\x00\x3d\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x4a\x00\x4c\x00\x74\x00\x75\x00\x76\x00\x23\x00\x21\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x17\x00\x7f\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x23\x00\x23\x00\x07\x00\x24\x00\x17\x00\x4a\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x02\x00\x01\x00\x32\x00\x24\x00\x23\x00\x35\x00\x23\x00\x05\x00\x4a\x00\x74\x00\x75\x00\x76\x00\x05\x00\x4f\x00\x3e\x00\x51\x00\x52\x00\x05\x00\x12\x00\x23\x00\x7f\x00\x23\x00\x23\x00\x54\x00\x55\x00\x56\x00\x57\x00\x23\x00\x74\x00\x75\x00\x76\x00\x23\x00\x25\x00\x23\x00\x61\x00\x62\x00\x63\x00\x25\x00\x17\x00\x7f\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x6f\x00\x70\x00\x49\x00\x24\x00\x17\x00\x23\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x02\x00\x41\x00\x42\x00\x24\x00\x21\x00\x20\x00\x73\x00\x74\x00\x4a\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x4f\x00\x4c\x00\x51\x00\x52\x00\x1c\x00\x7f\x00\x22\x00\x73\x00\x74\x00\x17\x00\x1c\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x7f\x00\x23\x00\x0a\x00\x24\x00\x17\x00\x23\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x23\x00\x11\x00\x17\x00\x24\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x3c\x00\x13\x00\x05\x00\x24\x00\x33\x00\x41\x00\x42\x00\x36\x00\x13\x00\x49\x00\x73\x00\x74\x00\x4a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x1c\x00\x1c\x00\x23\x00\x02\x00\x7f\x00\x1d\x00\x73\x00\x74\x00\x17\x00\x1d\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x7f\x00\x23\x00\x1d\x00\x24\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x15\x00\x1a\x00\x23\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x4a\x00\x23\x00\x4a\x00\x49\x00\x74\x00\x75\x00\x49\x00\x4b\x00\x23\x00\x02\x00\x23\x00\x23\x00\x50\x00\x51\x00\x52\x00\x7f\x00\x4a\x00\x73\x00\x74\x00\x23\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x49\x00\x3c\x00\x23\x00\x36\x00\x7f\x00\x74\x00\x41\x00\x42\x00\x54\x00\x55\x00\x56\x00\x57\x00\x05\x00\x13\x00\x0f\x00\x0e\x00\x7f\x00\x23\x00\x33\x00\x23\x00\x49\x00\x36\x00\x01\x00\x26\x00\x0f\x00\x04\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x4b\x00\x23\x00\x23\x00\x0d\x00\x54\x00\x55\x00\x56\x00\x57\x00\x12\x00\x4d\x00\x74\x00\x3c\x00\x54\x00\x55\x00\x56\x00\x57\x00\x41\x00\x42\x00\x0c\x00\x23\x00\x1c\x00\x7f\x00\x21\x00\x22\x00\x23\x00\x24\x00\x3b\x00\x26\x00\x3d\x00\x27\x00\x0c\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x4d\x00\x54\x00\x55\x00\x56\x00\x57\x00\x01\x00\x4d\x00\x4a\x00\x04\x00\x37\x00\x38\x00\x39\x00\x3a\x00\x3b\x00\x3c\x00\x3d\x00\x4b\x00\x0d\x00\x23\x00\x23\x00\x4d\x00\x4d\x00\x12\x00\x49\x00\x4d\x00\x14\x00\x48\x00\x49\x00\x4a\x00\x01\x00\x4c\x00\x14\x00\x04\x00\x55\x00\x56\x00\x1f\x00\x01\x00\x4d\x00\x37\x00\x04\x00\x39\x00\x0d\x00\x3b\x00\x27\x00\x3d\x00\x06\x00\x12\x00\x5e\x00\x0d\x00\x23\x00\x61\x00\x62\x00\x63\x00\x12\x00\x4d\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x38\x00\x39\x00\x3a\x00\x3b\x00\x3c\x00\x3d\x00\x07\x00\x27\x00\x54\x00\x55\x00\x56\x00\x39\x00\x4d\x00\x3b\x00\x27\x00\x3d\x00\x48\x00\x49\x00\x4a\x00\x23\x00\x4c\x00\x07\x00\x0c\x00\x37\x00\x38\x00\x39\x00\x3a\x00\x3b\x00\x3c\x00\x3d\x00\x4d\x00\x38\x00\x39\x00\x3a\x00\x3b\x00\x3c\x00\x3d\x00\x23\x00\x01\x00\x0c\x00\x48\x00\x49\x00\x4a\x00\x4d\x00\x4c\x00\x0b\x00\x4d\x00\x48\x00\x49\x00\x4a\x00\x0d\x00\x4c\x00\x0b\x00\x4d\x00\x06\x00\x12\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x4d\x00\x06\x00\x54\x00\x55\x00\x56\x00\x4d\x00\x01\x00\x06\x00\x4d\x00\x06\x00\x27\x00\x4b\x00\x4d\x00\x01\x00\x23\x00\x06\x00\x50\x00\x51\x00\x52\x00\x23\x00\x4d\x00\x0f\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x49\x00\x39\x00\x3a\x00\x3b\x00\x3c\x00\x3d\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x48\x00\x49\x00\x4a\x00\x23\x00\x4c\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x21\x00\x22\x00\x23\x00\x24\x00\x23\x00\x26\x00\x23\x00\x14\x00\x14\x00\x23\x00\x54\x00\x55\x00\x56\x00\x4d\x00\x4d\x00\x54\x00\x55\x00\x56\x00\x4d\x00\x23\x00\x0f\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x21\x00\x22\x00\x23\x00\x24\x00\x3b\x00\x26\x00\x3d\x00\x0c\x00\x4d\x00\x0c\x00\x21\x00\x22\x00\x23\x00\x24\x00\x4d\x00\x26\x00\x54\x00\x55\x00\x56\x00\x23\x00\x21\x00\x22\x00\x23\x00\x24\x00\x01\x00\x26\x00\x06\x00\x54\x00\x55\x00\x56\x00\x4d\x00\x5a\x00\x54\x00\x55\x00\x56\x00\x5e\x00\x0b\x00\x4d\x00\x61\x00\x62\x00\x63\x00\x0b\x00\x4d\x00\x55\x00\x56\x00\x21\x00\x22\x00\x23\x00\x24\x00\x02\x00\x26\x00\x21\x00\x22\x00\x23\x00\x24\x00\x06\x00\x26\x00\x5a\x00\x4d\x00\x02\x00\x01\x00\x5e\x00\x01\x00\x01\x00\x61\x00\x62\x00\x63\x00\x5a\x00\x01\x00\x4d\x00\x56\x00\x5e\x00\x02\x00\x4a\x00\x61\x00\x62\x00\x63\x00\x5a\x00\x4d\x00\x23\x00\x0c\x00\x5e\x00\x23\x00\x0c\x00\x61\x00\x62\x00\x63\x00\x21\x00\x22\x00\x23\x00\x24\x00\x02\x00\x26\x00\x21\x00\x22\x00\x23\x00\x24\x00\x06\x00\x26\x00\x21\x00\x22\x00\x23\x00\x24\x00\x4d\x00\x26\x00\x23\x00\x0c\x00\x3c\x00\x02\x00\x61\x00\x62\x00\x63\x00\x41\x00\x42\x00\x09\x00\x61\x00\x62\x00\x63\x00\x4a\x00\x23\x00\x07\x00\x0c\x00\x4d\x00\x4f\x00\x23\x00\x51\x00\x52\x00\x4d\x00\x0e\x00\x4d\x00\x3c\x00\x0e\x00\x4d\x00\x0c\x00\x06\x00\x41\x00\x42\x00\x06\x00\x06\x00\x01\x00\x38\x00\x23\x00\x3a\x00\x3b\x00\x24\x00\x3d\x00\x4d\x00\x0c\x00\x4a\x00\x3c\x00\x4d\x00\x61\x00\x62\x00\x63\x00\x41\x00\x42\x00\x4d\x00\x61\x00\x62\x00\x63\x00\x18\x00\x19\x00\x4d\x00\x61\x00\x62\x00\x63\x00\x3c\x00\x4d\x00\x06\x00\x4d\x00\x4d\x00\x41\x00\x42\x00\x0c\x00\x4d\x00\x23\x00\x23\x00\x29\x00\x23\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x10\x00\x16\x00\x4d\x00\x0c\x00\x01\x00\x36\x00\x1b\x00\x4a\x00\x49\x00\x1e\x00\x1f\x00\x4a\x00\x0c\x00\x3e\x00\x38\x00\x16\x00\x3a\x00\x3b\x00\x4d\x00\x3d\x00\x1b\x00\x0c\x00\x4d\x00\x1e\x00\x1f\x00\x07\x00\x0c\x00\x16\x00\x4d\x00\x08\x00\x07\x00\x4d\x00\x1b\x00\x09\x00\x06\x00\x1e\x00\x01\x00\x0c\x00\x4d\x00\x49\x00\x3d\x00\x4d\x00\x3f\x00\x40\x00\x41\x00\x42\x00\x43\x00\x44\x00\x45\x00\x46\x00\x4b\x00\x0e\x00\x01\x00\x4a\x00\x3d\x00\x4a\x00\x3f\x00\x40\x00\x41\x00\x42\x00\x43\x00\x44\x00\x45\x00\x46\x00\x01\x00\x23\x00\x3d\x00\x4a\x00\x3f\x00\x40\x00\x41\x00\x42\x00\x43\x00\x44\x00\x45\x00\x46\x00\x16\x00\x23\x00\x23\x00\x4a\x00\x4a\x00\x1b\x00\x0e\x00\x26\x00\x1e\x00\x37\x00\x4a\x00\x39\x00\x16\x00\x3b\x00\x4d\x00\x3d\x00\x49\x00\x1b\x00\x4a\x00\x07\x00\x1e\x00\x37\x00\x3e\x00\x39\x00\x4a\x00\x3b\x00\x49\x00\x3d\x00\x36\x00\x1b\x00\x4a\x00\x49\x00\x1e\x00\xff\xff\x2b\x00\x2a\x00\xff\xff\xff\xff\xff\xff\x3d\x00\xff\xff\x3f\x00\x40\x00\x41\x00\x42\x00\x43\x00\x44\x00\x45\x00\x46\x00\xff\xff\xff\xff\x3d\x00\x4a\x00\x3f\x00\x40\x00\x41\x00\x42\x00\x43\x00\x44\x00\x45\x00\x46\x00\x18\x00\x19\x00\x3d\x00\x4a\x00\x3f\x00\x40\x00\x41\x00\x42\x00\x43\x00\x44\x00\x45\x00\x46\x00\x18\x00\x19\x00\xff\xff\x4a\x00\xff\xff\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x18\x00\x19\x00\xff\xff\xff\xff\x29\x00\x36\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\xff\xff\x3e\x00\xff\xff\xff\xff\xff\xff\x36\x00\xff\xff\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x3e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x36\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3e\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x5c\x00\x62\x00\x5c\x00\x5c\x00\x5c\x00\x5c\x00\x5c\x00\x5c\x00\x1c\x01\x62\x00\xf9\x02\x5c\x00\x5c\x00\x5c\x00\x5c\x00\x3c\x02\x8b\x01\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xf3\x02\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xe5\x02\x05\x01\x6a\x00\x6b\x00\x6c\x00\x62\x00\x6d\x00\x5c\x00\x5c\x00\x38\x02\x6a\x00\x6b\x00\x6c\x00\x62\x00\x6d\x00\x5c\x00\x5c\x00\x5c\x00\x62\x00\x5f\x00\x1c\x01\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xb8\x02\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x69\x01\x6a\x01\x6a\x00\x6b\x00\x6c\x00\x5c\x00\x6d\x00\x5f\x00\x06\x01\xf2\x02\x6a\x00\x6b\x00\x6c\x00\xe4\x02\x6d\x00\x6a\x00\xd6\x02\x1d\x01\x5c\x00\x6d\x00\x98\x02\x9a\x02\x55\x02\x78\x02\xba\x00\xbf\x00\x79\x02\x7b\x02\xba\x00\x7c\x02\xbe\x01\xba\x00\x6e\x00\x6f\x00\x70\x00\xba\x00\xba\x00\xba\x00\xba\x00\x71\x00\x6e\x00\x6f\x00\x70\x00\x9c\x01\xe4\x00\xc2\x00\x60\x01\x71\x00\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\xb9\x00\x5c\x00\xff\x01\xec\x02\x83\x00\xe4\x00\x5c\x00\x9b\x01\x97\x00\xc0\x01\xc3\x01\x94\x02\x83\x00\xbf\x00\x6e\x00\x6f\x00\x70\x00\xba\x00\xc4\x01\x5d\x00\x0a\x02\x71\x00\x6e\x00\x6f\x00\x70\x00\x71\x01\x97\x00\xc9\x01\x0f\x02\x71\x00\x61\x01\x62\x01\xe3\x02\x62\x00\xc6\x00\x64\x01\x55\x01\x56\x01\x57\x01\xf5\x01\x83\x00\x10\x02\xfd\x00\xba\x00\x60\x00\xc9\x02\x92\x00\x82\x00\x83\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xba\x00\xc0\x00\x58\x01\x97\x00\xb4\x02\xe0\x00\xe8\x00\xc2\x00\xff\xff\xc3\x00\x6a\x00\x6b\x00\x6c\x00\x60\x01\x6d\x00\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\x59\x01\x6f\x01\x97\x00\xa8\x02\xff\xff\xe4\x00\xb9\x00\x62\x00\xe0\x00\xe0\x00\xae\x02\x5f\x00\xfe\x00\xbf\x00\x97\x02\x9a\x00\xba\x00\xbf\x01\x17\x01\x18\x01\xc2\x00\xba\x00\x5a\x01\xc2\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x61\x01\x62\x01\x53\x02\x98\x00\x92\x00\x64\x01\x55\x01\x56\x01\x57\x01\x14\x02\x6a\x00\x6b\x00\x6c\x00\xe4\x00\x6d\x00\x92\x00\x60\x01\x5d\x01\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\xe6\x01\x6e\x00\x6f\x00\x70\x00\x58\x01\xe4\x00\xce\x00\x92\x00\x71\x00\x1e\x02\x20\x02\x00\x02\x9a\x00\xbf\x00\xdc\x00\x84\x00\x85\x00\x86\x00\x87\x00\xdc\x00\x88\x00\x92\x00\xc2\x00\x59\x01\x19\x01\x92\x00\xfd\x01\x72\x00\x93\x00\x09\x01\x6b\x01\x99\x00\x9a\x00\x6c\x01\x18\x02\x64\x01\x55\x01\x56\x01\x57\x01\x93\x00\xce\x00\x3d\x01\xc4\x00\xc5\x00\x60\x01\x5a\x01\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\xd5\x02\x6f\x00\x70\x00\x93\x00\x29\x01\xe4\x00\x58\x01\x71\x00\x3e\x01\xe5\x00\x24\x02\x57\x02\x1e\x01\xbf\x00\x96\x02\x96\x00\x09\x01\x93\x00\x34\x02\xdd\x00\x8f\x02\xfc\x00\x7e\x02\x0f\x01\xdf\x00\x59\x01\x94\x00\x89\x00\x8a\x00\x8b\x00\x61\x01\x62\x01\x63\x01\x2a\x01\x5d\x01\x64\x01\x55\x01\x56\x01\x57\x01\x17\x02\x62\x00\xfe\x01\x96\x00\xcc\x00\xc5\x00\x1f\x01\x60\x01\x5a\x01\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\x8c\x00\x95\x00\x96\x00\x0a\x01\x58\x01\xe4\x00\x62\x00\x10\x01\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\xbf\x00\x84\x00\x85\x00\x86\x00\x87\x00\x2e\x02\x88\x00\x5e\x01\xc3\x02\x27\x01\x59\x01\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xe0\x00\x61\x01\x66\x01\xee\x00\x5f\x00\x62\x00\x64\x01\x55\x01\x56\x01\x57\x01\x6a\x00\x6b\x00\x6c\x00\x35\x02\x6d\x00\x60\x01\x5a\x01\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xe4\x00\x58\x01\x84\x00\x85\x00\x86\x00\x87\x00\xdc\x00\x88\x00\xbf\x00\xf4\x00\x6a\x00\x6b\x00\x6c\x00\xdc\x00\x6d\x00\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x59\x01\xbb\x00\x8a\x00\x8b\x00\x2d\x01\x6b\x01\x2b\x02\xe1\x00\xfd\x00\x47\x02\x64\x01\x55\x01\x56\x01\x57\x01\x4c\x02\xf7\x02\xbe\x00\xc2\x00\x2d\x01\xee\x00\x4d\x02\x60\x01\x5a\x01\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\xef\x01\x70\x00\x46\x02\x4e\x01\x58\x01\xe4\x00\x71\x00\x3f\x01\xf5\x00\xf6\x00\xf7\x00\xf8\x00\xf9\x00\xbf\x00\xdd\x00\x90\x02\x40\x01\x89\x00\x8a\x00\x8b\x00\xe4\x00\xdd\x00\x1f\x02\x59\x01\x01\x01\x02\x01\x00\x01\x4e\x02\xc7\x00\x70\x00\x67\x01\x62\x00\x81\x00\x15\x02\x71\x00\x64\x01\x55\x01\x56\x01\x57\x01\xef\x00\xf0\x00\xf1\x00\xe8\x02\x95\x02\x91\x00\x5a\x01\x4f\x01\xd5\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\xc2\x00\xdc\x00\xd7\x01\x58\x01\xc2\x00\x72\x01\xcc\x00\xc5\x00\x62\x00\x6a\x00\x6b\x00\x6c\x00\x05\x01\x6d\x00\xfd\x00\xd5\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x59\x01\x1e\x01\xd5\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\x6a\x00\x6b\x00\x6c\x00\x75\x01\x6d\x00\xe5\x00\xe6\x00\x74\x01\x8e\x00\x6a\x00\x6b\x00\x6c\x00\x5a\x01\x6d\x00\xa3\x01\xd5\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xa9\x02\x08\x01\x1f\x01\x8f\x00\xdd\x00\xde\x00\x2d\x02\x00\x01\x29\x01\x1e\x01\x6a\x00\x6b\x00\x6c\x00\xb1\x01\x6d\x00\xcb\x00\xa0\x02\xd9\x00\xcd\x00\xcc\x00\xc5\x00\xd7\x00\x6f\x00\x70\x00\xce\x00\x2d\x01\x1b\x01\x1c\x01\x71\x00\x84\x00\x85\x00\x86\x00\x87\x00\x5e\x02\x88\x00\xd9\x01\x31\x02\x2c\x01\x78\x00\x1b\x02\xd9\x00\x9b\x01\x1f\x01\xc1\x02\xd7\x00\x6f\x00\x70\x00\x62\x00\xd8\x00\xd9\x00\xbd\x01\x71\x00\x2e\x01\xd7\x00\x6f\x00\x70\x00\x90\x00\x80\x00\x81\x00\x5f\x00\x71\x00\x82\x00\xa4\xfe\xfd\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\x80\x00\xd6\x00\x20\x01\x3a\x02\x82\x00\xd7\x00\x6f\x00\x70\x00\x62\x00\x6a\x00\x6b\x00\x6c\x00\x71\x00\x6d\x00\x1e\x01\xc2\x01\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xbb\x00\x8a\x00\x8b\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\x6a\x00\x6b\x00\x6c\x00\xc7\x01\x6d\x00\xbc\x00\xff\x00\x00\x01\x1e\x01\x6a\x00\x6b\x00\x6c\x00\x29\x01\x6d\x00\xca\x01\x1f\x01\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x84\x00\x85\x00\x86\x00\x87\x00\x0f\x01\x88\x00\x9b\x01\x24\x01\xc2\x02\xf1\x01\x6a\x00\x6b\x00\x6c\x00\xf2\x01\x6d\x00\x1e\x01\x47\x01\x48\x01\x49\x01\x1f\x01\x09\x01\xc9\x00\x6f\x00\x70\x00\x86\x01\x87\x01\xec\x01\xde\x01\x71\x00\x25\x01\x9b\x00\xd1\x01\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\x36\x02\xdf\x01\x14\x01\xa4\x00\xc9\x00\x6f\x00\x70\x00\xe4\x01\x1f\x01\xed\x01\x88\x01\x71\x00\x62\x00\xc9\x00\x6f\x00\x70\x00\x2f\x01\x11\x01\x08\x02\x4a\x01\x71\x00\x12\x01\x81\x00\xb7\x00\x89\x00\x8a\x00\x8b\x00\x1e\x01\x68\x01\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\xc9\x00\x6f\x00\x70\x00\x20\x01\x21\x01\x16\x02\x30\x01\x71\x00\x62\x00\x6a\x00\x6b\x00\x6c\x00\x51\x01\x6d\x00\xfc\x01\x91\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x23\x01\x29\x01\x1f\x01\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\x6a\x00\x6b\x00\x6c\x00\x9b\x01\x6d\x00\x67\x02\x1e\x01\x24\x01\x24\x01\x6a\x00\x6b\x00\x6c\x00\x05\x01\x6d\x00\x73\x02\xb6\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xad\x02\x27\x01\x13\x02\x23\x01\xa8\x00\x14\x02\x9b\x01\x25\x01\x25\x01\xfb\x02\x6a\x00\x6b\x00\x6c\x00\x29\x01\x6d\x00\x3d\x01\xfd\x00\x1f\x01\x64\x02\xf9\x02\x24\x01\xc9\x00\x6f\x00\x70\x00\x23\x02\xfc\x02\xd6\x01\x24\x02\x71\x00\x05\x01\x24\x01\x49\x02\x30\x02\x08\x01\x44\x01\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x81\x00\x81\x00\x25\x01\xb9\x00\xc9\x00\x6f\x00\x70\x00\x62\x00\x89\x01\xca\x00\xf6\x02\x71\x00\x25\x01\xd9\x02\x6f\x00\x70\x00\xbd\x02\x8e\x00\x5f\x00\xee\x00\x71\x00\x0c\x01\x02\x01\x00\x01\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\x07\x01\x08\x01\xee\x02\x8f\x00\x81\x00\xc4\x02\x6f\x00\x70\x00\x62\x00\x6a\x00\x6b\x00\x6c\x00\x71\x00\x6d\x00\x81\x00\xf5\x02\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xa4\xfe\x53\x01\x54\x01\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\x6a\x00\x6b\x00\x6c\x00\xf0\x02\x6d\x00\xef\x00\xf0\x00\xf1\x00\xc8\x02\x6a\x00\x6b\x00\x6c\x00\x5f\x00\x6d\x00\x2d\x01\x1e\x01\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x23\x01\x29\x01\x90\x00\x80\x00\x81\x00\x5f\x00\xf7\x02\x82\x00\xa4\xfe\x48\x02\x6a\x00\x6b\x00\x6c\x00\x9b\x01\x6d\x00\x62\x00\x9e\x01\x24\x01\x24\x01\x42\x01\xf1\x02\x6d\x02\x6f\x00\x70\x00\xf2\x02\x8e\x00\x1f\x01\xe7\x02\x71\x00\x9b\x01\x1e\x01\x2b\x02\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xe8\x02\x25\x01\x25\x01\xea\x02\x8f\x00\xeb\x02\x6e\x02\x6f\x00\x70\x00\x62\x00\x6a\x00\x6b\x00\x6c\x00\x71\x00\x6d\x00\x81\x02\x6f\x00\x70\x00\xb1\x02\x27\x01\xec\x02\x5f\x00\x71\x00\xca\xfe\x8e\x00\x1f\x01\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\xd9\x02\x81\x00\x81\x00\xdb\x02\xe1\x02\x88\x02\x6f\x00\x70\x00\x8f\x00\x6a\x00\x6b\x00\x6c\x00\x71\x00\x6d\x00\x8e\x00\xdc\x02\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x25\x02\x27\x01\x90\x00\x80\x00\x81\x00\x5f\x00\xdd\x02\x82\x00\xca\xfe\x8f\x00\x6a\x00\x6b\x00\x6c\x00\x62\x00\x6d\x00\x84\x00\x85\x00\x86\x00\x87\x00\xe2\x02\x88\x00\x1c\x02\x6f\x00\x70\x00\xde\x02\xdf\x02\x1e\x01\xe0\x02\x71\x00\x29\x01\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x4c\x01\x4d\x01\x4e\x01\x90\x00\x80\x00\x81\x00\x5f\x00\xe3\x02\x82\x00\xca\xfe\x6a\x00\x6b\x00\x6c\x00\xb7\x02\x6d\x00\x62\x00\xb8\x02\xc1\x01\x6f\x00\x70\x00\xba\x02\x3e\x02\x2c\x01\x1f\x01\x71\x00\xbf\x02\x90\x00\x80\x00\x81\x00\x5f\x00\x81\x00\x82\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\x5f\x00\xc5\x01\x6f\x00\x70\x00\x89\x00\x8a\x00\x8b\x00\x9b\x01\x71\x00\x6a\x00\x6b\x00\x6c\x00\x29\x01\x6d\x00\x26\x02\x27\x01\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x0f\x01\x1e\x01\x84\x00\x85\x00\x86\x00\x87\x00\x62\x00\x88\x00\x90\x00\x91\x00\x6a\x00\x6b\x00\x6c\x00\xc0\x02\x6d\x00\xd8\x01\x6f\x00\x70\x00\x3f\x02\x2c\x01\x0f\x01\xc3\x02\x71\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\x84\x00\x85\x00\x86\x00\x87\x00\x1f\x01\x88\x00\x8d\x01\xc6\x02\x14\x01\x6a\x00\x6b\x00\x6c\x00\x2d\x01\x6d\x00\xfd\x00\xc7\x02\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\xdd\x01\x6f\x00\x70\x00\x13\x01\xc8\x02\x14\x01\x76\x01\x71\x00\xcb\x02\x6a\x00\x6b\x00\x6c\x00\x25\x01\x6d\x00\xf9\x01\x8b\x00\x42\x01\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\xcc\x02\xe0\x01\x6f\x00\x70\x00\xcd\x02\x62\x00\xce\x02\x29\x01\x71\x00\xd4\x02\x6a\x00\x6b\x00\x6c\x00\x03\x01\x6d\x00\x04\x01\x00\x01\xcf\x02\xd0\x02\xbb\x00\x8a\x00\x8b\x00\x8f\x02\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\xd1\x02\xe1\x01\x6f\x00\x70\x00\x9c\x02\xbe\x00\x2b\x01\x2c\x01\x71\x00\x6a\x00\x6b\x00\x6c\x00\x2d\x01\x6d\x00\x81\x00\xd2\x02\xd3\x02\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x62\x00\xd5\x02\xd1\x00\x6f\x00\x70\x00\x4a\x02\x8d\x02\x93\x02\x46\x01\x71\x00\x6a\x00\x6b\x00\x6c\x00\x94\x02\x6d\x00\x81\x00\x09\x01\x40\x01\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x5f\x00\x9a\x02\x8e\x00\xc7\x00\x70\x00\x5f\x00\x9c\x02\x9e\x02\xd5\x01\x71\x00\x6a\x00\x6b\x00\x6c\x00\xa2\x02\x6d\x00\x84\x00\x85\x00\x86\x00\x87\x00\x8f\x00\x88\x00\x9f\x02\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\x37\x02\x2d\x01\x16\x01\xc7\x00\x70\x00\xe4\x00\x12\x01\xa0\x02\xc8\x00\x71\x00\xca\xfe\xa3\x02\x81\x00\xbf\x00\x84\x00\x85\x00\x86\x00\x87\x00\x41\x01\x88\x00\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\xd0\x00\x70\x00\x42\x01\xab\x02\xac\x02\xe4\x00\x71\x00\x2f\x01\x8d\x02\x5c\x01\x55\x01\x56\x01\x57\x01\xbf\x00\xad\x02\x81\x00\x1e\x01\xb0\x02\x90\x00\x80\x00\x81\x00\x5f\x00\xb1\x02\x82\x00\xcf\x00\xbb\x00\x8a\x00\x8b\x00\xbb\x02\x71\x00\x3a\x01\x36\x01\x58\x01\x34\x01\x54\x02\x5c\x01\x55\x01\x56\x01\x57\x01\x11\x02\xbe\x00\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\xb3\x02\xb9\x00\x1f\x01\xb6\x02\x59\x01\xe4\x00\xd3\x00\x8b\x00\x5f\x00\x59\x02\x57\x02\x58\x01\x5f\x00\xbf\x00\x84\x00\x85\x00\x86\x00\x87\x00\x09\x01\x88\x00\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\x5a\x01\x6a\x02\x5a\x02\x5c\x02\x59\x01\xe4\x00\x32\x01\x27\x01\x4f\x02\x5c\x01\x55\x01\x56\x01\x57\x01\xbf\x00\x84\x00\x85\x00\x86\x00\x87\x00\x5b\x02\x88\x00\x4e\x01\x47\x01\x48\x01\x49\x01\x17\x01\x18\x01\x5a\x01\x8e\x01\x5d\x02\x16\x01\x61\x02\xe4\x00\x58\x01\x12\x01\x5b\x01\x5c\x01\x55\x01\x56\x01\x57\x01\xbf\x00\x9b\x00\x2d\x01\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\x5e\x02\x59\x01\x60\x02\xa4\x00\xd2\x00\x62\x02\x78\x01\x8e\x00\x58\x01\x46\x01\x09\x01\x54\x01\x55\x01\x56\x01\x57\x01\x63\x02\x65\x02\x66\x02\x40\x01\x9c\x01\x68\x02\xee\x02\x69\x02\x5a\x01\x8f\x00\xe3\x00\x6c\x02\x59\x01\xdb\x00\x8a\x00\x8b\x00\x6a\x02\x70\x02\x9b\x00\x58\x01\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\xa4\xfe\x6d\x02\x15\x01\xa4\x00\x16\x01\x71\x02\x5a\x01\x2f\x01\x12\x01\x9b\x00\x59\x01\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\x73\x02\x75\x02\x77\x02\xa4\x00\x78\x02\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x76\x02\x35\x01\x36\x01\x5a\x01\x34\x01\x90\x00\x80\x00\x81\x00\x5f\x00\x5f\x00\x82\x00\xa5\x00\xa6\x00\x09\x02\xfd\x00\x84\x00\x85\x00\x86\x00\x87\x00\xee\x00\x88\x00\x9b\x00\xa8\x00\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\x7b\x02\x2d\x01\xb9\x00\xa4\x00\x9b\x00\x5f\x00\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\x1e\x01\x8e\x00\x45\x01\xa4\x00\x7e\x02\x46\x01\x80\x02\x81\x02\xbc\x02\xa5\x00\xa6\x00\x0c\x02\x84\x02\x0e\x01\x40\x01\x04\x01\x00\x01\x85\x02\x8f\x00\x86\x02\xa8\x00\x87\x02\x88\x02\xef\x00\xf0\x00\xf1\x00\xa6\x02\x8a\x02\xa5\x00\xa6\x00\xa7\x00\xfd\x00\x8b\x02\x1f\x01\xbb\x00\x8a\x00\x8b\x00\xca\xfe\x9b\x00\xa8\x00\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\xbd\x00\xbe\x00\x81\x00\xa4\x00\x9b\x00\xe6\x01\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\x1e\x01\x26\x01\x27\x01\xa4\x00\xe8\x01\xe9\x01\x82\x02\xb6\x00\x33\x02\x90\x00\x80\x00\x81\x00\x5f\x00\x0e\x01\x82\x00\x04\x01\x00\x01\xea\x01\xa8\x00\xeb\x01\x8b\x02\xb6\x00\x9b\x00\xec\x01\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\xa8\x00\x1f\x01\xf3\x01\xa4\x00\x9b\x00\xef\x01\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\x3d\x01\xf4\x01\x9b\x00\xa4\x00\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\x71\x02\xf5\x01\xfb\x01\xa4\x00\x77\x01\x32\x01\x27\x01\x44\x01\xfc\x01\x81\x00\x0b\x02\xb6\x00\x5f\x00\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x02\x02\x05\x02\xfd\x00\x1e\x01\xa8\x00\x03\x02\x0d\x02\xb6\x00\x9b\x00\x04\x02\x9c\x00\x9d\x00\x9e\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\xa8\x00\xee\x00\x06\x02\xa4\x00\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x08\x02\x07\x02\x0f\x02\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x5f\x00\x1f\x01\x5f\x00\x81\x00\xa5\x00\xb3\x00\x81\x00\x32\x02\x1a\x02\x1e\x01\x1b\x02\xee\x00\x0c\x01\x02\x01\x00\x01\xa8\x00\x5f\x00\xb5\x00\xb6\x00\xee\x00\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x81\x00\x28\x02\x3d\x01\xe8\x00\xa8\x00\xb5\x01\x32\x01\x27\x01\xef\x00\xf0\x00\xf1\x00\xb3\x02\x3c\x02\x3d\x02\x3e\x02\x4c\x02\xa8\x00\x1f\x01\x43\x01\xee\x00\x81\x00\x44\x01\x74\x00\x5c\x00\x52\x02\x75\x00\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x74\x01\x53\x02\x2f\x01\x76\x00\xef\x00\xf0\x00\xf1\x00\x29\x02\x77\x00\xff\xff\xb4\x00\x39\x02\xef\x00\xf0\x00\xf1\x00\x50\x02\x32\x01\x27\x01\x6e\x01\xee\x00\x6f\x01\xa8\x00\x84\x00\x85\x00\x86\x00\x87\x00\x41\x02\x88\x00\x34\x01\x78\x00\x72\x01\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\xff\xff\xef\x00\xf0\x00\xf1\x00\xf2\x00\x74\x00\xff\xff\x5f\x00\x75\x00\x79\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x74\x01\x76\x00\x2f\x01\xee\x00\xff\xff\xff\xff\x77\x00\x81\x00\xff\xff\x7a\x01\x80\x00\x81\x00\x5f\x00\x74\x00\x82\x00\x7b\x01\x75\x00\x2c\x02\xf1\x00\x1e\x02\x74\x00\xff\xff\xba\x02\x75\x00\x3c\x01\x76\x00\x38\x01\x78\x00\x34\x01\x7c\x01\x77\x00\xda\x00\x76\x00\x2f\x01\xdb\x00\x8a\x00\x8b\x00\x77\x00\xff\xff\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x7d\x01\x78\x00\xa4\x02\xf0\x00\xf1\x00\x37\x01\xff\xff\x38\x01\x78\x00\x34\x01\x80\x00\x81\x00\x5f\x00\xee\x00\x82\x00\x7e\x01\x7f\x01\x79\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\xff\xff\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\xfd\x00\x74\x00\x80\x01\x80\x00\x81\x00\x5f\x00\xff\xff\x82\x00\x81\x01\xff\xff\x80\x00\x81\x00\x5f\x00\x76\x00\x82\x00\x82\x01\xff\xff\x83\x01\x77\x00\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\xff\xff\x84\x01\xa5\x02\xf0\x00\xf1\x00\xff\xff\x85\x01\x86\x01\xff\xff\x8b\x01\x78\x00\x0b\x01\xff\xff\x8c\x01\xee\x00\x8d\x01\x0c\x01\x02\x01\x00\x01\xee\x00\xff\xff\x92\x01\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x81\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x80\x00\x81\x00\x5f\x00\xee\x00\x82\x00\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x84\x00\x85\x00\x86\x00\x87\x00\xee\x00\x88\x00\x2f\x01\x90\x01\x91\x01\xee\x00\xa7\x02\xf0\x00\xf1\x00\xff\xff\xff\xff\x27\x02\xf0\x00\xf1\x00\xff\xff\xee\x00\x93\x01\xe9\x00\xea\x00\xeb\x00\xec\x00\xed\x00\x84\x00\x85\x00\x86\x00\x87\x00\x33\x01\x88\x00\x34\x01\x94\x01\xff\xff\x95\x01\x84\x00\x85\x00\x86\x00\x87\x00\xff\xff\x88\x00\x2f\x02\xf0\x00\xf1\x00\xee\x00\x84\x00\x85\x00\x86\x00\x87\x00\x96\x01\x88\x00\x97\x01\x9c\x01\xf0\x00\xf1\x00\xff\xff\x91\x02\xfb\x00\xf0\x00\xf1\x00\xe3\x00\x98\x01\xff\xff\xdb\x00\x8a\x00\x8b\x00\x99\x01\xff\xff\xfa\x00\xf1\x00\x84\x00\x85\x00\x86\x00\x87\x00\x1e\x01\x88\x00\x84\x00\x85\x00\x86\x00\x87\x00\x9a\x01\x88\x00\xa3\x02\xff\xff\x9c\x01\x9f\x01\xe3\x00\xa0\x01\xa1\x01\xdb\x00\x8a\x00\x8b\x00\x21\x02\xa2\x01\xff\xff\xf9\x00\xe3\x00\x1e\x01\x5f\x00\xdb\x00\x8a\x00\x8b\x00\xe2\x00\xff\xff\xfd\x00\xa3\x01\xe3\x00\x1f\x01\xa5\x01\xdb\x00\x8a\x00\x8b\x00\x84\x00\x85\x00\x86\x00\x87\x00\x1e\x01\x88\x00\x84\x00\x85\x00\x86\x00\x87\x00\xa6\x01\x88\x00\x84\x00\x85\x00\x86\x00\x87\x00\xff\xff\x88\x00\x1f\x01\xa7\x01\x40\x02\x1e\x01\xf6\x01\x8a\x00\x8b\x00\x32\x01\x27\x01\xa8\x01\xf8\x01\x8a\x00\x8b\x00\x0d\x01\x2f\x01\xa9\x01\xaa\x01\xff\xff\x0e\x01\x1f\x01\x04\x01\x00\x01\xff\xff\xab\x01\xff\xff\x42\x02\xac\x01\xff\xff\xad\x01\xae\x01\x32\x01\x27\x01\xaf\x01\xb0\x01\xb1\x01\x44\x02\x1f\x01\x3a\x01\x36\x01\xb4\x01\x34\x01\xff\xff\xb3\x01\x5f\x00\x43\x02\xff\xff\xcd\x01\x8a\x00\x8b\x00\x32\x01\x27\x01\xff\xff\xce\x01\x8a\x00\x8b\x00\x53\x01\x54\x01\xff\xff\xd4\x00\x8a\x00\x8b\x00\x31\x01\xff\xff\xb5\x01\xff\xff\xff\xff\x32\x01\x27\x01\xb8\x01\xff\xff\xb9\x01\xba\x01\x66\x01\x2f\x01\x51\x01\x4c\x01\x4d\x01\x4e\x01\x1b\x01\x1c\x01\xbb\x01\xb7\x01\xff\xff\xbc\x01\xbd\x01\xe8\x00\x62\x00\x5f\x00\x81\x00\xab\x00\xd8\x02\x5f\x00\xc7\x01\xc2\x00\x39\x01\xb7\x01\x3a\x01\x36\x01\xff\xff\x34\x01\x62\x00\xca\x01\xff\xff\xab\x00\xf8\x01\xb9\x00\xcd\x01\xaa\x00\xff\xff\xcc\x01\xd3\x01\xff\xff\x62\x00\xd0\x01\xd1\x01\xab\x00\xd4\x01\xd5\x01\xff\xff\x81\x00\x7f\x00\xff\xff\xac\x00\xad\x00\xae\x00\xaf\x00\xb0\x00\xb1\x00\xb2\x00\xb3\x00\x74\x01\xdb\x01\xdc\x01\x5f\x00\x7f\x00\x5f\x00\xac\x00\xad\x00\xae\x00\xaf\x00\xb0\x00\xb1\x00\xb2\x00\xb3\x00\xdd\x01\x2f\x01\x7f\x00\x5f\x00\xac\x00\xad\x00\xae\x00\xaf\x00\xb0\x00\xb1\x00\xb2\x00\xb3\x00\xb7\x01\x2f\x01\xe3\x01\x5f\x00\x5f\x00\x62\x00\xe4\x01\x5c\x00\xab\x00\x45\x02\x5f\x00\x3c\x01\xaa\x00\x38\x01\xff\xff\x34\x01\x81\x00\x62\x00\x5f\x00\xb9\x00\xab\x00\x3b\x01\xc2\x00\x3c\x01\x5f\x00\x38\x01\x81\x00\x34\x01\xe8\x00\x62\x00\x5f\x00\x81\x00\xab\x00\x00\x00\x51\x01\x60\x01\x00\x00\x00\x00\x00\x00\x7f\x00\x00\x00\xac\x00\xad\x00\xae\x00\xaf\x00\xb0\x00\xb1\x00\xb2\x00\xb3\x00\x00\x00\x00\x00\x7f\x00\x5f\x00\xac\x00\xad\x00\xae\x00\xaf\x00\xb0\x00\xb1\x00\xb2\x00\xb3\x00\x53\x01\x54\x01\x7f\x00\x5f\x00\xac\x00\xad\x00\xae\x00\xaf\x00\xb0\x00\xb1\x00\xb2\x00\xb3\x00\x53\x01\x54\x01\x00\x00\x5f\x00\x00\x00\x66\x01\x60\x01\x51\x01\x4c\x01\x4d\x01\x4e\x01\x1b\x01\x1c\x01\x53\x01\x54\x01\x00\x00\x00\x00\x66\x01\xe8\x00\x51\x01\x4c\x01\x4d\x01\x4e\x01\x1b\x01\x1c\x01\x00\x00\xc2\x00\x00\x00\x00\x00\x00\x00\xe8\x00\x00\x00\x51\x01\x4c\x01\x4d\x01\x4e\x01\x1b\x01\x1c\x01\xc2\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe8\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc2\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (90, 358) [
	(90 , happyReduce_90),
	(91 , happyReduce_91),
	(92 , happyReduce_92),
	(93 , happyReduce_93),
	(94 , happyReduce_94),
	(95 , happyReduce_95),
	(96 , happyReduce_96),
	(97 , happyReduce_97),
	(98 , happyReduce_98),
	(99 , happyReduce_99),
	(100 , happyReduce_100),
	(101 , happyReduce_101),
	(102 , happyReduce_102),
	(103 , happyReduce_103),
	(104 , happyReduce_104),
	(105 , happyReduce_105),
	(106 , happyReduce_106),
	(107 , happyReduce_107),
	(108 , happyReduce_108),
	(109 , happyReduce_109),
	(110 , happyReduce_110),
	(111 , happyReduce_111),
	(112 , happyReduce_112),
	(113 , happyReduce_113),
	(114 , happyReduce_114),
	(115 , happyReduce_115),
	(116 , happyReduce_116),
	(117 , happyReduce_117),
	(118 , happyReduce_118),
	(119 , happyReduce_119),
	(120 , happyReduce_120),
	(121 , happyReduce_121),
	(122 , happyReduce_122),
	(123 , happyReduce_123),
	(124 , happyReduce_124),
	(125 , happyReduce_125),
	(126 , happyReduce_126),
	(127 , happyReduce_127),
	(128 , happyReduce_128),
	(129 , happyReduce_129),
	(130 , happyReduce_130),
	(131 , happyReduce_131),
	(132 , happyReduce_132),
	(133 , happyReduce_133),
	(134 , happyReduce_134),
	(135 , happyReduce_135),
	(136 , happyReduce_136),
	(137 , happyReduce_137),
	(138 , happyReduce_138),
	(139 , happyReduce_139),
	(140 , happyReduce_140),
	(141 , happyReduce_141),
	(142 , happyReduce_142),
	(143 , happyReduce_143),
	(144 , happyReduce_144),
	(145 , happyReduce_145),
	(146 , happyReduce_146),
	(147 , happyReduce_147),
	(148 , happyReduce_148),
	(149 , happyReduce_149),
	(150 , happyReduce_150),
	(151 , happyReduce_151),
	(152 , happyReduce_152),
	(153 , happyReduce_153),
	(154 , happyReduce_154),
	(155 , happyReduce_155),
	(156 , happyReduce_156),
	(157 , happyReduce_157),
	(158 , happyReduce_158),
	(159 , happyReduce_159),
	(160 , happyReduce_160),
	(161 , happyReduce_161),
	(162 , happyReduce_162),
	(163 , happyReduce_163),
	(164 , happyReduce_164),
	(165 , happyReduce_165),
	(166 , happyReduce_166),
	(167 , happyReduce_167),
	(168 , happyReduce_168),
	(169 , happyReduce_169),
	(170 , happyReduce_170),
	(171 , happyReduce_171),
	(172 , happyReduce_172),
	(173 , happyReduce_173),
	(174 , happyReduce_174),
	(175 , happyReduce_175),
	(176 , happyReduce_176),
	(177 , happyReduce_177),
	(178 , happyReduce_178),
	(179 , happyReduce_179),
	(180 , happyReduce_180),
	(181 , happyReduce_181),
	(182 , happyReduce_182),
	(183 , happyReduce_183),
	(184 , happyReduce_184),
	(185 , happyReduce_185),
	(186 , happyReduce_186),
	(187 , happyReduce_187),
	(188 , happyReduce_188),
	(189 , happyReduce_189),
	(190 , happyReduce_190),
	(191 , happyReduce_191),
	(192 , happyReduce_192),
	(193 , happyReduce_193),
	(194 , happyReduce_194),
	(195 , happyReduce_195),
	(196 , happyReduce_196),
	(197 , happyReduce_197),
	(198 , happyReduce_198),
	(199 , happyReduce_199),
	(200 , happyReduce_200),
	(201 , happyReduce_201),
	(202 , happyReduce_202),
	(203 , happyReduce_203),
	(204 , happyReduce_204),
	(205 , happyReduce_205),
	(206 , happyReduce_206),
	(207 , happyReduce_207),
	(208 , happyReduce_208),
	(209 , happyReduce_209),
	(210 , happyReduce_210),
	(211 , happyReduce_211),
	(212 , happyReduce_212),
	(213 , happyReduce_213),
	(214 , happyReduce_214),
	(215 , happyReduce_215),
	(216 , happyReduce_216),
	(217 , happyReduce_217),
	(218 , happyReduce_218),
	(219 , happyReduce_219),
	(220 , happyReduce_220),
	(221 , happyReduce_221),
	(222 , happyReduce_222),
	(223 , happyReduce_223),
	(224 , happyReduce_224),
	(225 , happyReduce_225),
	(226 , happyReduce_226),
	(227 , happyReduce_227),
	(228 , happyReduce_228),
	(229 , happyReduce_229),
	(230 , happyReduce_230),
	(231 , happyReduce_231),
	(232 , happyReduce_232),
	(233 , happyReduce_233),
	(234 , happyReduce_234),
	(235 , happyReduce_235),
	(236 , happyReduce_236),
	(237 , happyReduce_237),
	(238 , happyReduce_238),
	(239 , happyReduce_239),
	(240 , happyReduce_240),
	(241 , happyReduce_241),
	(242 , happyReduce_242),
	(243 , happyReduce_243),
	(244 , happyReduce_244),
	(245 , happyReduce_245),
	(246 , happyReduce_246),
	(247 , happyReduce_247),
	(248 , happyReduce_248),
	(249 , happyReduce_249),
	(250 , happyReduce_250),
	(251 , happyReduce_251),
	(252 , happyReduce_252),
	(253 , happyReduce_253),
	(254 , happyReduce_254),
	(255 , happyReduce_255),
	(256 , happyReduce_256),
	(257 , happyReduce_257),
	(258 , happyReduce_258),
	(259 , happyReduce_259),
	(260 , happyReduce_260),
	(261 , happyReduce_261),
	(262 , happyReduce_262),
	(263 , happyReduce_263),
	(264 , happyReduce_264),
	(265 , happyReduce_265),
	(266 , happyReduce_266),
	(267 , happyReduce_267),
	(268 , happyReduce_268),
	(269 , happyReduce_269),
	(270 , happyReduce_270),
	(271 , happyReduce_271),
	(272 , happyReduce_272),
	(273 , happyReduce_273),
	(274 , happyReduce_274),
	(275 , happyReduce_275),
	(276 , happyReduce_276),
	(277 , happyReduce_277),
	(278 , happyReduce_278),
	(279 , happyReduce_279),
	(280 , happyReduce_280),
	(281 , happyReduce_281),
	(282 , happyReduce_282),
	(283 , happyReduce_283),
	(284 , happyReduce_284),
	(285 , happyReduce_285),
	(286 , happyReduce_286),
	(287 , happyReduce_287),
	(288 , happyReduce_288),
	(289 , happyReduce_289),
	(290 , happyReduce_290),
	(291 , happyReduce_291),
	(292 , happyReduce_292),
	(293 , happyReduce_293),
	(294 , happyReduce_294),
	(295 , happyReduce_295),
	(296 , happyReduce_296),
	(297 , happyReduce_297),
	(298 , happyReduce_298),
	(299 , happyReduce_299),
	(300 , happyReduce_300),
	(301 , happyReduce_301),
	(302 , happyReduce_302),
	(303 , happyReduce_303),
	(304 , happyReduce_304),
	(305 , happyReduce_305),
	(306 , happyReduce_306),
	(307 , happyReduce_307),
	(308 , happyReduce_308),
	(309 , happyReduce_309),
	(310 , happyReduce_310),
	(311 , happyReduce_311),
	(312 , happyReduce_312),
	(313 , happyReduce_313),
	(314 , happyReduce_314),
	(315 , happyReduce_315),
	(316 , happyReduce_316),
	(317 , happyReduce_317),
	(318 , happyReduce_318),
	(319 , happyReduce_319),
	(320 , happyReduce_320),
	(321 , happyReduce_321),
	(322 , happyReduce_322),
	(323 , happyReduce_323),
	(324 , happyReduce_324),
	(325 , happyReduce_325),
	(326 , happyReduce_326),
	(327 , happyReduce_327),
	(328 , happyReduce_328),
	(329 , happyReduce_329),
	(330 , happyReduce_330),
	(331 , happyReduce_331),
	(332 , happyReduce_332),
	(333 , happyReduce_333),
	(334 , happyReduce_334),
	(335 , happyReduce_335),
	(336 , happyReduce_336),
	(337 , happyReduce_337),
	(338 , happyReduce_338),
	(339 , happyReduce_339),
	(340 , happyReduce_340),
	(341 , happyReduce_341),
	(342 , happyReduce_342),
	(343 , happyReduce_343),
	(344 , happyReduce_344),
	(345 , happyReduce_345),
	(346 , happyReduce_346),
	(347 , happyReduce_347),
	(348 , happyReduce_348),
	(349 , happyReduce_349),
	(350 , happyReduce_350),
	(351 , happyReduce_351),
	(352 , happyReduce_352),
	(353 , happyReduce_353),
	(354 , happyReduce_354),
	(355 , happyReduce_355),
	(356 , happyReduce_356),
	(357 , happyReduce_357),
	(358 , happyReduce_358)
	]

happy_n_terms = 78 :: Int
happy_n_nonterms = 129 :: Int

happyReduce_90 = happySpecReduce_1  0# happyReduction_90
happyReduction_90 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TI happy_var_1)) -> 
	happyIn93
		 ((read ( happy_var_1)) :: Integer
	)}

happyReduce_91 = happySpecReduce_1  1# happyReduction_91
happyReduction_91 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TD happy_var_1)) -> 
	happyIn94
		 ((read ( happy_var_1)) :: Double
	)}

happyReduce_92 = happySpecReduce_1  2# happyReduction_92
happyReduction_92 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn95
		 (TokUnit (mkPosToken happy_var_1)
	)}

happyReduce_93 = happySpecReduce_1  3# happyReduction_93
happyReduction_93 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn96
		 (TokDefn (mkPosToken happy_var_1)
	)}

happyReduce_94 = happySpecReduce_1  4# happyReduction_94
happyReduction_94 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn97
		 (TokRun (mkPosToken happy_var_1)
	)}

happyReduce_95 = happySpecReduce_1  5# happyReduction_95
happyReduction_95 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn98
		 (TokTerm (mkPosToken happy_var_1)
	)}

happyReduce_96 = happySpecReduce_1  6# happyReduction_96
happyReduction_96 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn99
		 (TokData (mkPosToken happy_var_1)
	)}

happyReduce_97 = happySpecReduce_1  7# happyReduction_97
happyReduction_97 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn100
		 (TokCodata (mkPosToken happy_var_1)
	)}

happyReduce_98 = happySpecReduce_1  8# happyReduction_98
happyReduction_98 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn101
		 (TokType (mkPosToken happy_var_1)
	)}

happyReduce_99 = happySpecReduce_1  9# happyReduction_99
happyReduction_99 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn102
		 (TokProtocol (mkPosToken happy_var_1)
	)}

happyReduce_100 = happySpecReduce_1  10# happyReduction_100
happyReduction_100 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn103
		 (TokCoprotocol (mkPosToken happy_var_1)
	)}

happyReduce_101 = happySpecReduce_1  11# happyReduction_101
happyReduction_101 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn104
		 (TokGetProt (mkPosToken happy_var_1)
	)}

happyReduce_102 = happySpecReduce_1  12# happyReduction_102
happyReduction_102 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn105
		 (TokPutProt (mkPosToken happy_var_1)
	)}

happyReduce_103 = happySpecReduce_1  13# happyReduction_103
happyReduction_103 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn106
		 (TokNeg (mkPosToken happy_var_1)
	)}

happyReduce_104 = happySpecReduce_1  14# happyReduction_104
happyReduction_104 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn107
		 (TokTop (mkPosToken happy_var_1)
	)}

happyReduce_105 = happySpecReduce_1  15# happyReduction_105
happyReduction_105 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (TokBot (mkPosToken happy_var_1)
	)}

happyReduce_106 = happySpecReduce_1  16# happyReduction_106
happyReduction_106 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn109
		 (TokFun (mkPosToken happy_var_1)
	)}

happyReduce_107 = happySpecReduce_1  17# happyReduction_107
happyReduction_107 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn110
		 (TokDefault (mkPosToken happy_var_1)
	)}

happyReduce_108 = happySpecReduce_1  18# happyReduction_108
happyReduction_108 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn111
		 (TokRecord (mkPosToken happy_var_1)
	)}

happyReduce_109 = happySpecReduce_1  19# happyReduction_109
happyReduction_109 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn112
		 (TokLet (mkPosToken happy_var_1)
	)}

happyReduce_110 = happySpecReduce_1  20# happyReduction_110
happyReduction_110 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn113
		 (TokIf (mkPosToken happy_var_1)
	)}

happyReduce_111 = happySpecReduce_1  21# happyReduction_111
happyReduction_111 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn114
		 (TokFold (mkPosToken happy_var_1)
	)}

happyReduce_112 = happySpecReduce_1  22# happyReduction_112
happyReduction_112 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn115
		 (TokUnfold (mkPosToken happy_var_1)
	)}

happyReduce_113 = happySpecReduce_1  23# happyReduction_113
happyReduction_113 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn116
		 (TokCase (mkPosToken happy_var_1)
	)}

happyReduce_114 = happySpecReduce_1  24# happyReduction_114
happyReduction_114 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn117
		 (TokProc (mkPosToken happy_var_1)
	)}

happyReduce_115 = happySpecReduce_1  25# happyReduction_115
happyReduction_115 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn118
		 (TokClose (mkPosToken happy_var_1)
	)}

happyReduce_116 = happySpecReduce_1  26# happyReduction_116
happyReduction_116 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn119
		 (TokHalt (mkPosToken happy_var_1)
	)}

happyReduce_117 = happySpecReduce_1  27# happyReduction_117
happyReduction_117 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn120
		 (TokGet (mkPosToken happy_var_1)
	)}

happyReduce_118 = happySpecReduce_1  28# happyReduction_118
happyReduction_118 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn121
		 (TokPut (mkPosToken happy_var_1)
	)}

happyReduce_119 = happySpecReduce_1  29# happyReduction_119
happyReduction_119 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn122
		 (TokHCase (mkPosToken happy_var_1)
	)}

happyReduce_120 = happySpecReduce_1  30# happyReduction_120
happyReduction_120 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn123
		 (TokHPut (mkPosToken happy_var_1)
	)}

happyReduce_121 = happySpecReduce_1  31# happyReduction_121
happyReduction_121 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn124
		 (TokSplit (mkPosToken happy_var_1)
	)}

happyReduce_122 = happySpecReduce_1  32# happyReduction_122
happyReduction_122 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn125
		 (TokFork (mkPosToken happy_var_1)
	)}

happyReduce_123 = happySpecReduce_1  33# happyReduction_123
happyReduction_123 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn126
		 (TokDCare (mkPosToken happy_var_1)
	)}

happyReduce_124 = happySpecReduce_1  34# happyReduction_124
happyReduction_124 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn127
		 (TokString (mkPosToken happy_var_1)
	)}

happyReduce_125 = happySpecReduce_1  35# happyReduction_125
happyReduction_125 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn128
		 (UIdent (mkPosToken happy_var_1)
	)}

happyReduce_126 = happySpecReduce_1  36# happyReduction_126
happyReduction_126 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn129
		 (PIdent (mkPosToken happy_var_1)
	)}

happyReduce_127 = happySpecReduce_1  37# happyReduction_127
happyReduction_127 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn130
		 (InfixRem (mkPosToken happy_var_1)
	)}

happyReduce_128 = happySpecReduce_1  38# happyReduction_128
happyReduction_128 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn131
		 (PInteger (mkPosToken happy_var_1)
	)}

happyReduce_129 = happySpecReduce_2  39# happyReduction_129
happyReduction_129 happy_x_2
	happy_x_1
	 =  case happyOut133 happy_x_1 of { happy_var_1 -> 
	case happyOut137 happy_x_2 of { happy_var_2 -> 
	happyIn132
		 (AbsMPL.MPLPROG (reverse happy_var_1) happy_var_2
	)}}

happyReduce_130 = happySpecReduce_1  39# happyReduction_130
happyReduction_130 happy_x_1
	 =  case happyOut133 happy_x_1 of { happy_var_1 -> 
	happyIn132
		 (AbsMPL.MPLTest (reverse happy_var_1)
	)}

happyReduce_131 = happySpecReduce_0  40# happyReduction_131
happyReduction_131  =  happyIn133
		 ([]
	)

happyReduce_132 = happySpecReduce_2  40# happyReduction_132
happyReduction_132 happy_x_2
	happy_x_1
	 =  case happyOut133 happy_x_1 of { happy_var_1 -> 
	case happyOut134 happy_x_2 of { happy_var_2 -> 
	happyIn133
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_133 = happyReduce 9# 41# happyReduction_133
happyReduction_133 (happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut96 happy_x_1 of { happy_var_1 -> 
	case happyOut138 happy_x_4 of { happy_var_4 -> 
	case happyOut136 happy_x_8 of { happy_var_8 -> 
	happyIn134
		 (AbsMPL.WHEREDEFN happy_var_1 happy_var_4 happy_var_8
	) `HappyStk` happyRest}}}

happyReduce_134 = happyReduce 5# 41# happyReduction_134
happyReduction_134 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut96 happy_x_1 of { happy_var_1 -> 
	case happyOut138 happy_x_4 of { happy_var_4 -> 
	happyIn134
		 (AbsMPL.WOWHEREDEFN happy_var_1 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_135 = happySpecReduce_1  41# happyReduction_135
happyReduction_135 happy_x_1
	 =  case happyOut139 happy_x_1 of { happy_var_1 -> 
	happyIn134
		 (AbsMPL.BAREDEFN happy_var_1
	)}

happyReduce_136 = happySpecReduce_1  42# happyReduction_136
happyReduction_136 happy_x_1
	 =  case happyOut134 happy_x_1 of { happy_var_1 -> 
	happyIn135
		 (AbsMPL.MPLSTMTALT happy_var_1
	)}

happyReduce_137 = happySpecReduce_0  43# happyReduction_137
happyReduction_137  =  happyIn136
		 ([]
	)

happyReduce_138 = happySpecReduce_1  43# happyReduction_138
happyReduction_138 happy_x_1
	 =  case happyOut135 happy_x_1 of { happy_var_1 -> 
	happyIn136
		 ((:[]) happy_var_1
	)}

happyReduce_139 = happySpecReduce_3  43# happyReduction_139
happyReduction_139 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut135 happy_x_1 of { happy_var_1 -> 
	case happyOut136 happy_x_3 of { happy_var_3 -> 
	happyIn136
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_140 = happyReduce 12# 44# happyReduction_140
happyReduction_140 (happy_x_12 `HappyStk`
	happy_x_11 `HappyStk`
	happy_x_10 `HappyStk`
	happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut97 happy_x_1 of { happy_var_1 -> 
	case happyOut180 happy_x_3 of { happy_var_3 -> 
	case happyOut180 happy_x_5 of { happy_var_5 -> 
	case happyOut206 happy_x_8 of { happy_var_8 -> 
	case happyOut206 happy_x_10 of { happy_var_10 -> 
	case happyOut207 happy_x_11 of { happy_var_11 -> 
	happyIn137
		 (AbsMPL.RUNSTMTWITHType happy_var_1 happy_var_3 happy_var_5 happy_var_8 happy_var_10 happy_var_11
	) `HappyStk` happyRest}}}}}}

happyReduce_141 = happyReduce 5# 44# happyReduction_141
happyReduction_141 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut97 happy_x_1 of { happy_var_1 -> 
	case happyOut206 happy_x_2 of { happy_var_2 -> 
	case happyOut206 happy_x_4 of { happy_var_4 -> 
	case happyOut207 happy_x_5 of { happy_var_5 -> 
	happyIn137
		 (AbsMPL.RUNSTMTWITHTOUType happy_var_1 happy_var_2 happy_var_4 happy_var_5
	) `HappyStk` happyRest}}}}

happyReduce_142 = happySpecReduce_0  45# happyReduction_142
happyReduction_142  =  happyIn138
		 ([]
	)

happyReduce_143 = happySpecReduce_1  45# happyReduction_143
happyReduction_143 happy_x_1
	 =  case happyOut139 happy_x_1 of { happy_var_1 -> 
	happyIn138
		 ((:[]) happy_var_1
	)}

happyReduce_144 = happySpecReduce_3  45# happyReduction_144
happyReduction_144 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut139 happy_x_1 of { happy_var_1 -> 
	case happyOut138 happy_x_3 of { happy_var_3 -> 
	happyIn138
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_145 = happySpecReduce_1  46# happyReduction_145
happyReduction_145 happy_x_1
	 =  case happyOut142 happy_x_1 of { happy_var_1 -> 
	happyIn139
		 (AbsMPL.TYPEDEF happy_var_1
	)}

happyReduce_146 = happySpecReduce_1  46# happyReduction_146
happyReduction_146 happy_x_1
	 =  case happyOut162 happy_x_1 of { happy_var_1 -> 
	happyIn139
		 (AbsMPL.PROTOCOLDEF happy_var_1
	)}

happyReduce_147 = happySpecReduce_1  46# happyReduction_147
happyReduction_147 happy_x_1
	 =  case happyOut181 happy_x_1 of { happy_var_1 -> 
	happyIn139
		 (AbsMPL.FUNCTIONDEF happy_var_1
	)}

happyReduce_148 = happySpecReduce_1  46# happyReduction_148
happyReduction_148 happy_x_1
	 =  case happyOut140 happy_x_1 of { happy_var_1 -> 
	happyIn139
		 (AbsMPL.OPERATORDEF happy_var_1
	)}

happyReduce_149 = happySpecReduce_1  46# happyReduction_149
happyReduction_149 happy_x_1
	 =  case happyOut203 happy_x_1 of { happy_var_1 -> 
	happyIn139
		 (AbsMPL.PROCESSDEF happy_var_1
	)}

happyReduce_150 = happySpecReduce_1  46# happyReduction_150
happyReduction_150 happy_x_1
	 =  case happyOut141 happy_x_1 of { happy_var_1 -> 
	happyIn139
		 (AbsMPL.TERMSYNDEF happy_var_1
	)}

happyReduce_151 = happySpecReduce_3  47# happyReduction_151
happyReduction_151 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut130 happy_x_2 of { happy_var_2 -> 
	case happyOut93 happy_x_3 of { happy_var_3 -> 
	happyIn140
		 (AbsMPL.INFIX_LEFT happy_var_2 happy_var_3
	)}}

happyReduce_152 = happySpecReduce_3  47# happyReduction_152
happyReduction_152 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut130 happy_x_2 of { happy_var_2 -> 
	case happyOut93 happy_x_3 of { happy_var_3 -> 
	happyIn140
		 (AbsMPL.INFIX_RIGHT happy_var_2 happy_var_3
	)}}

happyReduce_153 = happyReduce 11# 48# happyReduction_153
happyReduction_153 (happy_x_11 `HappyStk`
	happy_x_10 `HappyStk`
	happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut98 happy_x_1 of { happy_var_1 -> 
	case happyOut129 happy_x_2 of { happy_var_2 -> 
	case happyOut130 happy_x_3 of { happy_var_3 -> 
	case happyOut129 happy_x_4 of { happy_var_4 -> 
	case happyOut129 happy_x_6 of { happy_var_6 -> 
	case happyOut129 happy_x_8 of { happy_var_8 -> 
	case happyOut129 happy_x_10 of { happy_var_10 -> 
	happyIn141
		 (AbsMPL.TERM_SYNONYM happy_var_1 happy_var_2 happy_var_3 happy_var_4 happy_var_6 happy_var_8 happy_var_10
	) `HappyStk` happyRest}}}}}}}

happyReduce_154 = happySpecReduce_2  49# happyReduction_154
happyReduction_154 happy_x_2
	happy_x_1
	 =  case happyOut99 happy_x_1 of { happy_var_1 -> 
	case happyOut143 happy_x_2 of { happy_var_2 -> 
	happyIn142
		 (AbsMPL.DATA happy_var_1 happy_var_2
	)}}

happyReduce_155 = happySpecReduce_2  49# happyReduction_155
happyReduction_155 happy_x_2
	happy_x_1
	 =  case happyOut100 happy_x_1 of { happy_var_1 -> 
	case happyOut144 happy_x_2 of { happy_var_2 -> 
	happyIn142
		 (AbsMPL.CODATA happy_var_1 happy_var_2
	)}}

happyReduce_156 = happyReduce 6# 49# happyReduction_156
happyReduction_156 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut101 happy_x_1 of { happy_var_1 -> 
	case happyOut145 happy_x_2 of { happy_var_2 -> 
	case happyOut158 happy_x_5 of { happy_var_5 -> 
	happyIn142
		 (AbsMPL.TYPE happy_var_1 happy_var_2 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_157 = happySpecReduce_1  50# happyReduction_157
happyReduction_157 happy_x_1
	 =  case happyOut146 happy_x_1 of { happy_var_1 -> 
	happyIn143
		 ((:[]) happy_var_1
	)}

happyReduce_158 = happySpecReduce_3  50# happyReduction_158
happyReduction_158 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut146 happy_x_1 of { happy_var_1 -> 
	case happyOut143 happy_x_3 of { happy_var_3 -> 
	happyIn143
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_159 = happySpecReduce_1  51# happyReduction_159
happyReduction_159 happy_x_1
	 =  case happyOut147 happy_x_1 of { happy_var_1 -> 
	happyIn144
		 ((:[]) happy_var_1
	)}

happyReduce_160 = happySpecReduce_3  51# happyReduction_160
happyReduction_160 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut147 happy_x_1 of { happy_var_1 -> 
	case happyOut144 happy_x_3 of { happy_var_3 -> 
	happyIn144
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_161 = happySpecReduce_0  52# happyReduction_161
happyReduction_161  =  happyIn145
		 ([]
	)

happyReduce_162 = happySpecReduce_1  52# happyReduction_162
happyReduction_162 happy_x_1
	 =  case happyOut155 happy_x_1 of { happy_var_1 -> 
	happyIn145
		 ((:[]) happy_var_1
	)}

happyReduce_163 = happySpecReduce_3  52# happyReduction_163
happyReduction_163 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut155 happy_x_1 of { happy_var_1 -> 
	case happyOut145 happy_x_3 of { happy_var_3 -> 
	happyIn145
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_164 = happyReduce 7# 53# happyReduction_164
happyReduction_164 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut155 happy_x_1 of { happy_var_1 -> 
	case happyOut128 happy_x_3 of { happy_var_3 -> 
	case happyOut148 happy_x_6 of { happy_var_6 -> 
	happyIn146
		 (AbsMPL.DATACLAUSE happy_var_1 happy_var_3 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_165 = happyReduce 7# 54# happyReduction_165
happyReduction_165 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut155 happy_x_3 of { happy_var_3 -> 
	case happyOut149 happy_x_6 of { happy_var_6 -> 
	happyIn147
		 (AbsMPL.CODATACLAUSE happy_var_1 happy_var_3 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_166 = happySpecReduce_0  55# happyReduction_166
happyReduction_166  =  happyIn148
		 ([]
	)

happyReduce_167 = happySpecReduce_1  55# happyReduction_167
happyReduction_167 happy_x_1
	 =  case happyOut150 happy_x_1 of { happy_var_1 -> 
	happyIn148
		 ((:[]) happy_var_1
	)}

happyReduce_168 = happySpecReduce_3  55# happyReduction_168
happyReduction_168 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut150 happy_x_1 of { happy_var_1 -> 
	case happyOut148 happy_x_3 of { happy_var_3 -> 
	happyIn148
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_169 = happySpecReduce_0  56# happyReduction_169
happyReduction_169  =  happyIn149
		 ([]
	)

happyReduce_170 = happySpecReduce_1  56# happyReduction_170
happyReduction_170 happy_x_1
	 =  case happyOut151 happy_x_1 of { happy_var_1 -> 
	happyIn149
		 ((:[]) happy_var_1
	)}

happyReduce_171 = happySpecReduce_3  56# happyReduction_171
happyReduction_171 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut151 happy_x_1 of { happy_var_1 -> 
	case happyOut149 happy_x_3 of { happy_var_3 -> 
	happyIn149
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_172 = happyReduce 5# 57# happyReduction_172
happyReduction_172 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut152 happy_x_1 of { happy_var_1 -> 
	case happyOut153 happy_x_3 of { happy_var_3 -> 
	case happyOut128 happy_x_5 of { happy_var_5 -> 
	happyIn150
		 (AbsMPL.DATAPHRASE happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_173 = happyReduce 5# 58# happyReduction_173
happyReduction_173 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut152 happy_x_1 of { happy_var_1 -> 
	case happyOut153 happy_x_3 of { happy_var_3 -> 
	case happyOut158 happy_x_5 of { happy_var_5 -> 
	happyIn151
		 (AbsMPL.CODATAPHRASE happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_174 = happySpecReduce_1  59# happyReduction_174
happyReduction_174 happy_x_1
	 =  case happyOut154 happy_x_1 of { happy_var_1 -> 
	happyIn152
		 ((:[]) happy_var_1
	)}

happyReduce_175 = happySpecReduce_3  59# happyReduction_175
happyReduction_175 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut154 happy_x_1 of { happy_var_1 -> 
	case happyOut152 happy_x_3 of { happy_var_3 -> 
	happyIn152
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_176 = happySpecReduce_0  60# happyReduction_176
happyReduction_176  =  happyIn153
		 ([]
	)

happyReduce_177 = happySpecReduce_1  60# happyReduction_177
happyReduction_177 happy_x_1
	 =  case happyOut158 happy_x_1 of { happy_var_1 -> 
	happyIn153
		 ((:[]) happy_var_1
	)}

happyReduce_178 = happySpecReduce_3  60# happyReduction_178
happyReduction_178 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut158 happy_x_1 of { happy_var_1 -> 
	case happyOut153 happy_x_3 of { happy_var_3 -> 
	happyIn153
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_179 = happySpecReduce_1  61# happyReduction_179
happyReduction_179 happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	happyIn154
		 (AbsMPL.STRUCTOR happy_var_1
	)}

happyReduce_180 = happyReduce 4# 62# happyReduction_180
happyReduction_180 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut156 happy_x_3 of { happy_var_3 -> 
	happyIn155
		 (AbsMPL.TYPESPEC_param happy_var_1 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_181 = happySpecReduce_1  62# happyReduction_181
happyReduction_181 happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	happyIn155
		 (AbsMPL.TYPESPEC_basic happy_var_1
	)}

happyReduce_182 = happySpecReduce_0  63# happyReduction_182
happyReduction_182  =  happyIn156
		 ([]
	)

happyReduce_183 = happySpecReduce_1  63# happyReduction_183
happyReduction_183 happy_x_1
	 =  case happyOut157 happy_x_1 of { happy_var_1 -> 
	happyIn156
		 ((:[]) happy_var_1
	)}

happyReduce_184 = happySpecReduce_3  63# happyReduction_184
happyReduction_184 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut157 happy_x_1 of { happy_var_1 -> 
	case happyOut156 happy_x_3 of { happy_var_3 -> 
	happyIn156
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_185 = happySpecReduce_1  64# happyReduction_185
happyReduction_185 happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	happyIn157
		 (AbsMPL.TYPEPARAM happy_var_1
	)}

happyReduce_186 = happyReduce 5# 65# happyReduction_186
happyReduction_186 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut160 happy_x_2 of { happy_var_2 -> 
	case happyOut159 happy_x_4 of { happy_var_4 -> 
	happyIn158
		 (AbsMPL.TYPEARROW happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_187 = happySpecReduce_1  65# happyReduction_187
happyReduction_187 happy_x_1
	 =  case happyOut159 happy_x_1 of { happy_var_1 -> 
	happyIn158
		 (AbsMPL.TYPENext happy_var_1
	)}

happyReduce_188 = happySpecReduce_1  66# happyReduction_188
happyReduction_188 happy_x_1
	 =  case happyOut95 happy_x_1 of { happy_var_1 -> 
	happyIn159
		 (AbsMPL.TYPEUNIT happy_var_1
	)}

happyReduce_189 = happySpecReduce_3  66# happyReduction_189
happyReduction_189 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut159 happy_x_2 of { happy_var_2 -> 
	happyIn159
		 (AbsMPL.TYPELIST happy_var_2
	)}

happyReduce_190 = happyReduce 4# 66# happyReduction_190
happyReduction_190 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut153 happy_x_3 of { happy_var_3 -> 
	happyIn159
		 (AbsMPL.TYPEDATCODAT happy_var_1 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_191 = happySpecReduce_1  66# happyReduction_191
happyReduction_191 happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	happyIn159
		 (AbsMPL.TYPECONST_VAR happy_var_1
	)}

happyReduce_192 = happySpecReduce_3  66# happyReduction_192
happyReduction_192 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut159 happy_x_2 of { happy_var_2 -> 
	happyIn159
		 (AbsMPL.TYPEBRACKET happy_var_2
	)}

happyReduce_193 = happySpecReduce_0  67# happyReduction_193
happyReduction_193  =  happyIn160
		 ([]
	)

happyReduce_194 = happySpecReduce_1  67# happyReduction_194
happyReduction_194 happy_x_1
	 =  case happyOut159 happy_x_1 of { happy_var_1 -> 
	happyIn160
		 ((:[]) happy_var_1
	)}

happyReduce_195 = happySpecReduce_3  67# happyReduction_195
happyReduction_195 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut159 happy_x_1 of { happy_var_1 -> 
	case happyOut160 happy_x_3 of { happy_var_3 -> 
	happyIn160
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_196 = happySpecReduce_0  68# happyReduction_196
happyReduction_196  =  happyIn161
		 ([]
	)

happyReduce_197 = happySpecReduce_1  68# happyReduction_197
happyReduction_197 happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	happyIn161
		 ((:[]) happy_var_1
	)}

happyReduce_198 = happySpecReduce_3  68# happyReduction_198
happyReduction_198 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut161 happy_x_3 of { happy_var_3 -> 
	happyIn161
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_199 = happySpecReduce_2  69# happyReduction_199
happyReduction_199 happy_x_2
	happy_x_1
	 =  case happyOut102 happy_x_1 of { happy_var_1 -> 
	case happyOut163 happy_x_2 of { happy_var_2 -> 
	happyIn162
		 (AbsMPL.PROTOCOL happy_var_1 happy_var_2
	)}}

happyReduce_200 = happySpecReduce_2  69# happyReduction_200
happyReduction_200 happy_x_2
	happy_x_1
	 =  case happyOut103 happy_x_1 of { happy_var_1 -> 
	case happyOut164 happy_x_2 of { happy_var_2 -> 
	happyIn162
		 (AbsMPL.COPROTOCOL happy_var_1 happy_var_2
	)}}

happyReduce_201 = happySpecReduce_1  70# happyReduction_201
happyReduction_201 happy_x_1
	 =  case happyOut165 happy_x_1 of { happy_var_1 -> 
	happyIn163
		 ((:[]) happy_var_1
	)}

happyReduce_202 = happySpecReduce_3  70# happyReduction_202
happyReduction_202 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut165 happy_x_1 of { happy_var_1 -> 
	case happyOut163 happy_x_3 of { happy_var_3 -> 
	happyIn163
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_203 = happySpecReduce_1  71# happyReduction_203
happyReduction_203 happy_x_1
	 =  case happyOut166 happy_x_1 of { happy_var_1 -> 
	happyIn164
		 ((:[]) happy_var_1
	)}

happyReduce_204 = happySpecReduce_3  71# happyReduction_204
happyReduction_204 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut166 happy_x_1 of { happy_var_1 -> 
	case happyOut164 happy_x_3 of { happy_var_3 -> 
	happyIn164
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_205 = happyReduce 7# 72# happyReduction_205
happyReduction_205 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut169 happy_x_1 of { happy_var_1 -> 
	case happyOut128 happy_x_3 of { happy_var_3 -> 
	case happyOut167 happy_x_6 of { happy_var_6 -> 
	happyIn165
		 (AbsMPL.PROTOCOLCLAUSE happy_var_1 happy_var_3 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_206 = happyReduce 7# 73# happyReduction_206
happyReduction_206 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut169 happy_x_3 of { happy_var_3 -> 
	case happyOut168 happy_x_6 of { happy_var_6 -> 
	happyIn166
		 (AbsMPL.COPROTOCOLCLAUSE happy_var_1 happy_var_3 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_207 = happySpecReduce_0  74# happyReduction_207
happyReduction_207  =  happyIn167
		 ([]
	)

happyReduce_208 = happySpecReduce_1  74# happyReduction_208
happyReduction_208 happy_x_1
	 =  case happyOut172 happy_x_1 of { happy_var_1 -> 
	happyIn167
		 ((:[]) happy_var_1
	)}

happyReduce_209 = happySpecReduce_3  74# happyReduction_209
happyReduction_209 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut172 happy_x_1 of { happy_var_1 -> 
	case happyOut167 happy_x_3 of { happy_var_3 -> 
	happyIn167
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_210 = happySpecReduce_0  75# happyReduction_210
happyReduction_210  =  happyIn168
		 ([]
	)

happyReduce_211 = happySpecReduce_1  75# happyReduction_211
happyReduction_211 happy_x_1
	 =  case happyOut173 happy_x_1 of { happy_var_1 -> 
	happyIn168
		 ((:[]) happy_var_1
	)}

happyReduce_212 = happySpecReduce_3  75# happyReduction_212
happyReduction_212 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut173 happy_x_1 of { happy_var_1 -> 
	case happyOut168 happy_x_3 of { happy_var_3 -> 
	happyIn168
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_213 = happyReduce 6# 76# happyReduction_213
happyReduction_213 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut156 happy_x_3 of { happy_var_3 -> 
	case happyOut170 happy_x_5 of { happy_var_5 -> 
	happyIn169
		 (AbsMPL.PROTOCOLTYPESPEC_param happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_214 = happySpecReduce_1  76# happyReduction_214
happyReduction_214 happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	happyIn169
		 (AbsMPL.PROTOCOLTYPESPEC_noparam happy_var_1
	)}

happyReduce_215 = happySpecReduce_0  77# happyReduction_215
happyReduction_215  =  happyIn170
		 ([]
	)

happyReduce_216 = happySpecReduce_1  77# happyReduction_216
happyReduction_216 happy_x_1
	 =  case happyOut171 happy_x_1 of { happy_var_1 -> 
	happyIn170
		 ((:[]) happy_var_1
	)}

happyReduce_217 = happySpecReduce_3  77# happyReduction_217
happyReduction_217 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut171 happy_x_1 of { happy_var_1 -> 
	case happyOut170 happy_x_3 of { happy_var_3 -> 
	happyIn170
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_218 = happySpecReduce_1  78# happyReduction_218
happyReduction_218 happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	happyIn171
		 (AbsMPL.PROTOCOLPARAM happy_var_1
	)}

happyReduce_219 = happyReduce 5# 79# happyReduction_219
happyReduction_219 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut174 happy_x_1 of { happy_var_1 -> 
	case happyOut177 happy_x_3 of { happy_var_3 -> 
	case happyOut128 happy_x_5 of { happy_var_5 -> 
	happyIn172
		 (AbsMPL.PROTOCOLPHRASE happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_220 = happyReduce 5# 80# happyReduction_220
happyReduction_220 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut174 happy_x_1 of { happy_var_1 -> 
	case happyOut128 happy_x_3 of { happy_var_3 -> 
	case happyOut177 happy_x_5 of { happy_var_5 -> 
	happyIn173
		 (AbsMPL.COPROTOCOLPHRASE happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_221 = happySpecReduce_1  81# happyReduction_221
happyReduction_221 happy_x_1
	 =  case happyOut175 happy_x_1 of { happy_var_1 -> 
	happyIn174
		 ((:[]) happy_var_1
	)}

happyReduce_222 = happySpecReduce_3  81# happyReduction_222
happyReduction_222 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut175 happy_x_1 of { happy_var_1 -> 
	case happyOut174 happy_x_3 of { happy_var_3 -> 
	happyIn174
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_223 = happySpecReduce_1  82# happyReduction_223
happyReduction_223 happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	happyIn175
		 (AbsMPL.EVENTHANDLER happy_var_1
	)}

happyReduce_224 = happySpecReduce_3  83# happyReduction_224
happyReduction_224 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut128 happy_x_3 of { happy_var_3 -> 
	happyIn176
		 (AbsMPL.EVENTHANDLERHPUT happy_var_1 happy_var_3
	)}}

happyReduce_225 = happySpecReduce_1  84# happyReduction_225
happyReduction_225 happy_x_1
	 =  case happyOut178 happy_x_1 of { happy_var_1 -> 
	happyIn177
		 (happy_var_1
	)}

happyReduce_226 = happySpecReduce_3  84# happyReduction_226
happyReduction_226 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut177 happy_x_1 of { happy_var_1 -> 
	case happyOut178 happy_x_3 of { happy_var_3 -> 
	happyIn177
		 (AbsMPL.PROTOCOLtensor happy_var_1 happy_var_3
	)}}

happyReduce_227 = happySpecReduce_1  85# happyReduction_227
happyReduction_227 happy_x_1
	 =  case happyOut179 happy_x_1 of { happy_var_1 -> 
	happyIn178
		 (happy_var_1
	)}

happyReduce_228 = happySpecReduce_3  85# happyReduction_228
happyReduction_228 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut178 happy_x_1 of { happy_var_1 -> 
	case happyOut179 happy_x_3 of { happy_var_3 -> 
	happyIn178
		 (AbsMPL.PROTOCOLpar happy_var_1 happy_var_3
	)}}

happyReduce_229 = happySpecReduce_3  86# happyReduction_229
happyReduction_229 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut177 happy_x_2 of { happy_var_2 -> 
	happyIn179
		 (happy_var_2
	)}

happyReduce_230 = happyReduce 6# 86# happyReduction_230
happyReduction_230 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut104 happy_x_1 of { happy_var_1 -> 
	case happyOut158 happy_x_3 of { happy_var_3 -> 
	case happyOut177 happy_x_5 of { happy_var_5 -> 
	happyIn179
		 (AbsMPL.PROTOCOLget happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_231 = happyReduce 6# 86# happyReduction_231
happyReduction_231 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut105 happy_x_1 of { happy_var_1 -> 
	case happyOut158 happy_x_3 of { happy_var_3 -> 
	case happyOut177 happy_x_5 of { happy_var_5 -> 
	happyIn179
		 (AbsMPL.PROTOCOLput happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_232 = happyReduce 4# 86# happyReduction_232
happyReduction_232 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut106 happy_x_1 of { happy_var_1 -> 
	case happyOut177 happy_x_3 of { happy_var_3 -> 
	happyIn179
		 (AbsMPL.PROTOCOLneg happy_var_1 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_233 = happySpecReduce_1  86# happyReduction_233
happyReduction_233 happy_x_1
	 =  case happyOut107 happy_x_1 of { happy_var_1 -> 
	happyIn179
		 (AbsMPL.PROTOCOLtop happy_var_1
	)}

happyReduce_234 = happySpecReduce_1  86# happyReduction_234
happyReduction_234 happy_x_1
	 =  case happyOut108 happy_x_1 of { happy_var_1 -> 
	happyIn179
		 (AbsMPL.PROTOCOLbot happy_var_1
	)}

happyReduce_235 = happyReduce 6# 86# happyReduction_235
happyReduction_235 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut153 happy_x_3 of { happy_var_3 -> 
	case happyOut180 happy_x_5 of { happy_var_5 -> 
	happyIn179
		 (AbsMPL.ProtcolNamed happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_236 = happySpecReduce_1  86# happyReduction_236
happyReduction_236 happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	happyIn179
		 (AbsMPL.PROTOCOLvar happy_var_1
	)}

happyReduce_237 = happySpecReduce_0  87# happyReduction_237
happyReduction_237  =  happyIn180
		 ([]
	)

happyReduce_238 = happySpecReduce_1  87# happyReduction_238
happyReduction_238 happy_x_1
	 =  case happyOut177 happy_x_1 of { happy_var_1 -> 
	happyIn180
		 ((:[]) happy_var_1
	)}

happyReduce_239 = happySpecReduce_3  87# happyReduction_239
happyReduction_239 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut177 happy_x_1 of { happy_var_1 -> 
	case happyOut180 happy_x_3 of { happy_var_3 -> 
	happyIn180
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_240 = happyReduce 10# 88# happyReduction_240
happyReduction_240 (happy_x_10 `HappyStk`
	happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut109 happy_x_1 of { happy_var_1 -> 
	case happyOut129 happy_x_2 of { happy_var_2 -> 
	case happyOut153 happy_x_4 of { happy_var_4 -> 
	case happyOut158 happy_x_6 of { happy_var_6 -> 
	case happyOut183 happy_x_9 of { happy_var_9 -> 
	happyIn181
		 (AbsMPL.FUNCTIONDEFNfull happy_var_1 happy_var_2 happy_var_4 happy_var_6 happy_var_9
	) `HappyStk` happyRest}}}}}

happyReduce_241 = happyReduce 6# 88# happyReduction_241
happyReduction_241 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut109 happy_x_1 of { happy_var_1 -> 
	case happyOut129 happy_x_2 of { happy_var_2 -> 
	case happyOut183 happy_x_5 of { happy_var_5 -> 
	happyIn181
		 (AbsMPL.FUNCTIONDEFNshort happy_var_1 happy_var_2 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_242 = happySpecReduce_1  89# happyReduction_242
happyReduction_242 happy_x_1
	 =  case happyOut181 happy_x_1 of { happy_var_1 -> 
	happyIn182
		 ((:[]) happy_var_1
	)}

happyReduce_243 = happySpecReduce_3  89# happyReduction_243
happyReduction_243 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut181 happy_x_1 of { happy_var_1 -> 
	case happyOut182 happy_x_3 of { happy_var_3 -> 
	happyIn182
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_244 = happySpecReduce_1  90# happyReduction_244
happyReduction_244 happy_x_1
	 =  case happyOut187 happy_x_1 of { happy_var_1 -> 
	happyIn183
		 ((:[]) happy_var_1
	)}

happyReduce_245 = happySpecReduce_3  90# happyReduction_245
happyReduction_245 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut187 happy_x_1 of { happy_var_1 -> 
	case happyOut183 happy_x_3 of { happy_var_3 -> 
	happyIn183
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_246 = happySpecReduce_0  91# happyReduction_246
happyReduction_246  =  happyIn184
		 ([]
	)

happyReduce_247 = happySpecReduce_1  91# happyReduction_247
happyReduction_247 happy_x_1
	 =  case happyOut129 happy_x_1 of { happy_var_1 -> 
	happyIn184
		 ((:[]) happy_var_1
	)}

happyReduce_248 = happySpecReduce_3  91# happyReduction_248
happyReduction_248 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut129 happy_x_1 of { happy_var_1 -> 
	case happyOut184 happy_x_3 of { happy_var_3 -> 
	happyIn184
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_249 = happyReduce 7# 92# happyReduction_249
happyReduction_249 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut184 happy_x_3 of { happy_var_3 -> 
	case happyOut193 happy_x_6 of { happy_var_6 -> 
	happyIn185
		 (AbsMPL.FOLDPATT_WOBRAC happy_var_1 happy_var_3 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_250 = happySpecReduce_0  93# happyReduction_250
happyReduction_250  =  happyIn186
		 ([]
	)

happyReduce_251 = happySpecReduce_1  93# happyReduction_251
happyReduction_251 happy_x_1
	 =  case happyOut185 happy_x_1 of { happy_var_1 -> 
	happyIn186
		 ((:[]) happy_var_1
	)}

happyReduce_252 = happySpecReduce_3  93# happyReduction_252
happyReduction_252 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut185 happy_x_1 of { happy_var_1 -> 
	case happyOut186 happy_x_3 of { happy_var_3 -> 
	happyIn186
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_253 = happySpecReduce_3  94# happyReduction_253
happyReduction_253 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut190 happy_x_1 of { happy_var_1 -> 
	case happyOut193 happy_x_3 of { happy_var_3 -> 
	happyIn187
		 (AbsMPL.PATTERNshort happy_var_1 happy_var_3
	)}}

happyReduce_254 = happyReduce 6# 94# happyReduction_254
happyReduction_254 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut190 happy_x_1 of { happy_var_1 -> 
	case happyOut188 happy_x_5 of { happy_var_5 -> 
	happyIn187
		 (AbsMPL.PATTERNguard happy_var_1 happy_var_5
	) `HappyStk` happyRest}}

happyReduce_255 = happySpecReduce_1  95# happyReduction_255
happyReduction_255 happy_x_1
	 =  case happyOut189 happy_x_1 of { happy_var_1 -> 
	happyIn188
		 ((:[]) happy_var_1
	)}

happyReduce_256 = happySpecReduce_3  95# happyReduction_256
happyReduction_256 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut189 happy_x_1 of { happy_var_1 -> 
	case happyOut188 happy_x_3 of { happy_var_3 -> 
	happyIn188
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_257 = happyReduce 5# 96# happyReduction_257
happyReduction_257 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut193 happy_x_1 of { happy_var_1 -> 
	case happyOut193 happy_x_4 of { happy_var_4 -> 
	happyIn189
		 (AbsMPL.GUARDterm happy_var_1 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_258 = happyReduce 5# 96# happyReduction_258
happyReduction_258 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut110 happy_x_1 of { happy_var_1 -> 
	case happyOut193 happy_x_4 of { happy_var_4 -> 
	happyIn189
		 (AbsMPL.GUARDother happy_var_1 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_259 = happySpecReduce_0  97# happyReduction_259
happyReduction_259  =  happyIn190
		 ([]
	)

happyReduce_260 = happySpecReduce_1  97# happyReduction_260
happyReduction_260 happy_x_1
	 =  case happyOut191 happy_x_1 of { happy_var_1 -> 
	happyIn190
		 ((:[]) happy_var_1
	)}

happyReduce_261 = happySpecReduce_3  97# happyReduction_261
happyReduction_261 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut191 happy_x_1 of { happy_var_1 -> 
	case happyOut190 happy_x_3 of { happy_var_3 -> 
	happyIn190
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_262 = happySpecReduce_3  98# happyReduction_262
happyReduction_262 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut192 happy_x_1 of { happy_var_1 -> 
	case happyOut191 happy_x_3 of { happy_var_3 -> 
	happyIn191
		 (AbsMPL.LISTPATTERN2 happy_var_1 happy_var_3
	)}}

happyReduce_263 = happySpecReduce_1  98# happyReduction_263
happyReduction_263 happy_x_1
	 =  case happyOut192 happy_x_1 of { happy_var_1 -> 
	happyIn191
		 (happy_var_1
	)}

happyReduce_264 = happyReduce 4# 99# happyReduction_264
happyReduction_264 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut190 happy_x_3 of { happy_var_3 -> 
	happyIn192
		 (AbsMPL.CONSPATTERN happy_var_1 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_265 = happySpecReduce_3  99# happyReduction_265
happyReduction_265 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut190 happy_x_2 of { happy_var_2 -> 
	happyIn192
		 (AbsMPL.LISTPATTERN1 happy_var_2
	)}

happyReduce_266 = happySpecReduce_3  99# happyReduction_266
happyReduction_266 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut190 happy_x_2 of { happy_var_2 -> 
	happyIn192
		 (AbsMPL.PRODPATTERN happy_var_2
	)}

happyReduce_267 = happySpecReduce_1  99# happyReduction_267
happyReduction_267 happy_x_1
	 =  case happyOut129 happy_x_1 of { happy_var_1 -> 
	happyIn192
		 (AbsMPL.VARPATTERN happy_var_1
	)}

happyReduce_268 = happySpecReduce_1  99# happyReduction_268
happyReduction_268 happy_x_1
	 =  case happyOut127 happy_x_1 of { happy_var_1 -> 
	happyIn192
		 (AbsMPL.STR_CONSTPATTERN happy_var_1
	)}

happyReduce_269 = happySpecReduce_1  99# happyReduction_269
happyReduction_269 happy_x_1
	 =  case happyOut131 happy_x_1 of { happy_var_1 -> 
	happyIn192
		 (AbsMPL.INT_CONSTPATTERN happy_var_1
	)}

happyReduce_270 = happySpecReduce_1  99# happyReduction_270
happyReduction_270 happy_x_1
	 =  case happyOut126 happy_x_1 of { happy_var_1 -> 
	happyIn192
		 (AbsMPL.NULLPATTERN happy_var_1
	)}

happyReduce_271 = happyReduce 4# 100# happyReduction_271
happyReduction_271 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut111 happy_x_1 of { happy_var_1 -> 
	case happyOut196 happy_x_3 of { happy_var_3 -> 
	happyIn193
		 (AbsMPL.RECORDTERM happy_var_1 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_272 = happySpecReduce_3  100# happyReduction_272
happyReduction_272 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut197 happy_x_2 of { happy_var_2 -> 
	happyIn193
		 (AbsMPL.RECORDTERMALT happy_var_2
	)}

happyReduce_273 = happySpecReduce_1  100# happyReduction_273
happyReduction_273 happy_x_1
	 =  case happyOut194 happy_x_1 of { happy_var_1 -> 
	happyIn193
		 (happy_var_1
	)}

happyReduce_274 = happySpecReduce_3  101# happyReduction_274
happyReduction_274 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut195 happy_x_1 of { happy_var_1 -> 
	case happyOut130 happy_x_2 of { happy_var_2 -> 
	case happyOut194 happy_x_3 of { happy_var_3 -> 
	happyIn194
		 (AbsMPL.InfixTerm happy_var_1 happy_var_2 happy_var_3
	)}}}

happyReduce_275 = happySpecReduce_1  101# happyReduction_275
happyReduction_275 happy_x_1
	 =  case happyOut195 happy_x_1 of { happy_var_1 -> 
	happyIn194
		 (happy_var_1
	)}

happyReduce_276 = happyReduce 5# 102# happyReduction_276
happyReduction_276 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut193 happy_x_2 of { happy_var_2 -> 
	case happyOut193 happy_x_4 of { happy_var_4 -> 
	happyIn195
		 (AbsMPL.LISTTERM2 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_277 = happySpecReduce_3  102# happyReduction_277
happyReduction_277 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut199 happy_x_2 of { happy_var_2 -> 
	happyIn195
		 (AbsMPL.LISTTERM happy_var_2
	)}

happyReduce_278 = happyReduce 6# 102# happyReduction_278
happyReduction_278 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut112 happy_x_1 of { happy_var_1 -> 
	case happyOut193 happy_x_2 of { happy_var_2 -> 
	case happyOut138 happy_x_5 of { happy_var_5 -> 
	happyIn195
		 (AbsMPL.LETTERM happy_var_1 happy_var_2 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_279 = happySpecReduce_1  102# happyReduction_279
happyReduction_279 happy_x_1
	 =  case happyOut129 happy_x_1 of { happy_var_1 -> 
	happyIn195
		 (AbsMPL.VARTERM happy_var_1
	)}

happyReduce_280 = happySpecReduce_1  102# happyReduction_280
happyReduction_280 happy_x_1
	 =  case happyOut200 happy_x_1 of { happy_var_1 -> 
	happyIn195
		 (AbsMPL.CONSTTERM happy_var_1
	)}

happyReduce_281 = happyReduce 8# 102# happyReduction_281
happyReduction_281 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut113 happy_x_1 of { happy_var_1 -> 
	case happyOut193 happy_x_2 of { happy_var_2 -> 
	case happyOut193 happy_x_4 of { happy_var_4 -> 
	case happyOut193 happy_x_7 of { happy_var_7 -> 
	happyIn195
		 (AbsMPL.IFTERM happy_var_1 happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}}

happyReduce_282 = happyReduce 6# 102# happyReduction_282
happyReduction_282 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut115 happy_x_1 of { happy_var_1 -> 
	case happyOut129 happy_x_2 of { happy_var_2 -> 
	case happyOut186 happy_x_5 of { happy_var_5 -> 
	happyIn195
		 (AbsMPL.UNFOLDTERM happy_var_1 happy_var_2 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_283 = happyReduce 6# 102# happyReduction_283
happyReduction_283 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut114 happy_x_1 of { happy_var_1 -> 
	case happyOut129 happy_x_2 of { happy_var_2 -> 
	case happyOut186 happy_x_5 of { happy_var_5 -> 
	happyIn195
		 (AbsMPL.FOLDTERM happy_var_1 happy_var_2 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_284 = happyReduce 6# 102# happyReduction_284
happyReduction_284 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut116 happy_x_1 of { happy_var_1 -> 
	case happyOut193 happy_x_2 of { happy_var_2 -> 
	case happyOut183 happy_x_5 of { happy_var_5 -> 
	happyIn195
		 (AbsMPL.CASETERM happy_var_1 happy_var_2 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_285 = happyReduce 4# 102# happyReduction_285
happyReduction_285 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut198 happy_x_3 of { happy_var_3 -> 
	happyIn195
		 (AbsMPL.GENCONSTERM_WARGS happy_var_1 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_286 = happySpecReduce_1  102# happyReduction_286
happyReduction_286 happy_x_1
	 =  case happyOut128 happy_x_1 of { happy_var_1 -> 
	happyIn195
		 (AbsMPL.GENCONSTERM_WOARGS happy_var_1
	)}

happyReduce_287 = happySpecReduce_3  102# happyReduction_287
happyReduction_287 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut198 happy_x_2 of { happy_var_2 -> 
	happyIn195
		 (AbsMPL.PRODTERM happy_var_2
	)}

happyReduce_288 = happyReduce 4# 102# happyReduction_288
happyReduction_288 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut129 happy_x_1 of { happy_var_1 -> 
	case happyOut198 happy_x_3 of { happy_var_3 -> 
	happyIn195
		 (AbsMPL.FUNAPPTERM happy_var_1 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_289 = happySpecReduce_3  102# happyReduction_289
happyReduction_289 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut193 happy_x_2 of { happy_var_2 -> 
	happyIn195
		 (happy_var_2
	)}

happyReduce_290 = happySpecReduce_0  103# happyReduction_290
happyReduction_290  =  happyIn196
		 ([]
	)

happyReduce_291 = happySpecReduce_1  103# happyReduction_291
happyReduction_291 happy_x_1
	 =  case happyOut202 happy_x_1 of { happy_var_1 -> 
	happyIn196
		 ((:[]) happy_var_1
	)}

happyReduce_292 = happySpecReduce_3  103# happyReduction_292
happyReduction_292 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut202 happy_x_1 of { happy_var_1 -> 
	case happyOut196 happy_x_3 of { happy_var_3 -> 
	happyIn196
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_293 = happySpecReduce_0  104# happyReduction_293
happyReduction_293  =  happyIn197
		 ([]
	)

happyReduce_294 = happySpecReduce_1  104# happyReduction_294
happyReduction_294 happy_x_1
	 =  case happyOut201 happy_x_1 of { happy_var_1 -> 
	happyIn197
		 ((:[]) happy_var_1
	)}

happyReduce_295 = happySpecReduce_3  104# happyReduction_295
happyReduction_295 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut201 happy_x_1 of { happy_var_1 -> 
	case happyOut197 happy_x_3 of { happy_var_3 -> 
	happyIn197
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_296 = happySpecReduce_0  105# happyReduction_296
happyReduction_296  =  happyIn198
		 ([]
	)

happyReduce_297 = happySpecReduce_1  105# happyReduction_297
happyReduction_297 happy_x_1
	 =  case happyOut193 happy_x_1 of { happy_var_1 -> 
	happyIn198
		 ((:[]) happy_var_1
	)}

happyReduce_298 = happySpecReduce_3  105# happyReduction_298
happyReduction_298 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut193 happy_x_1 of { happy_var_1 -> 
	case happyOut198 happy_x_3 of { happy_var_3 -> 
	happyIn198
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_299 = happySpecReduce_0  106# happyReduction_299
happyReduction_299  =  happyIn199
		 ([]
	)

happyReduce_300 = happySpecReduce_1  106# happyReduction_300
happyReduction_300 happy_x_1
	 =  case happyOut194 happy_x_1 of { happy_var_1 -> 
	happyIn199
		 ((:[]) happy_var_1
	)}

happyReduce_301 = happySpecReduce_3  106# happyReduction_301
happyReduction_301 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut194 happy_x_1 of { happy_var_1 -> 
	case happyOut199 happy_x_3 of { happy_var_3 -> 
	happyIn199
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_302 = happySpecReduce_1  107# happyReduction_302
happyReduction_302 happy_x_1
	 =  case happyOut131 happy_x_1 of { happy_var_1 -> 
	happyIn200
		 (AbsMPL.INTEGER happy_var_1
	)}

happyReduce_303 = happySpecReduce_1  107# happyReduction_303
happyReduction_303 happy_x_1
	 =  case happyOut127 happy_x_1 of { happy_var_1 -> 
	happyIn200
		 (AbsMPL.STRING happy_var_1
	)}

happyReduce_304 = happySpecReduce_1  107# happyReduction_304
happyReduction_304 happy_x_1
	 =  case happyOut94 happy_x_1 of { happy_var_1 -> 
	happyIn200
		 (AbsMPL.DOUBLE happy_var_1
	)}

happyReduce_305 = happySpecReduce_1  108# happyReduction_305
happyReduction_305 happy_x_1
	 =  case happyOut202 happy_x_1 of { happy_var_1 -> 
	happyIn201
		 (AbsMPL.RECORDENTRY_ALT happy_var_1
	)}

happyReduce_306 = happyReduce 8# 109# happyReduction_306
happyReduction_306 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut128 happy_x_1 of { happy_var_1 -> 
	case happyOut184 happy_x_3 of { happy_var_3 -> 
	case happyOut193 happy_x_7 of { happy_var_7 -> 
	happyIn202
		 (AbsMPL.RECORDENTRY happy_var_1 happy_var_3 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_307 = happyReduce 12# 110# happyReduction_307
happyReduction_307 (happy_x_12 `HappyStk`
	happy_x_11 `HappyStk`
	happy_x_10 `HappyStk`
	happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut117 happy_x_1 of { happy_var_1 -> 
	case happyOut129 happy_x_2 of { happy_var_2 -> 
	case happyOut153 happy_x_4 of { happy_var_4 -> 
	case happyOut180 happy_x_6 of { happy_var_6 -> 
	case happyOut180 happy_x_8 of { happy_var_8 -> 
	case happyOut204 happy_x_11 of { happy_var_11 -> 
	happyIn203
		 (AbsMPL.PROCESSDEFfull happy_var_1 happy_var_2 happy_var_4 happy_var_6 happy_var_8 happy_var_11
	) `HappyStk` happyRest}}}}}}

happyReduce_308 = happyReduce 6# 110# happyReduction_308
happyReduction_308 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut117 happy_x_1 of { happy_var_1 -> 
	case happyOut129 happy_x_2 of { happy_var_2 -> 
	case happyOut204 happy_x_5 of { happy_var_5 -> 
	happyIn203
		 (AbsMPL.PROCESSDEFshort happy_var_1 happy_var_2 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_309 = happySpecReduce_0  111# happyReduction_309
happyReduction_309  =  happyIn204
		 ([]
	)

happyReduce_310 = happySpecReduce_1  111# happyReduction_310
happyReduction_310 happy_x_1
	 =  case happyOut205 happy_x_1 of { happy_var_1 -> 
	happyIn204
		 ((:[]) happy_var_1
	)}

happyReduce_311 = happySpecReduce_3  111# happyReduction_311
happyReduction_311 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut205 happy_x_1 of { happy_var_1 -> 
	case happyOut204 happy_x_3 of { happy_var_3 -> 
	happyIn204
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_312 = happyReduce 10# 112# happyReduction_312
happyReduction_312 (happy_x_10 `HappyStk`
	happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut190 happy_x_1 of { happy_var_1 -> 
	case happyOut206 happy_x_3 of { happy_var_3 -> 
	case happyOut206 happy_x_5 of { happy_var_5 -> 
	case happyOut218 happy_x_9 of { happy_var_9 -> 
	happyIn205
		 (AbsMPL.PROCESSPHRASEguard happy_var_1 happy_var_3 happy_var_5 happy_var_9
	) `HappyStk` happyRest}}}}

happyReduce_313 = happyReduce 6# 112# happyReduction_313
happyReduction_313 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut190 happy_x_1 of { happy_var_1 -> 
	case happyOut206 happy_x_3 of { happy_var_3 -> 
	case happyOut206 happy_x_5 of { happy_var_5 -> 
	case happyOut207 happy_x_6 of { happy_var_6 -> 
	happyIn205
		 (AbsMPL.PROCESSPHRASEnoguard happy_var_1 happy_var_3 happy_var_5 happy_var_6
	) `HappyStk` happyRest}}}}

happyReduce_314 = happySpecReduce_0  113# happyReduction_314
happyReduction_314  =  happyIn206
		 ([]
	)

happyReduce_315 = happySpecReduce_1  113# happyReduction_315
happyReduction_315 happy_x_1
	 =  case happyOut221 happy_x_1 of { happy_var_1 -> 
	happyIn206
		 ((:[]) happy_var_1
	)}

happyReduce_316 = happySpecReduce_3  113# happyReduction_316
happyReduction_316 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut221 happy_x_1 of { happy_var_1 -> 
	case happyOut206 happy_x_3 of { happy_var_3 -> 
	happyIn206
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_317 = happyReduce 5# 114# happyReduction_317
happyReduction_317 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut208 happy_x_4 of { happy_var_4 -> 
	happyIn207
		 (AbsMPL.MANY_PROCESS happy_var_4
	) `HappyStk` happyRest}

happyReduce_318 = happySpecReduce_2  114# happyReduction_318
happyReduction_318 happy_x_2
	happy_x_1
	 =  case happyOut209 happy_x_2 of { happy_var_2 -> 
	happyIn207
		 (AbsMPL.ONE_PROCESS happy_var_2
	)}

happyReduce_319 = happySpecReduce_0  115# happyReduction_319
happyReduction_319  =  happyIn208
		 ([]
	)

happyReduce_320 = happySpecReduce_1  115# happyReduction_320
happyReduction_320 happy_x_1
	 =  case happyOut209 happy_x_1 of { happy_var_1 -> 
	happyIn208
		 ((:[]) happy_var_1
	)}

happyReduce_321 = happySpecReduce_3  115# happyReduction_321
happyReduction_321 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut209 happy_x_1 of { happy_var_1 -> 
	case happyOut208 happy_x_3 of { happy_var_3 -> 
	happyIn208
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_322 = happyReduce 8# 116# happyReduction_322
happyReduction_322 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut129 happy_x_1 of { happy_var_1 -> 
	case happyOut198 happy_x_3 of { happy_var_3 -> 
	case happyOut206 happy_x_5 of { happy_var_5 -> 
	case happyOut206 happy_x_7 of { happy_var_7 -> 
	happyIn209
		 (AbsMPL.PROCESS_RUN happy_var_1 happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest}}}}

happyReduce_323 = happySpecReduce_2  116# happyReduction_323
happyReduction_323 happy_x_2
	happy_x_1
	 =  case happyOut118 happy_x_1 of { happy_var_1 -> 
	case happyOut221 happy_x_2 of { happy_var_2 -> 
	happyIn209
		 (AbsMPL.PROCESS_CLOSE happy_var_1 happy_var_2
	)}}

happyReduce_324 = happySpecReduce_2  116# happyReduction_324
happyReduction_324 happy_x_2
	happy_x_1
	 =  case happyOut119 happy_x_1 of { happy_var_1 -> 
	case happyOut221 happy_x_2 of { happy_var_2 -> 
	happyIn209
		 (AbsMPL.PROCESS_HALT happy_var_1 happy_var_2
	)}}

happyReduce_325 = happyReduce 4# 116# happyReduction_325
happyReduction_325 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut120 happy_x_1 of { happy_var_1 -> 
	case happyOut129 happy_x_2 of { happy_var_2 -> 
	case happyOut221 happy_x_4 of { happy_var_4 -> 
	happyIn209
		 (AbsMPL.PROCESS_GET happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_326 = happyReduce 6# 116# happyReduction_326
happyReduction_326 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut122 happy_x_1 of { happy_var_1 -> 
	case happyOut221 happy_x_2 of { happy_var_2 -> 
	case happyOut214 happy_x_5 of { happy_var_5 -> 
	happyIn209
		 (AbsMPL.PROCESS_HCASE happy_var_1 happy_var_2 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_327 = happyReduce 4# 116# happyReduction_327
happyReduction_327 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut121 happy_x_1 of { happy_var_1 -> 
	case happyOut193 happy_x_2 of { happy_var_2 -> 
	case happyOut221 happy_x_4 of { happy_var_4 -> 
	happyIn209
		 (AbsMPL.PROCESS_PUT happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_328 = happyReduce 4# 116# happyReduction_328
happyReduction_328 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut123 happy_x_1 of { happy_var_1 -> 
	case happyOut176 happy_x_2 of { happy_var_2 -> 
	case happyOut221 happy_x_4 of { happy_var_4 -> 
	happyIn209
		 (AbsMPL.PROCESS_HPUT happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_329 = happyReduce 4# 116# happyReduction_329
happyReduction_329 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut124 happy_x_1 of { happy_var_1 -> 
	case happyOut221 happy_x_2 of { happy_var_2 -> 
	case happyOut206 happy_x_4 of { happy_var_4 -> 
	happyIn209
		 (AbsMPL.PROCESS_SPLIT happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_330 = happyReduce 6# 116# happyReduction_330
happyReduction_330 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut125 happy_x_1 of { happy_var_1 -> 
	case happyOut129 happy_x_2 of { happy_var_2 -> 
	case happyOut212 happy_x_5 of { happy_var_5 -> 
	happyIn209
		 (AbsMPL.PROCESS_FORK happy_var_1 happy_var_2 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_331 = happyReduce 4# 116# happyReduction_331
happyReduction_331 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut211 happy_x_3 of { happy_var_3 -> 
	happyIn209
		 (AbsMPL.Process_PLUG happy_var_3
	) `HappyStk` happyRest}

happyReduce_332 = happySpecReduce_3  116# happyReduction_332
happyReduction_332 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut220 happy_x_1 of { happy_var_1 -> 
	case happyOut220 happy_x_3 of { happy_var_3 -> 
	happyIn209
		 (AbsMPL.Procss_ID happy_var_1 happy_var_3
	)}}

happyReduce_333 = happyReduce 6# 116# happyReduction_333
happyReduction_333 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut116 happy_x_1 of { happy_var_1 -> 
	case happyOut193 happy_x_2 of { happy_var_2 -> 
	case happyOut216 happy_x_5 of { happy_var_5 -> 
	happyIn209
		 (AbsMPL.PROCESScase happy_var_1 happy_var_2 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_334 = happyReduce 4# 117# happyReduction_334
happyReduction_334 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut208 happy_x_3 of { happy_var_3 -> 
	happyIn210
		 (AbsMPL.PLUGPART_MANY happy_var_3
	) `HappyStk` happyRest}

happyReduce_335 = happySpecReduce_1  117# happyReduction_335
happyReduction_335 happy_x_1
	 =  case happyOut209 happy_x_1 of { happy_var_1 -> 
	happyIn210
		 (AbsMPL.PLUGPART_ONE happy_var_1
	)}

happyReduce_336 = happySpecReduce_0  118# happyReduction_336
happyReduction_336  =  happyIn211
		 ([]
	)

happyReduce_337 = happySpecReduce_1  118# happyReduction_337
happyReduction_337 happy_x_1
	 =  case happyOut210 happy_x_1 of { happy_var_1 -> 
	happyIn211
		 ((:[]) happy_var_1
	)}

happyReduce_338 = happySpecReduce_3  118# happyReduction_338
happyReduction_338 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut210 happy_x_1 of { happy_var_1 -> 
	case happyOut211 happy_x_3 of { happy_var_3 -> 
	happyIn211
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_339 = happySpecReduce_1  119# happyReduction_339
happyReduction_339 happy_x_1
	 =  case happyOut213 happy_x_1 of { happy_var_1 -> 
	happyIn212
		 ((:[]) happy_var_1
	)}

happyReduce_340 = happySpecReduce_3  119# happyReduction_340
happyReduction_340 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut213 happy_x_1 of { happy_var_1 -> 
	case happyOut212 happy_x_3 of { happy_var_3 -> 
	happyIn212
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_341 = happyReduce 4# 120# happyReduction_341
happyReduction_341 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut129 happy_x_1 of { happy_var_1 -> 
	case happyOut206 happy_x_3 of { happy_var_3 -> 
	case happyOut207 happy_x_4 of { happy_var_4 -> 
	happyIn213
		 (AbsMPL.FORKPARTfull happy_var_1 happy_var_3 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_342 = happySpecReduce_2  120# happyReduction_342
happyReduction_342 happy_x_2
	happy_x_1
	 =  case happyOut129 happy_x_1 of { happy_var_1 -> 
	case happyOut207 happy_x_2 of { happy_var_2 -> 
	happyIn213
		 (AbsMPL.FORKPARTshort happy_var_1 happy_var_2
	)}}

happyReduce_343 = happySpecReduce_0  121# happyReduction_343
happyReduction_343  =  happyIn214
		 ([]
	)

happyReduce_344 = happySpecReduce_1  121# happyReduction_344
happyReduction_344 happy_x_1
	 =  case happyOut215 happy_x_1 of { happy_var_1 -> 
	happyIn214
		 ((:[]) happy_var_1
	)}

happyReduce_345 = happySpecReduce_3  121# happyReduction_345
happyReduction_345 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut215 happy_x_1 of { happy_var_1 -> 
	case happyOut214 happy_x_3 of { happy_var_3 -> 
	happyIn214
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_346 = happySpecReduce_2  122# happyReduction_346
happyReduction_346 happy_x_2
	happy_x_1
	 =  case happyOut176 happy_x_1 of { happy_var_1 -> 
	case happyOut207 happy_x_2 of { happy_var_2 -> 
	happyIn215
		 (AbsMPL.HANDLER happy_var_1 happy_var_2
	)}}

happyReduce_347 = happySpecReduce_0  123# happyReduction_347
happyReduction_347  =  happyIn216
		 ([]
	)

happyReduce_348 = happySpecReduce_1  123# happyReduction_348
happyReduction_348 happy_x_1
	 =  case happyOut217 happy_x_1 of { happy_var_1 -> 
	happyIn216
		 ((:[]) happy_var_1
	)}

happyReduce_349 = happySpecReduce_3  123# happyReduction_349
happyReduction_349 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut217 happy_x_1 of { happy_var_1 -> 
	case happyOut216 happy_x_3 of { happy_var_3 -> 
	happyIn216
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_350 = happyReduce 6# 124# happyReduction_350
happyReduction_350 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut190 happy_x_1 of { happy_var_1 -> 
	case happyOut218 happy_x_5 of { happy_var_5 -> 
	happyIn217
		 (AbsMPL.CASEPROCESSguard happy_var_1 happy_var_5
	) `HappyStk` happyRest}}

happyReduce_351 = happySpecReduce_2  124# happyReduction_351
happyReduction_351 happy_x_2
	happy_x_1
	 =  case happyOut190 happy_x_1 of { happy_var_1 -> 
	case happyOut207 happy_x_2 of { happy_var_2 -> 
	happyIn217
		 (AbsMPL.CASEPROCESSnoguard happy_var_1 happy_var_2
	)}}

happyReduce_352 = happySpecReduce_1  125# happyReduction_352
happyReduction_352 happy_x_1
	 =  case happyOut219 happy_x_1 of { happy_var_1 -> 
	happyIn218
		 ((:[]) happy_var_1
	)}

happyReduce_353 = happySpecReduce_3  125# happyReduction_353
happyReduction_353 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut219 happy_x_1 of { happy_var_1 -> 
	case happyOut218 happy_x_3 of { happy_var_3 -> 
	happyIn218
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_354 = happyReduce 5# 126# happyReduction_354
happyReduction_354 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut193 happy_x_1 of { happy_var_1 -> 
	case happyOut208 happy_x_4 of { happy_var_4 -> 
	happyIn219
		 (AbsMPL.GUARDEDPROCESSterm happy_var_1 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_355 = happyReduce 5# 126# happyReduction_355
happyReduction_355 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut110 happy_x_1 of { happy_var_1 -> 
	case happyOut208 happy_x_4 of { happy_var_4 -> 
	happyIn219
		 (AbsMPL.GUARDEDPROCESSother happy_var_1 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_356 = happySpecReduce_1  127# happyReduction_356
happyReduction_356 happy_x_1
	 =  case happyOut129 happy_x_1 of { happy_var_1 -> 
	happyIn220
		 (AbsMPL.BARECHANNEL happy_var_1
	)}

happyReduce_357 = happySpecReduce_2  127# happyReduction_357
happyReduction_357 happy_x_2
	happy_x_1
	 =  case happyOut129 happy_x_2 of { happy_var_2 -> 
	happyIn220
		 (AbsMPL.NEGCHANNEL happy_var_2
	)}

happyReduce_358 = happySpecReduce_1  128# happyReduction_358
happyReduction_358 happy_x_1
	 =  case happyOut129 happy_x_1 of { happy_var_1 -> 
	happyIn221
		 (AbsMPL.CHANNEL happy_var_1
	)}

happyNewToken action sts stk [] =
	happyDoAction 77# notHappyAtAll action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 1#;
	PT _ (TS _ 2) -> cont 2#;
	PT _ (TS _ 3) -> cont 3#;
	PT _ (TS _ 4) -> cont 4#;
	PT _ (TS _ 5) -> cont 5#;
	PT _ (TS _ 6) -> cont 6#;
	PT _ (TS _ 7) -> cont 7#;
	PT _ (TS _ 8) -> cont 8#;
	PT _ (TS _ 9) -> cont 9#;
	PT _ (TS _ 10) -> cont 10#;
	PT _ (TS _ 11) -> cont 11#;
	PT _ (TS _ 12) -> cont 12#;
	PT _ (TS _ 13) -> cont 13#;
	PT _ (TS _ 14) -> cont 14#;
	PT _ (TS _ 15) -> cont 15#;
	PT _ (TS _ 16) -> cont 16#;
	PT _ (TS _ 17) -> cont 17#;
	PT _ (TS _ 18) -> cont 18#;
	PT _ (TS _ 19) -> cont 19#;
	PT _ (TS _ 20) -> cont 20#;
	PT _ (TS _ 21) -> cont 21#;
	PT _ (TS _ 22) -> cont 22#;
	PT _ (TS _ 23) -> cont 23#;
	PT _ (TS _ 24) -> cont 24#;
	PT _ (TS _ 25) -> cont 25#;
	PT _ (TS _ 26) -> cont 26#;
	PT _ (TS _ 27) -> cont 27#;
	PT _ (TS _ 28) -> cont 28#;
	PT _ (TS _ 29) -> cont 29#;
	PT _ (TS _ 30) -> cont 30#;
	PT _ (TS _ 31) -> cont 31#;
	PT _ (TS _ 32) -> cont 32#;
	PT _ (TS _ 33) -> cont 33#;
	PT _ (TS _ 34) -> cont 34#;
	PT _ (TS _ 35) -> cont 35#;
	PT _ (TS _ 36) -> cont 36#;
	PT _ (TS _ 37) -> cont 37#;
	PT _ (TI happy_dollar_dollar) -> cont 38#;
	PT _ (TD happy_dollar_dollar) -> cont 39#;
	PT _ (T_TokUnit _) -> cont 40#;
	PT _ (T_TokDefn _) -> cont 41#;
	PT _ (T_TokRun _) -> cont 42#;
	PT _ (T_TokTerm _) -> cont 43#;
	PT _ (T_TokData _) -> cont 44#;
	PT _ (T_TokCodata _) -> cont 45#;
	PT _ (T_TokType _) -> cont 46#;
	PT _ (T_TokProtocol _) -> cont 47#;
	PT _ (T_TokCoprotocol _) -> cont 48#;
	PT _ (T_TokGetProt _) -> cont 49#;
	PT _ (T_TokPutProt _) -> cont 50#;
	PT _ (T_TokNeg _) -> cont 51#;
	PT _ (T_TokTop _) -> cont 52#;
	PT _ (T_TokBot _) -> cont 53#;
	PT _ (T_TokFun _) -> cont 54#;
	PT _ (T_TokDefault _) -> cont 55#;
	PT _ (T_TokRecord _) -> cont 56#;
	PT _ (T_TokLet _) -> cont 57#;
	PT _ (T_TokIf _) -> cont 58#;
	PT _ (T_TokFold _) -> cont 59#;
	PT _ (T_TokUnfold _) -> cont 60#;
	PT _ (T_TokCase _) -> cont 61#;
	PT _ (T_TokProc _) -> cont 62#;
	PT _ (T_TokClose _) -> cont 63#;
	PT _ (T_TokHalt _) -> cont 64#;
	PT _ (T_TokGet _) -> cont 65#;
	PT _ (T_TokPut _) -> cont 66#;
	PT _ (T_TokHCase _) -> cont 67#;
	PT _ (T_TokHPut _) -> cont 68#;
	PT _ (T_TokSplit _) -> cont 69#;
	PT _ (T_TokFork _) -> cont 70#;
	PT _ (T_TokDCare _) -> cont 71#;
	PT _ (T_TokString _) -> cont 72#;
	PT _ (T_UIdent _) -> cont 73#;
	PT _ (T_PIdent _) -> cont 74#;
	PT _ (T_InfixRem _) -> cont 75#;
	PT _ (T_PInteger _) -> cont 76#;
	_ -> happyError' (tk:tks)
	}

happyError_ 77# tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: () => a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (returnM) a
happyError' :: () => [(Token)] -> Err a
happyError' = happyError

pMPL tks = happySomeParser where
  happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut132 x))

pListMPLstmt tks = happySomeParser where
  happySomeParser = happyThen (happyParse 1# tks) (\x -> happyReturn (happyOut133 x))

pMPLstmt tks = happySomeParser where
  happySomeParser = happyThen (happyParse 2# tks) (\x -> happyReturn (happyOut134 x))

pMPLstmtAlt tks = happySomeParser where
  happySomeParser = happyThen (happyParse 3# tks) (\x -> happyReturn (happyOut135 x))

pListMPLstmtAlt tks = happySomeParser where
  happySomeParser = happyThen (happyParse 4# tks) (\x -> happyReturn (happyOut136 x))

pRUNstmt tks = happySomeParser where
  happySomeParser = happyThen (happyParse 5# tks) (\x -> happyReturn (happyOut137 x))

pListDefn tks = happySomeParser where
  happySomeParser = happyThen (happyParse 6# tks) (\x -> happyReturn (happyOut138 x))

pDefn tks = happySomeParser where
  happySomeParser = happyThen (happyParse 7# tks) (\x -> happyReturn (happyOut139 x))

pOperatorDefn tks = happySomeParser where
  happySomeParser = happyThen (happyParse 8# tks) (\x -> happyReturn (happyOut140 x))

pTermSynonym tks = happySomeParser where
  happySomeParser = happyThen (happyParse 9# tks) (\x -> happyReturn (happyOut141 x))

pTypeDefn tks = happySomeParser where
  happySomeParser = happyThen (happyParse 10# tks) (\x -> happyReturn (happyOut142 x))

pListDataClause tks = happySomeParser where
  happySomeParser = happyThen (happyParse 11# tks) (\x -> happyReturn (happyOut143 x))

pListCoDataClause tks = happySomeParser where
  happySomeParser = happyThen (happyParse 12# tks) (\x -> happyReturn (happyOut144 x))

pListTypeSpec tks = happySomeParser where
  happySomeParser = happyThen (happyParse 13# tks) (\x -> happyReturn (happyOut145 x))

pDataClause tks = happySomeParser where
  happySomeParser = happyThen (happyParse 14# tks) (\x -> happyReturn (happyOut146 x))

pCoDataClause tks = happySomeParser where
  happySomeParser = happyThen (happyParse 15# tks) (\x -> happyReturn (happyOut147 x))

pListDataPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 16# tks) (\x -> happyReturn (happyOut148 x))

pListCoDataPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 17# tks) (\x -> happyReturn (happyOut149 x))

pDataPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 18# tks) (\x -> happyReturn (happyOut150 x))

pCoDataPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 19# tks) (\x -> happyReturn (happyOut151 x))

pListStructor tks = happySomeParser where
  happySomeParser = happyThen (happyParse 20# tks) (\x -> happyReturn (happyOut152 x))

pListType tks = happySomeParser where
  happySomeParser = happyThen (happyParse 21# tks) (\x -> happyReturn (happyOut153 x))

pStructor tks = happySomeParser where
  happySomeParser = happyThen (happyParse 22# tks) (\x -> happyReturn (happyOut154 x))

pTypeSpec tks = happySomeParser where
  happySomeParser = happyThen (happyParse 23# tks) (\x -> happyReturn (happyOut155 x))

pListTypeParam tks = happySomeParser where
  happySomeParser = happyThen (happyParse 24# tks) (\x -> happyReturn (happyOut156 x))

pTypeParam tks = happySomeParser where
  happySomeParser = happyThen (happyParse 25# tks) (\x -> happyReturn (happyOut157 x))

pType tks = happySomeParser where
  happySomeParser = happyThen (happyParse 26# tks) (\x -> happyReturn (happyOut158 x))

pTypeN tks = happySomeParser where
  happySomeParser = happyThen (happyParse 27# tks) (\x -> happyReturn (happyOut159 x))

pListTypeN tks = happySomeParser where
  happySomeParser = happyThen (happyParse 28# tks) (\x -> happyReturn (happyOut160 x))

pListUIdent tks = happySomeParser where
  happySomeParser = happyThen (happyParse 29# tks) (\x -> happyReturn (happyOut161 x))

pCTypeDefn tks = happySomeParser where
  happySomeParser = happyThen (happyParse 30# tks) (\x -> happyReturn (happyOut162 x))

pListProtocolClause tks = happySomeParser where
  happySomeParser = happyThen (happyParse 31# tks) (\x -> happyReturn (happyOut163 x))

pListCoProtocolClause tks = happySomeParser where
  happySomeParser = happyThen (happyParse 32# tks) (\x -> happyReturn (happyOut164 x))

pProtocolClause tks = happySomeParser where
  happySomeParser = happyThen (happyParse 33# tks) (\x -> happyReturn (happyOut165 x))

pCoProtocolClause tks = happySomeParser where
  happySomeParser = happyThen (happyParse 34# tks) (\x -> happyReturn (happyOut166 x))

pListProtocolPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 35# tks) (\x -> happyReturn (happyOut167 x))

pListCoProtocolPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 36# tks) (\x -> happyReturn (happyOut168 x))

pProtocolTypeSpec tks = happySomeParser where
  happySomeParser = happyThen (happyParse 37# tks) (\x -> happyReturn (happyOut169 x))

pListProtocolParam tks = happySomeParser where
  happySomeParser = happyThen (happyParse 38# tks) (\x -> happyReturn (happyOut170 x))

pProtocolParam tks = happySomeParser where
  happySomeParser = happyThen (happyParse 39# tks) (\x -> happyReturn (happyOut171 x))

pProtocolPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 40# tks) (\x -> happyReturn (happyOut172 x))

pCoProtocolPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 41# tks) (\x -> happyReturn (happyOut173 x))

pListEventHandle tks = happySomeParser where
  happySomeParser = happyThen (happyParse 42# tks) (\x -> happyReturn (happyOut174 x))

pEventHandle tks = happySomeParser where
  happySomeParser = happyThen (happyParse 43# tks) (\x -> happyReturn (happyOut175 x))

pEventHandleHPUT tks = happySomeParser where
  happySomeParser = happyThen (happyParse 44# tks) (\x -> happyReturn (happyOut176 x))

pProtocol tks = happySomeParser where
  happySomeParser = happyThen (happyParse 45# tks) (\x -> happyReturn (happyOut177 x))

pProtocol1 tks = happySomeParser where
  happySomeParser = happyThen (happyParse 46# tks) (\x -> happyReturn (happyOut178 x))

pProtocol2 tks = happySomeParser where
  happySomeParser = happyThen (happyParse 47# tks) (\x -> happyReturn (happyOut179 x))

pListProtocol tks = happySomeParser where
  happySomeParser = happyThen (happyParse 48# tks) (\x -> happyReturn (happyOut180 x))

pFunctionDefn tks = happySomeParser where
  happySomeParser = happyThen (happyParse 49# tks) (\x -> happyReturn (happyOut181 x))

pListFunctionDefn tks = happySomeParser where
  happySomeParser = happyThen (happyParse 50# tks) (\x -> happyReturn (happyOut182 x))

pListPattTermPharse tks = happySomeParser where
  happySomeParser = happyThen (happyParse 51# tks) (\x -> happyReturn (happyOut183 x))

pListPIdent tks = happySomeParser where
  happySomeParser = happyThen (happyParse 52# tks) (\x -> happyReturn (happyOut184 x))

pFoldPattern tks = happySomeParser where
  happySomeParser = happyThen (happyParse 53# tks) (\x -> happyReturn (happyOut185 x))

pListFoldPattern tks = happySomeParser where
  happySomeParser = happyThen (happyParse 54# tks) (\x -> happyReturn (happyOut186 x))

pPattTermPharse tks = happySomeParser where
  happySomeParser = happyThen (happyParse 55# tks) (\x -> happyReturn (happyOut187 x))

pListGuardedTerm tks = happySomeParser where
  happySomeParser = happyThen (happyParse 56# tks) (\x -> happyReturn (happyOut188 x))

pGuardedTerm tks = happySomeParser where
  happySomeParser = happyThen (happyParse 57# tks) (\x -> happyReturn (happyOut189 x))

pListPattern tks = happySomeParser where
  happySomeParser = happyThen (happyParse 58# tks) (\x -> happyReturn (happyOut190 x))

pPattern tks = happySomeParser where
  happySomeParser = happyThen (happyParse 59# tks) (\x -> happyReturn (happyOut191 x))

pPattern1 tks = happySomeParser where
  happySomeParser = happyThen (happyParse 60# tks) (\x -> happyReturn (happyOut192 x))

pTerm tks = happySomeParser where
  happySomeParser = happyThen (happyParse 61# tks) (\x -> happyReturn (happyOut193 x))

pTerm1 tks = happySomeParser where
  happySomeParser = happyThen (happyParse 62# tks) (\x -> happyReturn (happyOut194 x))

pTerm2 tks = happySomeParser where
  happySomeParser = happyThen (happyParse 63# tks) (\x -> happyReturn (happyOut195 x))

pListRecordEntry tks = happySomeParser where
  happySomeParser = happyThen (happyParse 64# tks) (\x -> happyReturn (happyOut196 x))

pListRecordEntryAlt tks = happySomeParser where
  happySomeParser = happyThen (happyParse 65# tks) (\x -> happyReturn (happyOut197 x))

pListTerm tks = happySomeParser where
  happySomeParser = happyThen (happyParse 66# tks) (\x -> happyReturn (happyOut198 x))

pListTerm1 tks = happySomeParser where
  happySomeParser = happyThen (happyParse 67# tks) (\x -> happyReturn (happyOut199 x))

pConstantType tks = happySomeParser where
  happySomeParser = happyThen (happyParse 68# tks) (\x -> happyReturn (happyOut200 x))

pRecordEntryAlt tks = happySomeParser where
  happySomeParser = happyThen (happyParse 69# tks) (\x -> happyReturn (happyOut201 x))

pRecordEntry tks = happySomeParser where
  happySomeParser = happyThen (happyParse 70# tks) (\x -> happyReturn (happyOut202 x))

pProcessDef tks = happySomeParser where
  happySomeParser = happyThen (happyParse 71# tks) (\x -> happyReturn (happyOut203 x))

pListPatProcessPhr tks = happySomeParser where
  happySomeParser = happyThen (happyParse 72# tks) (\x -> happyReturn (happyOut204 x))

pPatProcessPhr tks = happySomeParser where
  happySomeParser = happyThen (happyParse 73# tks) (\x -> happyReturn (happyOut205 x))

pListChannel tks = happySomeParser where
  happySomeParser = happyThen (happyParse 74# tks) (\x -> happyReturn (happyOut206 x))

pProcess tks = happySomeParser where
  happySomeParser = happyThen (happyParse 75# tks) (\x -> happyReturn (happyOut207 x))

pListProcessCommand tks = happySomeParser where
  happySomeParser = happyThen (happyParse 76# tks) (\x -> happyReturn (happyOut208 x))

pProcessCommand tks = happySomeParser where
  happySomeParser = happyThen (happyParse 77# tks) (\x -> happyReturn (happyOut209 x))

pPlugPart tks = happySomeParser where
  happySomeParser = happyThen (happyParse 78# tks) (\x -> happyReturn (happyOut210 x))

pListPlugPart tks = happySomeParser where
  happySomeParser = happyThen (happyParse 79# tks) (\x -> happyReturn (happyOut211 x))

pListForkPart tks = happySomeParser where
  happySomeParser = happyThen (happyParse 80# tks) (\x -> happyReturn (happyOut212 x))

pForkPart tks = happySomeParser where
  happySomeParser = happyThen (happyParse 81# tks) (\x -> happyReturn (happyOut213 x))

pListHandler tks = happySomeParser where
  happySomeParser = happyThen (happyParse 82# tks) (\x -> happyReturn (happyOut214 x))

pHandler tks = happySomeParser where
  happySomeParser = happyThen (happyParse 83# tks) (\x -> happyReturn (happyOut215 x))

pListProcessPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 84# tks) (\x -> happyReturn (happyOut216 x))

pProcessPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 85# tks) (\x -> happyReturn (happyOut217 x))

pListGuardProcessPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 86# tks) (\x -> happyReturn (happyOut218 x))

pGuardProcessPhrase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 87# tks) (\x -> happyReturn (happyOut219 x))

pPChannel tks = happySomeParser where
  happySomeParser = happyThen (happyParse 88# tks) (\x -> happyReturn (happyOut220 x))

pChannel tks = happySomeParser where
  happySomeParser = happyThen (happyParse 89# tks) (\x -> happyReturn (happyOut221 x))

happySeq = happyDontSeq


returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map (id . prToken) (take 4 ts))

myLexer = tokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 11 "<command-line>" #-}
# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4











































{-# LINE 11 "<command-line>" #-}
{-# LINE 1 "/opt/ghc/7.10.3/lib/ghc-7.10.3/include/ghcversion.h" #-}

















{-# LINE 11 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}





-- Do not remove this comment. Required to fix CPP parsing when using GCC and a clang-compiled alex.
#if __GLASGOW_HASKELL__ > 706
#define LT(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.<# m)) :: Bool)
#define GTE(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.>=# m)) :: Bool)
#define EQ(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.==# m)) :: Bool)
#else
#define LT(n,m) (n Happy_GHC_Exts.<# m)
#define GTE(n,m) (n Happy_GHC_Exts.>=# m)
#define EQ(n,m) (n Happy_GHC_Exts.==# m)
#endif
{-# LINE 46 "templates/GenericTemplate.hs" #-}


data Happy_IntList = HappyCons Happy_GHC_Exts.Int# Happy_IntList





{-# LINE 67 "templates/GenericTemplate.hs" #-}

{-# LINE 77 "templates/GenericTemplate.hs" #-}

{-# LINE 86 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is 0#, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept 0# tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
        (happyTcHack j (happyTcHack st)) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



happyDoAction i tk st
        = {- nothing -}


          case action of
                0#           -> {- nothing -}
                                     happyFail i tk st
                -1#          -> {- nothing -}
                                     happyAccept i tk st
                n | LT(n,(0# :: Happy_GHC_Exts.Int#)) -> {- nothing -}

                                                   (happyReduceArr Happy_Data_Array.! rule) i tk st
                                                   where rule = (Happy_GHC_Exts.I# ((Happy_GHC_Exts.negateInt# ((n Happy_GHC_Exts.+# (1# :: Happy_GHC_Exts.Int#))))))
                n                 -> {- nothing -}


                                     happyShift new_state i tk st
                                     where new_state = (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#))
   where off    = indexShortOffAddr happyActOffsets st
         off_i  = (off Happy_GHC_Exts.+# i)
         check  = if GTE(off_i,(0# :: Happy_GHC_Exts.Int#))
                  then EQ(indexShortOffAddr happyCheck off_i, i)
                  else False
         action
          | check     = indexShortOffAddr happyTable off_i
          | otherwise = indexShortOffAddr happyDefActions st


indexShortOffAddr (HappyA# arr) off =
        Happy_GHC_Exts.narrow16Int# i
  where
        i = Happy_GHC_Exts.word2Int# (Happy_GHC_Exts.or# (Happy_GHC_Exts.uncheckedShiftL# high 8#) low)
        high = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr (off' Happy_GHC_Exts.+# 1#)))
        low  = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr off'))
        off' = off Happy_GHC_Exts.*# 2#





data HappyAddr = HappyA# Happy_GHC_Exts.Addr#




-----------------------------------------------------------------------------
-- HappyState data type (not arrays)

{-# LINE 170 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state 0# tk st sts stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--     trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons (st) (sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons (st) (sts)) ((happyInTok (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) sts of
         sts1@((HappyCons (st1@(action)) (_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
         let drop_stk = happyDropStk k stk

             off = indexShortOffAddr happyGotoOffsets st1
             off_i = (off Happy_GHC_Exts.+# nt)
             new_state = indexShortOffAddr happyTable off_i



          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop 0# l = l
happyDrop n (HappyCons (_) (t)) = happyDrop (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) t

happyDropStk 0# l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Happy_GHC_Exts.-# (1#::Happy_GHC_Exts.Int#)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction


happyGoto nt j tk st = 
   {- nothing -}
   happyDoAction j tk new_state
   where off = indexShortOffAddr happyGotoOffsets st
         off_i = (off Happy_GHC_Exts.+# nt)
         new_state = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery (0# is the error token)

-- parse error if we are in recovery and we fail again
happyFail 0# tk old_st _ stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  0# tk old_st (HappyCons ((action)) (sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        happyDoAction 0# tk action sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (action) sts stk =
--      trace "entering error recovery" $
        happyDoAction 0# tk action sts ( (Happy_GHC_Exts.unsafeCoerce# (Happy_GHC_Exts.I# (i))) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions


happyTcHack :: Happy_GHC_Exts.Int# -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}


-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.


{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
