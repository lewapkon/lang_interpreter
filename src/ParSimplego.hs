{-# OPTIONS_GHC -w #-}
{-# OPTIONS -XMagicHash -XBangPatterns -XTypeSynonymInstances -XFlexibleInstances -cpp #-}
#if __GLASGOW_HASKELL__ >= 710
{-# OPTIONS_GHC -XPartialTypeSignatures #-}
#endif
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParSimplego where
import AbsSimplego
import LexSimplego
import ErrM
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import qualified GHC.Exts as Happy_GHC_Exts
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.8

newtype HappyAbsSyn  = HappyAbsSyn HappyAny
#if __GLASGOW_HASKELL__ >= 607
type HappyAny = Happy_GHC_Exts.Any
#else
type HappyAny = forall a . a
#endif
happyIn4 :: (Ident) -> (HappyAbsSyn )
happyIn4 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn4 #-}
happyOut4 :: (HappyAbsSyn ) -> (Ident)
happyOut4 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut4 #-}
happyIn5 :: (Integer) -> (HappyAbsSyn )
happyIn5 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn5 #-}
happyOut5 :: (HappyAbsSyn ) -> (Integer)
happyOut5 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut5 #-}
happyIn6 :: (Program) -> (HappyAbsSyn )
happyIn6 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn6 #-}
happyOut6 :: (HappyAbsSyn ) -> (Program)
happyOut6 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut6 #-}
happyIn7 :: (TopDef) -> (HappyAbsSyn )
happyIn7 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn7 #-}
happyOut7 :: (HappyAbsSyn ) -> (TopDef)
happyOut7 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut7 #-}
happyIn8 :: ([TopDef]) -> (HappyAbsSyn )
happyIn8 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn ) -> ([TopDef])
happyOut8 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut8 #-}
happyIn9 :: (Arg) -> (HappyAbsSyn )
happyIn9 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn ) -> (Arg)
happyOut9 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: ([Arg]) -> (HappyAbsSyn )
happyIn10 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn ) -> ([Arg])
happyOut10 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: (Block) -> (HappyAbsSyn )
happyIn11 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn ) -> (Block)
happyOut11 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: ([Stmt]) -> (HappyAbsSyn )
happyIn12 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn ) -> ([Stmt])
happyOut12 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut12 #-}
happyIn13 :: (Stmt) -> (HappyAbsSyn )
happyIn13 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn ) -> (Stmt)
happyOut13 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut13 #-}
happyIn14 :: (SimpleStmt) -> (HappyAbsSyn )
happyIn14 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn ) -> (SimpleStmt)
happyOut14 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: (AssStmt) -> (HappyAbsSyn )
happyIn15 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> (AssStmt)
happyOut15 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: (ShAssStmt) -> (HappyAbsSyn )
happyIn16 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> (ShAssStmt)
happyOut16 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: (DeclStmt) -> (HappyAbsSyn )
happyIn17 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> (DeclStmt)
happyOut17 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: (Item) -> (HappyAbsSyn )
happyIn18 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> (Item)
happyOut18 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: (ReturnStmt) -> (HappyAbsSyn )
happyIn19 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> (ReturnStmt)
happyOut19 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: (MaybeExpr) -> (HappyAbsSyn )
happyIn20 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> (MaybeExpr)
happyOut20 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: (BreakStmt) -> (HappyAbsSyn )
happyIn21 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn ) -> (BreakStmt)
happyOut21 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyIn22 :: (ContinueStmt) -> (HappyAbsSyn )
happyIn22 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn22 #-}
happyOut22 :: (HappyAbsSyn ) -> (ContinueStmt)
happyOut22 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut22 #-}
happyIn23 :: (IfStmt) -> (HappyAbsSyn )
happyIn23 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn ) -> (IfStmt)
happyOut23 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut23 #-}
happyIn24 :: (MaybeElse) -> (HappyAbsSyn )
happyIn24 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> (MaybeElse)
happyOut24 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut24 #-}
happyIn25 :: (IfOrBlock) -> (HappyAbsSyn )
happyIn25 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> (IfOrBlock)
happyOut25 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut25 #-}
happyIn26 :: (ForStmt) -> (HappyAbsSyn )
happyIn26 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> (ForStmt)
happyOut26 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut26 #-}
happyIn27 :: (ForClause) -> (HappyAbsSyn )
happyIn27 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> (ForClause)
happyOut27 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut27 #-}
happyIn28 :: (Condition) -> (HappyAbsSyn )
happyIn28 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> (Condition)
happyOut28 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut28 #-}
happyIn29 :: (Type) -> (HappyAbsSyn )
happyIn29 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> (Type)
happyOut29 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut29 #-}
happyIn30 :: (VarType) -> (HappyAbsSyn )
happyIn30 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> (VarType)
happyOut30 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyIn31 :: ([VarType]) -> (HappyAbsSyn )
happyIn31 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> ([VarType])
happyOut31 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut31 #-}
happyIn32 :: (Expr) -> (HappyAbsSyn )
happyIn32 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> (Expr)
happyOut32 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (Expr) -> (HappyAbsSyn )
happyIn33 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> (Expr)
happyOut33 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut33 #-}
happyIn34 :: (Expr) -> (HappyAbsSyn )
happyIn34 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn ) -> (Expr)
happyOut34 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut34 #-}
happyIn35 :: (Expr) -> (HappyAbsSyn )
happyIn35 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn ) -> (Expr)
happyOut35 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut35 #-}
happyIn36 :: (Expr) -> (HappyAbsSyn )
happyIn36 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> (Expr)
happyOut36 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut36 #-}
happyIn37 :: (Expr) -> (HappyAbsSyn )
happyIn37 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> (Expr)
happyOut37 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut37 #-}
happyIn38 :: (Expr) -> (HappyAbsSyn )
happyIn38 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> (Expr)
happyOut38 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut38 #-}
happyIn39 :: ([Expr]) -> (HappyAbsSyn )
happyIn39 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> ([Expr])
happyOut39 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut39 #-}
happyIn40 :: (AddOp) -> (HappyAbsSyn )
happyIn40 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> (AddOp)
happyOut40 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut40 #-}
happyIn41 :: (MulOp) -> (HappyAbsSyn )
happyIn41 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> (MulOp)
happyOut41 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut41 #-}
happyIn42 :: (RelOp) -> (HappyAbsSyn )
happyIn42 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> (RelOp)
happyOut42 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut42 #-}
happyInTok :: (Token) -> (HappyAbsSyn )
happyInTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> (Token)
happyOutTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOutTok #-}


