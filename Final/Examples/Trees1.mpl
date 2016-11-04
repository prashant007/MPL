data Tree (A) -> C = Leaf :: A -> C 
                     Node :: C,C -> C 

data Nat -> C = Succ :: C -> C 
                Zero ::   -> C 

codata C -> Exp(B,A) = FunApp :: A,C -> B 

data Bool -> C = True  ::  -> C 
                 False ::  -> C 

data List(A) -> C = Nil  ::   -> C
                    Cons :: C -> C 


-- ========================================================

-- This function needs to be auto generated.

fun foldTree :: (A => B),(B,B => B),Tree (A) -> B =  
      fleaf,gnode,Leaf(val)   -> FunApp (val,fleaf)
      fleaf,gnode,Node(lc,rc) -> FunApp (
                                       foldTree(fleaf,gnode,lc),
                                       FunApp (
                                                foldTree(fleaf,gnode,rc),
                                                gnode
                                              )
                                     )  


-- ========================================================

fun sumTree :: Tree (Nat) -> Nat =
    t -> fold t of 
        Leaf : val   = val 
        Node : (t1,t2) = t1 + t2

-- ========================================================

fun mapTree :: (A => B),Tree (A) -> Tree (B) = 
          func,t -> fold t of 
                        Leaf : val   = Leaf (FunApp (val,func))
                        Node : t1,t2 = Node(t1,t2)

-- ========================================================

fun heightTree :: Tree (Nat) -> Nat = 
    t -> fold t of 
            Leaf : val     = 0 -- a -> b
            Node : t1,t2   = 1 + maxNat(x,y) -- b,b -> b

-- ========================================================

fun noOfLeaves :: Tree (A) -> Nat =
    t -> fold t of 
             Leaf : val     = 1
             Node : (t1,t2) = t1 + t2

-- ========================================================

fun noOfNodes :: Tree (A) -> Nat =
    t -> fold t of 
             Leaf : val     = 0
             Node : (t1,t2) = 1 + t1 + t2 

-- ========================================================

fun searchTree :: Tree (A),A -> Bool = 
          t,sval -> fold t of 
                        Leaf : val     = eqI(val,sval) -- how to make it polymorphic ??
                        Node : (t1,t2) = or (t1,t2)      -- boolean operators ??


-- ========================================================

fun flattenTree :: Tree(A) -> List(A) =
        t -> fold t of
                 Leaf : val     = Cons(val,Nil)
                 Node : (t1,t2) = append (t1,t2)

-- ========================================================

fun replaceTree :: Tree (A),A,A -> Tree (A) =
       t,oval,nval -> fold t of 
                          Leaf : val     = if eqI(oval,val) 
                                                then Leaf(nval)
                                                else Leaf(val) 
                          Node : (t1,t2) = Node (t1,t2)
