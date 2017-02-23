data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

codata C -> Exp(B,A) = FunApp :: A,C -> B 

data Pair (A,B) -> C = Pair :: A,B -> C 

mutual
   fun mfun1 =
         a, b -> mfun2 (a)

   fun mfun2 =
         "sthg" -> 0
         x      -> mfun3 (x)

   fun mfun3 = 
        a -> mfun1 (a,0)          