happyExpList :: HappyAddr
happyExpList = HappyA# "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x01\x01\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x20\x00\xd8\x7b\x07\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x04\x00\x00\x00\x00\x00\x00\x4a\xb3\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x84\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x80\x08\x00\x00\x00\x00\x00\x00\x00\x00\x20\x01\x00\x3b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x50\x84\x01\x00\x00\x00\x00\x10\x02\x02\x00\x14\x61\x00\x00\x00\x00\x00\x80\x00\x00\x00\x45\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x84\x80\x00\x00\xc5\x18\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x08\x08\x00\x50\x84\x01\x00\x00\x00\x00\x10\x02\x02\x00\x14\x61\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x14\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x20\x00\x40\x11\x06\x00\x00\x00\x00\x40\x08\x08\x00\x50\x84\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x84\x80\x00\x00\x45\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x08\x08\x00\x50\x84\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x20\x00\x40\x11\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x20\x00\x40\x11\x06\x00\x00\x00\x00\x40\x08\x08\x00\x50\x84\x01\x00\x00\x00\x00\x10\x02\x02\x00\x14\x61\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x20\x00\x40\x11\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x02\x02\x00\x14\x61\x00\x00\x00\x00\x00\x84\x80\x00\x00\x45\x18\x00\x00\x00\x00\x00\x21\x20\x00\x40\x11\x06\x00\x00\x00\x00\x40\x08\x08\x00\x50\x84\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x08\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x22\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x20\x00\x40\x11\x06\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x08\x08\x00\x50\x84\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x01\x00\x00\x00\x00\x00\x00\x00\x00\x04\x05\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x20\x00\x40\x11\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x02\x02\x00\x14\x63\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgram","Ident","Integer","Program","TopDef","ListTopDef","Arg","ListArg","Block","ListStmt","Stmt","SimpleStmt","AssStmt","ShAssStmt","DeclStmt","Item","ReturnStmt","MaybeExpr","BreakStmt","ContinueStmt","IfStmt","MaybeElse","IfOrBlock","ForStmt","ForClause","Condition","Type","VarType","ListVarType","Expr6","Expr5","Expr4","Expr3","Expr2","Expr1","Expr","ListExpr","AddOp","MulOp","RelOp","'!'","'!='","'%'","'%='","'&&'","'('","')'","'*'","'*='","'+'","'++'","'+='","','","'-'","'--'","'-='","'/'","'/='","':='","';'","'<'","'<='","'='","'=='","'>'","'>='","'bool'","'break'","'continue'","'else'","'false'","'for'","'func'","'if'","'int'","'return'","'true'","'var'","'{'","'||'","'}'","L_ident","L_integ","%eof"]
        bit_start = st * 86
        bit_end = (st + 1) * 86
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..85]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\xe4\xff\xe0\xff\x00\x00\xe2\xff\xef\xff\x00\x00\xee\xff\x2d\x00\x00\x00\x10\x00\xe9\xff\x38\x00\x45\x00\xe8\xff\x26\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2c\x00\x00\x00\x51\x00\xe9\xff\x00\x00\x00\x00\x01\x00\x4d\x00\x69\x00\xe8\xff\xe9\xff\x73\x01\x00\x00\x00\x00\x00\x00\x48\x00\x00\x00\x00\x00\x00\x00\x67\x00\x6d\x00\x73\x00\x00\x00\x00\x00\x00\x00\x00\x00\x05\x00\x07\x00\x47\x01\x61\x00\x00\x00\x3a\x00\x33\x00\x3a\x00\x00\x00\x00\x00\x00\x00\x11\x00\x8e\x00\x33\x00\x33\x00\x00\x00\x7e\x00\x00\x00\x00\x00\xe8\xff\x9a\x00\x00\x00\x00\x00\x86\x00\x91\x00\xa9\x00\xaa\x00\x00\x00\xad\x00\x00\x00\xcb\x00\x00\x00\x33\x00\x33\x00\x00\x00\x33\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x33\x00\x00\x00\x00\x00\x33\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x33\x00\x33\x00\x33\x00\x00\x00\x33\x00\x00\x00\x33\x00\x33\x00\x33\x00\x33\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc8\x00\xdc\x00\x00\x00\x00\x00\x05\x00\x00\x00\x07\x00\x00\x00\x00\x00\x00\x00\x33\x00\xdd\x00\xc7\x00\xd0\x00\x00\x00\x33\x00\x00\x00\xdf\xff\xe8\xff\xd2\x00\x00\x00\x00\x00\x33\x00\x00\x00\x23\x00\xc3\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x3b\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\xfb\x00\x00\x00\x00\x00\xa1\x00\xe2\x00\x00\x00\x00\x00\x14\x00\xd3\x00\x00\x00\x00\x00\x00\x00\x00\x00\x06\x01\x00\x00\x00\x00\x54\x00\x00\x00\x07\x01\x79\x00\x00\x00\x00\x00\x74\x00\x76\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe9\x00\xec\x00\xeb\x00\x00\x00\x00\x00\x13\x00\xcf\x00\x19\x00\x00\x00\x00\x00\x00\x00\x92\x00\x00\x00\xd6\x00\xbe\x00\x00\x00\x14\x01\x00\x00\x00\x00\x89\x00\x00\x00\x00\x00\x00\x00\x17\x01\x20\x01\x00\x00\x18\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe1\x00\x60\x00\x00\x00\x4d\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x58\x01\x00\x00\x00\x00\x46\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe8\x00\x4a\x00\xf9\x00\x00\x00\x0b\x01\x00\x00\x12\x01\x1c\x01\x23\x01\x35\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\x00\x00\x00\xfe\x00\x00\x00\x00\x00\x00\x00\xa4\x00\x00\x00\x34\x01\x29\x01\x00\x00\x46\x01\x00\x00\x3c\x00\xa0\x00\x00\x00\x00\x00\x00\x00\x55\x00\x00\x00\xab\x00\x43\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyAdjustOffset :: Happy_GHC_Exts.Int# -> Happy_GHC_Exts.Int#
happyAdjustOffset off = off

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\x00\x00\x00\x00\xfe\xff\x00\x00\xfa\xff\xfc\xff\x00\x00\x00\x00\xf9\xff\xf7\xff\x00\x00\xf6\xff\x00\x00\xc9\xff\xf7\xff\xf8\xff\xc6\xff\xc7\xff\xf5\xff\x00\x00\xca\xff\x00\x00\xc5\xff\xfb\xff\xf3\xff\xea\xff\xc4\xff\x00\x00\xc9\xff\xc5\xff\xc2\xff\xc1\xff\xed\xff\xf2\xff\x00\x00\xe8\xff\xe7\xff\xe6\xff\x00\x00\x00\x00\x00\x00\xec\xff\xeb\xff\xb9\xff\xb7\xff\xb5\xff\xb3\xff\xb1\xff\xaf\xff\xe9\xff\x00\x00\x00\x00\x00\x00\xd6\xff\xd5\xff\xbe\xff\xea\xff\x00\x00\x00\x00\xd7\xff\xbf\xff\x00\x00\xf4\xff\xfd\xff\xc9\xff\xc2\xff\xd9\xff\xd8\xff\x00\x00\xf7\xff\x00\x00\x00\x00\xce\xff\xe9\xff\xbb\xff\x00\x00\xba\xff\x00\x00\x00\x00\xa1\xff\x00\x00\xa6\xff\xa5\xff\xa2\xff\xa4\xff\xa3\xff\x00\x00\xab\xff\xaa\xff\x00\x00\xa7\xff\xa9\xff\xa8\xff\xee\xff\xef\xff\xf0\xff\xf1\xff\x00\x00\xae\xff\x00\x00\xe4\xff\x00\x00\xe3\xff\x00\x00\x00\x00\x00\x00\x00\x00\xc3\xff\xc8\xff\xe5\xff\xdd\xff\xdf\xff\xe1\xff\xe2\xff\xe0\xff\xad\xff\x00\x00\xde\xff\xb8\xff\xb6\xff\xb2\xff\xb4\xff\xb0\xff\xbc\xff\xcf\xff\xcb\xff\x00\x00\xd3\xff\xdb\xff\xdc\xff\x00\x00\xd4\xff\x00\x00\xc9\xff\x00\x00\xcc\xff\xbd\xff\xae\xff\xac\xff\xea\xff\x00\x00\xd0\xff\xd1\xff\xd2\xff\xda\xff\xc0\xff\xcd\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x22\x00\x01\x00\x1b\x00\x1b\x00\x21\x00\x27\x00\x06\x00\x03\x00\x21\x00\x2a\x00\x23\x00\x23\x00\x08\x00\x2c\x00\x0e\x00\x21\x00\x0a\x00\x01\x00\x00\x00\x01\x00\x0e\x00\x11\x00\x06\x00\x2a\x00\x00\x00\x01\x00\x03\x00\x04\x00\x1c\x00\x1d\x00\x0e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x01\x00\x24\x00\x25\x00\x26\x00\x27\x00\x06\x00\x29\x00\x2a\x00\x2b\x00\x19\x00\x1a\x00\x1c\x00\x1f\x00\x0e\x00\x21\x00\x06\x00\x01\x00\x1c\x00\x25\x00\x26\x00\x27\x00\x06\x00\x2a\x00\x2a\x00\x2b\x00\x02\x00\x03\x00\x04\x00\x06\x00\x0e\x00\x1f\x00\x07\x00\x21\x00\x0d\x00\x00\x00\x01\x00\x25\x00\x26\x00\x00\x00\x01\x00\x07\x00\x2a\x00\x2b\x00\x13\x00\x2a\x00\x15\x00\x1f\x00\x27\x00\x21\x00\x00\x00\x01\x00\x06\x00\x25\x00\x1f\x00\x0d\x00\x21\x00\x14\x00\x2a\x00\x2b\x00\x25\x00\x00\x00\x01\x00\x1c\x00\x1d\x00\x2a\x00\x2b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x1a\x00\x1b\x00\x07\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x14\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x07\x00\x14\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x14\x00\x0f\x00\x28\x00\x11\x00\x12\x00\x13\x00\x19\x00\x1a\x00\x16\x00\x1a\x00\x1b\x00\x00\x00\x01\x00\x06\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x06\x00\x00\x00\x19\x00\x1a\x00\x00\x00\x01\x00\x05\x00\x06\x00\x2a\x00\x17\x00\x18\x00\x00\x00\x01\x00\x27\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x19\x00\x1a\x00\x2a\x00\x18\x00\x14\x00\x00\x00\x01\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x10\x00\x00\x00\x01\x00\x27\x00\x07\x00\x00\x00\x27\x00\x0d\x00\x00\x00\x01\x00\x05\x00\x06\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x00\x00\x01\x00\x07\x00\x07\x00\x1e\x00\x14\x00\x17\x00\x00\x00\x01\x00\x27\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x00\x00\x01\x00\x00\x00\x1a\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x00\x00\x01\x00\x07\x00\x25\x00\x08\x00\x24\x00\x26\x00\x00\x00\x01\x00\x00\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x00\x00\x01\x00\x07\x00\x07\x00\x00\x00\x25\x00\x24\x00\x00\x00\x01\x00\x05\x00\x06\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x00\x00\x01\x00\x0e\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x00\x00\x01\x00\x14\x00\x02\x00\x07\x00\xff\xff\x05\x00\x00\x00\x01\x00\xff\xff\xff\xff\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x00\x00\x01\x00\xff\xff\xff\xff\x15\x00\x16\x00\xff\xff\x18\x00\x19\x00\x1a\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x1c\x00\x1d\x00\x1e\x00\x04\x00\xff\xff\x06\x00\xff\xff\xff\xff\x09\x00\xff\xff\x0b\x00\x0c\x00\xff\xff\xff\xff\x0f\x00\x10\x00\xff\xff\x12\x00\x13\x00\xff\xff\xff\xff\xff\xff\x17\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x3b\x00\x33\x00\x11\x00\x11\x00\x07\x00\x19\x00\x34\x00\x5b\x00\x16\x00\x03\x00\x12\x00\x12\x00\x5c\x00\xff\xff\x35\x00\x07\x00\x58\x00\x33\x00\x41\x00\x1f\x00\x59\x00\x5d\x00\x34\x00\x03\x00\x41\x00\x1f\x00\x04\x00\x08\x00\x36\x00\x37\x00\x35\x00\x38\x00\x39\x00\x3a\x00\x3b\x00\x33\x00\x3c\x00\x3d\x00\x3e\x00\x19\x00\x34\x00\x3f\x00\x03\x00\x40\x00\x13\x00\x14\x00\x4c\x00\x38\x00\x35\x00\x3a\x00\x0a\x00\x33\x00\x4a\x00\x3d\x00\x3e\x00\xcb\xff\x34\x00\x03\x00\x03\x00\x40\x00\x03\x00\x04\x00\x05\x00\x34\x00\x35\x00\x38\x00\x8d\x00\x3a\x00\x0f\x00\x41\x00\x1f\x00\x3d\x00\x3e\x00\x41\x00\x1f\x00\x0e\x00\x03\x00\x40\x00\x8e\x00\x03\x00\x8f\x00\x38\x00\x19\x00\x3a\x00\x41\x00\x1f\x00\x17\x00\x3d\x00\x38\x00\x1e\x00\x3a\x00\x61\x00\x03\x00\x40\x00\x3d\x00\x41\x00\x1f\x00\x2b\x00\x76\x00\x03\x00\x40\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x73\x00\x74\x00\x1a\x00\x1b\x00\x1d\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x73\x00\x8a\x00\x1e\x00\x1f\x00\x60\x00\x2b\x00\x2c\x00\x2d\x00\x79\x00\x20\x00\x5f\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x5e\x00\x26\x00\x4e\x00\x27\x00\x28\x00\x29\x00\x6c\x00\x14\x00\x2a\x00\x1a\x00\x6b\x00\x1e\x00\x1f\x00\x46\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x46\x00\x23\x00\x24\x00\x25\x00\x63\x00\x0a\x00\x80\x00\x14\x00\x41\x00\x1f\x00\x0b\x00\x0c\x00\x03\x00\x47\x00\x48\x00\x1e\x00\x1f\x00\x19\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x49\x00\x92\x00\x23\x00\x24\x00\x25\x00\x8c\x00\x14\x00\x03\x00\x86\x00\x7e\x00\x41\x00\x1f\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x87\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x42\x00\x41\x00\x1f\x00\x19\x00\x7c\x00\x0a\x00\xcc\xff\x8a\x00\x41\x00\x1f\x00\x0b\x00\x12\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x43\x00\x41\x00\x1f\x00\x89\x00\x86\x00\x85\x00\x8c\x00\x83\x00\x41\x00\x1f\x00\x19\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x4b\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x44\x00\x41\x00\x1f\x00\x07\x00\x0f\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x7a\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x75\x00\x41\x00\x1f\x00\x17\x00\x59\x00\x19\x00\x56\x00\x4e\x00\x41\x00\x1f\x00\x40\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x72\x00\x41\x00\x1f\x00\x7f\x00\x7c\x00\x0a\x00\x59\x00\x56\x00\x41\x00\x1f\x00\x0b\x00\x7e\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x71\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x70\x00\x41\x00\x1f\x00\x81\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x6f\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x6e\x00\x41\x00\x1f\x00\x83\x00\x50\x00\x91\x00\x00\x00\x51\x00\x41\x00\x1f\x00\x00\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x6d\x00\x41\x00\x1f\x00\x00\x00\x00\x00\x52\x00\x53\x00\x00\x00\x54\x00\x55\x00\x56\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x90\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x78\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2b\x00\x2c\x00\x77\x00\x62\x00\x00\x00\x63\x00\x00\x00\x00\x00\x64\x00\x00\x00\x65\x00\x66\x00\x00\x00\x00\x00\x67\x00\x68\x00\x00\x00\x69\x00\x6a\x00\x00\x00\x00\x00\x00\x00\x6b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (1, 94) [
	(1 , happyReduce_1),
	(2 , happyReduce_2),
	(3 , happyReduce_3),
	(4 , happyReduce_4),
	(5 , happyReduce_5),
	(6 , happyReduce_6),
	(7 , happyReduce_7),
	(8 , happyReduce_8),
	(9 , happyReduce_9),
	(10 , happyReduce_10),
	(11 , happyReduce_11),
	(12 , happyReduce_12),
	(13 , happyReduce_13),
	(14 , happyReduce_14),
	(15 , happyReduce_15),
	(16 , happyReduce_16),
	(17 , happyReduce_17),
	(18 , happyReduce_18),
	(19 , happyReduce_19),
	(20 , happyReduce_20),
	(21 , happyReduce_21),
	(22 , happyReduce_22),
	(23 , happyReduce_23),
	(24 , happyReduce_24),
	(25 , happyReduce_25),
	(26 , happyReduce_26),
	(27 , happyReduce_27),
	(28 , happyReduce_28),
	(29 , happyReduce_29),
	(30 , happyReduce_30),
	(31 , happyReduce_31),
	(32 , happyReduce_32),
	(33 , happyReduce_33),
	(34 , happyReduce_34),
	(35 , happyReduce_35),
	(36 , happyReduce_36),
	(37 , happyReduce_37),
	(38 , happyReduce_38),
	(39 , happyReduce_39),
	(40 , happyReduce_40),
	(41 , happyReduce_41),
	(42 , happyReduce_42),
	(43 , happyReduce_43),
	(44 , happyReduce_44),
	(45 , happyReduce_45),
	(46 , happyReduce_46),
	(47 , happyReduce_47),
	(48 , happyReduce_48),
	(49 , happyReduce_49),
	(50 , happyReduce_50),
	(51 , happyReduce_51),
	(52 , happyReduce_52),
	(53 , happyReduce_53),
	(54 , happyReduce_54),
	(55 , happyReduce_55),
	(56 , happyReduce_56),
	(57 , happyReduce_57),
	(58 , happyReduce_58),
	(59 , happyReduce_59),
	(60 , happyReduce_60),
	(61 , happyReduce_61),
	(62 , happyReduce_62),
	(63 , happyReduce_63),
	(64 , happyReduce_64),
	(65 , happyReduce_65),
	(66 , happyReduce_66),
	(67 , happyReduce_67),
	(68 , happyReduce_68),
	(69 , happyReduce_69),
	(70 , happyReduce_70),
	(71 , happyReduce_71),
	(72 , happyReduce_72),
	(73 , happyReduce_73),
	(74 , happyReduce_74),
	(75 , happyReduce_75),
	(76 , happyReduce_76),
	(77 , happyReduce_77),
	(78 , happyReduce_78),
	(79 , happyReduce_79),
	(80 , happyReduce_80),
	(81 , happyReduce_81),
	(82 , happyReduce_82),
	(83 , happyReduce_83),
	(84 , happyReduce_84),
	(85 , happyReduce_85),
	(86 , happyReduce_86),
	(87 , happyReduce_87),
	(88 , happyReduce_88),
	(89 , happyReduce_89),
	(90 , happyReduce_90),
	(91 , happyReduce_91),
	(92 , happyReduce_92),
	(93 , happyReduce_93),
	(94 , happyReduce_94)
	]

