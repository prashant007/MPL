codata C -> Exp(B,A) = FunApp :: A,C -> B 

data Pair (A,B) -> C = Pair :: A,B -> C 


data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

data Tree (A) -> C = Leaf  :: A  -> C
                     Node  :: C,C -> C 

fun append :: [A],[A] -> [A] = 
   []    , ys     -> ys 
   (x:xs), ys    -> (x:(append (xs,ys))) 

fun flattenTree :: Tree (T0) -> [T0] =
    t -> fold t of 
        Leaf : val   = [val] 
        Node : t1,t2 = append (t1,t2) 
                       

defn of
   fun mfun1 =
         a, b,c -> mfun2 (a,c)

   fun mfun2 =
         "sthg",c -> 0
         x,c      -> mfun3 (x,c)

   fun mfun3 = 
        a,c -> mfun1 (a,0,c)
   


