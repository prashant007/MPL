
data Tree (A) -> C = Leaf :: A -> C 
                     Node :: C,C -> C 

data Nat -> C = Succ :: C -> C 
                Zero ::   -> C 

codata C -> Exp(B,A) = FunApp :: A,C -> B 

data Bool -> C = True  ::  -> C 
                 False ::  -> C 

data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

fun sumTree :: Tree (Nat) -> Nat =
    t -> fold t of 
        Leaf : val   = val 
        Node : t1,t2 = t1 