happy_n_terms = 45 :: Int
happy_n_nonterms = 39 :: Int

happyReduce_1 = happySpecReduce_1  0# happyReduction_1
happyReduction_1 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TV happy_var_1)) -> 
	happyIn4
		 (Ident happy_var_1
	)}

happyReduce_2 = happySpecReduce_1  1# happyReduction_2
happyReduction_2 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TI happy_var_1)) -> 
	happyIn5
		 ((read ( happy_var_1)) :: Integer
	)}

happyReduce_3 = happySpecReduce_1  2# happyReduction_3
happyReduction_3 happy_x_1
	 =  case happyOut8 happy_x_1 of { happy_var_1 -> 
	happyIn6
		 (AbsSimplego.Program happy_var_1
	)}

happyReduce_4 = happyReduce 7# 3# happyReduction_4
happyReduction_4 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut10 happy_x_4 of { happy_var_4 -> 
	case happyOut29 happy_x_6 of { happy_var_6 -> 
	case happyOut11 happy_x_7 of { happy_var_7 -> 
	happyIn7
		 (AbsSimplego.FnDef happy_var_2 happy_var_4 happy_var_6 happy_var_7
	) `HappyStk` happyRest}}}}

happyReduce_5 = happySpecReduce_1  4# happyReduction_5
happyReduction_5 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn8
		 ((:[]) happy_var_1
	)}

