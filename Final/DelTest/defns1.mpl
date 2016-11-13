
data Tree (A) -> C = Leaf :: A -> C 
                     Node :: C,C -> C 

data Nat -> C = Succ :: C -> C 
                Zero ::   -> C 

codata C -> Exp(B,A) = FunApp :: A,C -> B 

data Bool -> C = True  ::  -> C 
                 False ::  -> C 

data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

fun sumTree :: Tree (Int) -> Int  =
    t -> fold t of 
        Leaf : val   = val 
        Node : t1,t2 = t1 + t2 + t2 + t1

fun balanceCond = 
   t1,t2 -> noOfNodes (t1) - noOfNodes (t2) == 0 || 
            noOfNodes (t1) - noOfNodes (t2) == 1    
{-
fun sumTree2 :: Tree (A) -> A =
    t -> fold t of 
        Leaf : val   = val 
        Node : t1,t2 = t1 
-}


{-
fun append = 
     []   , ys     -> ys 
     (x:xs), ys    -> x:append (xs,ys)  
-}