happyReduce_6 = happySpecReduce_2  4# happyReduction_6
happyReduction_6 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOut8 happy_x_2 of { happy_var_2 -> 
	happyIn8
		 ((:) happy_var_1 happy_var_2
	)}}

happyReduce_7 = happySpecReduce_2  5# happyReduction_7
happyReduction_7 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_2 of { happy_var_2 -> 
	happyIn9
		 (AbsSimplego.Arg happy_var_1 happy_var_2
	)}}

happyReduce_8 = happySpecReduce_0  6# happyReduction_8
happyReduction_8  =  happyIn10
		 ([]
	)

happyReduce_9 = happySpecReduce_1  6# happyReduction_9
happyReduction_9 happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	happyIn10
		 ((:[]) happy_var_1
	)}

happyReduce_10 = happySpecReduce_3  6# happyReduction_10
happyReduction_10 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut10 happy_x_3 of { happy_var_3 -> 
	happyIn10
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_11 = happySpecReduce_3  7# happyReduction_11
happyReduction_11 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut12 happy_x_2 of { happy_var_2 -> 
	happyIn11
		 (AbsSimplego.Block (reverse happy_var_2)
	)}

happyReduce_12 = happySpecReduce_0  8# happyReduction_12
happyReduction_12  =  happyIn12
		 ([]
	)

happyReduce_13 = happySpecReduce_2  8# happyReduction_13
happyReduction_13 happy_x_2
	happy_x_1
	 =  case happyOut12 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_2 of { happy_var_2 -> 
	happyIn12
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_14 = happySpecReduce_2  9# happyReduction_14
happyReduction_14 happy_x_2
	happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	happyIn13
		 (AbsSimplego.SimpleStmt happy_var_1
	)}

happyReduce_15 = happySpecReduce_2  9# happyReduction_15
happyReduction_15 happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	happyIn13
		 (AbsSimplego.ReturnStmt happy_var_1
	)}

happyReduce_16 = happySpecReduce_2  9# happyReduction_16
happyReduction_16 happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn13
		 (AbsSimplego.BreakStmt happy_var_1
	)}

happyReduce_17 = happySpecReduce_2  9# happyReduction_17
happyReduction_17 happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	happyIn13
		 (AbsSimplego.ContinueStmt happy_var_1
	)}

happyReduce_18 = happySpecReduce_1  9# happyReduction_18
happyReduction_18 happy_x_1
	 =  case happyOut11 happy_x_1 of { happy_var_1 -> 
	happyIn13
		 (AbsSimplego.BlockStmt happy_var_1
	)}

happyReduce_19 = happySpecReduce_1  9# happyReduction_19
happyReduction_19 happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	happyIn13
		 (AbsSimplego.IfStmt happy_var_1
	)}

happyReduce_20 = happySpecReduce_1  9# happyReduction_20
happyReduction_20 happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	happyIn13
		 (AbsSimplego.ForStmt happy_var_1
	)}

happyReduce_21 = happySpecReduce_0  10# happyReduction_21
happyReduction_21  =  happyIn14
		 (AbsSimplego.EmptySimpleStmt
	)

happyReduce_22 = happySpecReduce_1  10# happyReduction_22
happyReduction_22 happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	happyIn14
		 (AbsSimplego.ExprSimpStmt happy_var_1
	)}

happyReduce_23 = happySpecReduce_1  10# happyReduction_23
happyReduction_23 happy_x_1
	 =  case happyOut15 happy_x_1 of { happy_var_1 -> 
	happyIn14
		 (AbsSimplego.AssSimpleStmt happy_var_1
	)}

happyReduce_24 = happySpecReduce_1  10# happyReduction_24
happyReduction_24 happy_x_1
	 =  case happyOut16 happy_x_1 of { happy_var_1 -> 
	happyIn14
		 (AbsSimplego.ShortAssSimpleStmt happy_var_1
	)}

happyReduce_25 = happySpecReduce_1  10# happyReduction_25
happyReduction_25 happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn14
		 (AbsSimplego.DeclSimpleStmt happy_var_1
	)}

happyReduce_26 = happySpecReduce_3  11# happyReduction_26
happyReduction_26 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn15
		 (AbsSimplego.Ass happy_var_1 happy_var_3
	)}}

happyReduce_27 = happySpecReduce_2  11# happyReduction_27
happyReduction_27 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	happyIn15
		 (AbsSimplego.Incr happy_var_1
	)}

happyReduce_28 = happySpecReduce_2  11# happyReduction_28
happyReduction_28 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	happyIn15
		 (AbsSimplego.Decr happy_var_1
	)}

happyReduce_29 = happySpecReduce_3  11# happyReduction_29
happyReduction_29 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn15
		 (AbsSimplego.AddAss happy_var_1 happy_var_3
	)}}

happyReduce_30 = happySpecReduce_3  11# happyReduction_30
happyReduction_30 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn15
		 (AbsSimplego.SubAss happy_var_1 happy_var_3
	)}}

happyReduce_31 = happySpecReduce_3  11# happyReduction_31
happyReduction_31 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn15
		 (AbsSimplego.MulAss happy_var_1 happy_var_3
	)}}

happyReduce_32 = happySpecReduce_3  11# happyReduction_32
happyReduction_32 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn15
		 (AbsSimplego.DivAss happy_var_1 happy_var_3
	)}}

happyReduce_33 = happySpecReduce_3  11# happyReduction_33
happyReduction_33 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn15
		 (AbsSimplego.ModAss happy_var_1 happy_var_3
	)}}

happyReduce_34 = happySpecReduce_3  12# happyReduction_34
happyReduction_34 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn16
		 (AbsSimplego.ShortAss happy_var_1 happy_var_3
	)}}

happyReduce_35 = happyReduce 4# 13# happyReduction_35
happyReduction_35 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut29 happy_x_3 of { happy_var_3 -> 
	case happyOut18 happy_x_4 of { happy_var_4 -> 
	happyIn17
		 (AbsSimplego.Decl happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_36 = happySpecReduce_0  14# happyReduction_36
happyReduction_36  =  happyIn18
		 (AbsSimplego.NoInit
	)

happyReduce_37 = happySpecReduce_2  14# happyReduction_37
happyReduction_37 happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_2 of { happy_var_2 -> 
	happyIn18
		 (AbsSimplego.Init happy_var_2
	)}

happyReduce_38 = happySpecReduce_2  15# happyReduction_38
happyReduction_38 happy_x_2
	happy_x_1
	 =  case happyOut20 happy_x_2 of { happy_var_2 -> 
	happyIn19
		 (AbsSimplego.Ret happy_var_2
	)}

happyReduce_39 = happySpecReduce_1  16# happyReduction_39
happyReduction_39 happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 (AbsSimplego.MaybeExprYes happy_var_1
	)}

happyReduce_40 = happySpecReduce_0  16# happyReduction_40
happyReduction_40  =  happyIn20
		 (AbsSimplego.MaybeExprNo
	)

happyReduce_41 = happySpecReduce_1  17# happyReduction_41
happyReduction_41 happy_x_1
	 =  happyIn21
		 (AbsSimplego.Break
	)

happyReduce_42 = happySpecReduce_1  18# happyReduction_42
happyReduction_42 happy_x_1
	 =  happyIn22
		 (AbsSimplego.Continue
	)

happyReduce_43 = happyReduce 4# 19# happyReduction_43
happyReduction_43 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut38 happy_x_2 of { happy_var_2 -> 
	case happyOut11 happy_x_3 of { happy_var_3 -> 
	case happyOut24 happy_x_4 of { happy_var_4 -> 
	happyIn23
		 (AbsSimplego.If happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_44 = happySpecReduce_0  20# happyReduction_44
happyReduction_44  =  happyIn24
		 (AbsSimplego.NoElse
	)

happyReduce_45 = happySpecReduce_2  20# happyReduction_45
happyReduction_45 happy_x_2
	happy_x_1
	 =  case happyOut25 happy_x_2 of { happy_var_2 -> 
	happyIn24
		 (AbsSimplego.Else happy_var_2
	)}

happyReduce_46 = happySpecReduce_1  21# happyReduction_46
happyReduction_46 happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	happyIn25
		 (AbsSimplego.IfOfIfOrBlock happy_var_1
	)}

happyReduce_47 = happySpecReduce_1  21# happyReduction_47
happyReduction_47 happy_x_1
	 =  case happyOut11 happy_x_1 of { happy_var_1 -> 
	happyIn25
		 (AbsSimplego.BlockOfIfOrBlock happy_var_1
	)}

happyReduce_48 = happySpecReduce_3  22# happyReduction_48
happyReduction_48 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_2 of { happy_var_2 -> 
	case happyOut11 happy_x_3 of { happy_var_3 -> 
	happyIn26
		 (AbsSimplego.For happy_var_2 happy_var_3
	)}}

happyReduce_49 = happySpecReduce_1  23# happyReduction_49
happyReduction_49 happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	happyIn27
		 (AbsSimplego.ForCond happy_var_1
	)}

happyReduce_50 = happyReduce 5# 23# happyReduction_50
happyReduction_50 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut14 happy_x_1 of { happy_var_1 -> 
	case happyOut28 happy_x_3 of { happy_var_3 -> 
	case happyOut14 happy_x_5 of { happy_var_5 -> 
	happyIn27
		 (AbsSimplego.ForFull happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_51 = happySpecReduce_1  24# happyReduction_51
happyReduction_51 happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	happyIn28
		 (AbsSimplego.ExprCond happy_var_1
	)}

happyReduce_52 = happySpecReduce_0  24# happyReduction_52
happyReduction_52  =  happyIn28
		 (AbsSimplego.TrueCond
	)

happyReduce_53 = happySpecReduce_1  25# happyReduction_53
happyReduction_53 happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn29
		 (AbsSimplego.VarType happy_var_1
	)}

happyReduce_54 = happySpecReduce_0  25# happyReduction_54
happyReduction_54  =  happyIn29
		 (AbsSimplego.Void
	)

happyReduce_55 = happyReduce 5# 25# happyReduction_55
happyReduction_55 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut31 happy_x_3 of { happy_var_3 -> 
	case happyOut29 happy_x_5 of { happy_var_5 -> 
	happyIn29
		 (AbsSimplego.Fun happy_var_3 happy_var_5
	) `HappyStk` happyRest}}

happyReduce_56 = happySpecReduce_1  26# happyReduction_56
happyReduction_56 happy_x_1
	 =  happyIn30
		 (AbsSimplego.Int
	)

happyReduce_57 = happySpecReduce_1  26# happyReduction_57
happyReduction_57 happy_x_1
	 =  happyIn30
		 (AbsSimplego.Bool
	)

happyReduce_58 = happySpecReduce_0  27# happyReduction_58
happyReduction_58  =  happyIn31
		 ([]
	)

happyReduce_59 = happySpecReduce_1  27# happyReduction_59
happyReduction_59 happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn31
		 ((:[]) happy_var_1
	)}

happyReduce_60 = happySpecReduce_3  27# happyReduction_60
happyReduction_60 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_3 of { happy_var_3 -> 
	happyIn31
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_61 = happySpecReduce_1  28# happyReduction_61
happyReduction_61 happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	happyIn32
		 (AbsSimplego.EVar happy_var_1
	)}

happyReduce_62 = happySpecReduce_1  28# happyReduction_62
happyReduction_62 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn32
		 (AbsSimplego.ELitInt happy_var_1
	)}

happyReduce_63 = happyReduce 6# 28# happyReduction_63
happyReduction_63 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_3 of { happy_var_3 -> 
	case happyOut29 happy_x_5 of { happy_var_5 -> 
	case happyOut11 happy_x_6 of { happy_var_6 -> 
	happyIn32
		 (AbsSimplego.EFun happy_var_3 happy_var_5 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_64 = happySpecReduce_1  28# happyReduction_64
happyReduction_64 happy_x_1
	 =  happyIn32
		 (AbsSimplego.ELitTrue
	)

happyReduce_65 = happySpecReduce_1  28# happyReduction_65
happyReduction_65 happy_x_1
	 =  happyIn32
		 (AbsSimplego.ELitFalse
	)

happyReduce_66 = happyReduce 4# 28# happyReduction_66
happyReduction_66 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn32
		 (AbsSimplego.EApp happy_var_1 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_67 = happySpecReduce_3  28# happyReduction_67
happyReduction_67 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_2 of { happy_var_2 -> 
	happyIn32
		 (happy_var_2
	)}

happyReduce_68 = happySpecReduce_2  29# happyReduction_68
happyReduction_68 happy_x_2
	happy_x_1
	 =  case happyOut32 happy_x_2 of { happy_var_2 -> 
	happyIn33
		 (AbsSimplego.ENeg happy_var_2
	)}

happyReduce_69 = happySpecReduce_2  29# happyReduction_69
happyReduction_69 happy_x_2
	happy_x_1
	 =  case happyOut32 happy_x_2 of { happy_var_2 -> 
	happyIn33
		 (AbsSimplego.ENot happy_var_2
	)}

happyReduce_70 = happySpecReduce_1  29# happyReduction_70
happyReduction_70 happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	happyIn33
		 (happy_var_1
	)}

happyReduce_71 = happySpecReduce_3  30# happyReduction_71
happyReduction_71 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut41 happy_x_2 of { happy_var_2 -> 
	case happyOut33 happy_x_3 of { happy_var_3 -> 
	happyIn34
		 (AbsSimplego.EMul happy_var_1 happy_var_2 happy_var_3
	)}}}

happyReduce_72 = happySpecReduce_1  30# happyReduction_72
happyReduction_72 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (happy_var_1
	)}

happyReduce_73 = happySpecReduce_3  31# happyReduction_73
happyReduction_73 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	case happyOut40 happy_x_2 of { happy_var_2 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (AbsSimplego.EAdd happy_var_1 happy_var_2 happy_var_3
	)}}}

happyReduce_74 = happySpecReduce_1  31# happyReduction_74
happyReduction_74 happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	happyIn35
		 (happy_var_1
	)}

happyReduce_75 = happySpecReduce_3  32# happyReduction_75
happyReduction_75 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_2 of { happy_var_2 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn36
		 (AbsSimplego.ERel happy_var_1 happy_var_2 happy_var_3
	)}}}

happyReduce_76 = happySpecReduce_1  32# happyReduction_76
happyReduction_76 happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	happyIn36
		 (happy_var_1
	)}

happyReduce_77 = happySpecReduce_3  33# happyReduction_77
happyReduction_77 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_3 of { happy_var_3 -> 
	happyIn37
		 (AbsSimplego.EAnd happy_var_1 happy_var_3
	)}}

happyReduce_78 = happySpecReduce_1  33# happyReduction_78
happyReduction_78 happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	happyIn37
		 (happy_var_1
	)}

happyReduce_79 = happySpecReduce_3  34# happyReduction_79
happyReduction_79 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut37 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (AbsSimplego.EOr happy_var_1 happy_var_3
	)}}

happyReduce_80 = happySpecReduce_1  34# happyReduction_80
happyReduction_80 happy_x_1
	 =  case happyOut37 happy_x_1 of { happy_var_1 -> 
	happyIn38
		 (happy_var_1
	)}

happyReduce_81 = happySpecReduce_0  35# happyReduction_81
happyReduction_81  =  happyIn39
		 ([]
	)

happyReduce_82 = happySpecReduce_1  35# happyReduction_82
happyReduction_82 happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	happyIn39
		 ((:[]) happy_var_1
	)}

happyReduce_83 = happySpecReduce_3  35# happyReduction_83
happyReduction_83 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn39
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_84 = happySpecReduce_1  36# happyReduction_84
happyReduction_84 happy_x_1
	 =  happyIn40
		 (AbsSimplego.PlusOp
	)

happyReduce_85 = happySpecReduce_1  36# happyReduction_85
happyReduction_85 happy_x_1
	 =  happyIn40
		 (AbsSimplego.MinusOp
	)

happyReduce_86 = happySpecReduce_1  37# happyReduction_86
happyReduction_86 happy_x_1
	 =  happyIn41
		 (AbsSimplego.TimesOp
	)

happyReduce_87 = happySpecReduce_1  37# happyReduction_87
happyReduction_87 happy_x_1
	 =  happyIn41
		 (AbsSimplego.DivOp
	)

happyReduce_88 = happySpecReduce_1  37# happyReduction_88
happyReduction_88 happy_x_1
	 =  happyIn41
		 (AbsSimplego.ModOp
	)

happyReduce_89 = happySpecReduce_1  38# happyReduction_89
happyReduction_89 happy_x_1
	 =  happyIn42
		 (AbsSimplego.LTOp
	)

happyReduce_90 = happySpecReduce_1  38# happyReduction_90
happyReduction_90 happy_x_1
	 =  happyIn42
		 (AbsSimplego.LEOp
	)

happyReduce_91 = happySpecReduce_1  38# happyReduction_91
happyReduction_91 happy_x_1
	 =  happyIn42
		 (AbsSimplego.GTOp
	)

happyReduce_92 = happySpecReduce_1  38# happyReduction_92
happyReduction_92 happy_x_1
	 =  happyIn42
		 (AbsSimplego.GEOp
	)

happyReduce_93 = happySpecReduce_1  38# happyReduction_93
happyReduction_93 happy_x_1
	 =  happyIn42
		 (AbsSimplego.EQOp
	)

happyReduce_94 = happySpecReduce_1  38# happyReduction_94
happyReduction_94 happy_x_1
	 =  happyIn42
		 (AbsSimplego.NEOp
	)

happyNewToken action sts stk [] =
	happyDoAction 44# notHappyAtAll action sts stk []

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
	PT _ (TS _ 38) -> cont 38#;
	PT _ (TS _ 39) -> cont 39#;
	PT _ (TS _ 40) -> cont 40#;
	PT _ (TS _ 41) -> cont 41#;
	PT _ (TV happy_dollar_dollar) -> cont 42#;
	PT _ (TI happy_dollar_dollar) -> cont 43#;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 44# tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: () => a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (returnM) a
happyError' :: () => ([(Token)], [String]) -> Err a
happyError' = (\(tokens, _) -> happyError tokens)
pProgram tks = happySomeParser where
 happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut6 x))

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



















































































































































































-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 













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


data Happy_IntList = HappyCons Happy_GHC_Exts.Int# Happy_IntList




















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
                                     happyFail (happyExpListPerState ((Happy_GHC_Exts.I# (st)) :: Int)) i tk st
                -1#          -> {- nothing -}
                                     happyAccept i tk st
                n | LT(n,(0# :: Happy_GHC_Exts.Int#)) -> {- nothing -}
                                                   
                                                   (happyReduceArr Happy_Data_Array.! rule) i tk st
                                                   where rule = (Happy_GHC_Exts.I# ((Happy_GHC_Exts.negateInt# ((n Happy_GHC_Exts.+# (1# :: Happy_GHC_Exts.Int#))))))
                n                 -> {- nothing -}
                                     

                                     happyShift new_state i tk st
                                     where new_state = (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#))
   where off    = happyAdjustOffset (indexShortOffAddr happyActOffsets st)
         off_i  = (off Happy_GHC_Exts.+#  i)
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




{-# INLINE happyLt #-}
happyLt x y = LT(x,y)


readArrayBit arr bit =
    Bits.testBit (Happy_GHC_Exts.I# (indexShortOffAddr arr ((unbox_int bit) `Happy_GHC_Exts.iShiftRA#` 4#))) (bit `mod` 16)
  where unbox_int (Happy_GHC_Exts.I# x) = x






data HappyAddr = HappyA# Happy_GHC_Exts.Addr#


-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



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
     = happyFail [] 0# tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) sts of
         sts1@((HappyCons (st1@(action)) (_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
         let drop_stk = happyDropStk k stk

             off = happyAdjustOffset (indexShortOffAddr happyGotoOffsets st1)
             off_i = (off Happy_GHC_Exts.+#  nt)
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
   where off = happyAdjustOffset (indexShortOffAddr happyGotoOffsets st)
         off_i = (off Happy_GHC_Exts.+#  nt)
         new_state = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery (0# is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist 0# tk old_st _ stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

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
happyFail explist i tk (action) sts stk =
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

