data Nat -> C  =  Zero ::  -> C 
                  Succ :: C -> C 
-- ===========================================================
data List(A) -> X = Cons :: A,X -> X  
                    Nil  ::     -> X 
-- ===========================================================
data Maybe(A) -> V = Just    :: A -> V 
                     Nothing ::   -> V
-- ===========================================================
data A + B -> C  = In0 :: A -> C 
                   In1 :: B -> C 
-- ===========================================================

data Tree(A) -> C    =  Empty  ::   -> C
                        Node   :: A,Forest(A) -> C
and  Forest (A) -> C  = Nil_F  ::   -> C 
                        Cons_F :: Tree(A),C -> C 

-- ===========================================================

data Tree2 (A) -> C   = Leaf2 :: A -> C 
                        Node2 :: C,C -> C 
-- ===========================================================
data Bool -> C = True  ::  -> C 
                 False ::  -> C   

data Bool -> C = True,False :: -> C 
-- ===========================================================

codata C -> Exp(B,A) = FunApp :: A,C -> B 

-- ===========================================================
codata C -> Stream (A) = First :: C -> A
                         Rest  :: C -> C 
-- ===========================================================
codata X -> CoLista (B) = Snoca :: X -> Sum (B,Y)
and    Y -> CoListb (B) = Snocb :: Y -> Sum (B,X)
-- ===========================================================

type ListInt = List(Int)    

-- Ask more about how to read protocols below.
-- Ask Robin how to represent  IntTerm/Console protocol in MPL
protocol Talk (A,B|) => Q = 
          Talker   :: Get(A|Put(B|Q)) => Q 
          Listener :: Put(B|Get(A|Q)) => Q


-- =============================================================
fun append :: List(A),List(A) -> List(A) = 
          [],ys   -> ys
          x:xs,ys -> x:append(xs,ys)

fun sumTree :: Tree2(Int) -> Int = 
       Leaf2 (lval)    -> lval
       Node2 (rc,lc)   -> sumTree(rc) + sumTree(lc)   

fun append2 :: List(A),List(A) -> List(A) = 
       Nil,        ys  -> ys
       Cons(x,xs), ys  -> Cons (x,append(xs,ys))

fun length :: List(A) -> Nat =
                 Nil -> Zero
                 Cons(x,xs) -> Succ (length(xs))


fun filter :: A => Bool, List(A) -> List(A) =
          _,[]   -> []
          f,x:xs -> switch  
              f x     -> x:filter(f,xs) 
              default -> filter(f,xs) 

-- ===========================================================
-- =================HIGHER ORDER FUNCTION=====================

fun filter :: Nat => Bool , List (Nat) -> List (Nat) = 
         f, Nil ->
                 Nil 
         f, Cons(x,xs) -> 
                 case FunApp (x,f) of 
                     True  -> Cons (x,xs) 
                     False -> xs 

fun nonZero :: Nat -> Exp (Nat,Bool) = 
         x -> (: FunApp := if eq(x,Zero) then False else False :)               

fun filterNonZero :: List (Nat) -> List (Nat) =
     list -> filter (nonZero,list)


-- ===========================================================
-- =======================CASE PATTERN========================

fun someCaseExm :: A =>Bool,B=>Bool,A,B -> Nat = 
      funca,funcb,a,b -> 
          case (FunApp(a,funca),FunApp(v,funcb)) of
              True ,True  -> Zero 
              True ,False -> Succ (Zero)
              False,True  -> Succ (Succ(Zero))
              False,False -> Succ (Succ (Succ (Zero)))


-- ============================================================
-- =======================UNFOLDS==============================

fun streamNats_rec :: Nat -> Stream (Nat) = 
      n -> (: Head :=  n,
              Tail := streamNats_rec (Succ n)
           :)

fun streamNats :: Nat -> Stream (Nat) =
     n -> unfold 

{-

 fold
   + :: Nat, Nat -> Nat := n,m by n =
          Zero, m -> m
          Succ(n),m -> Succ(n+m)

-}

fold
   + :: Nat, Nat -> Nat := n,m by n =
          Zero, m -> m
          Succ(n),m -> Succ n

fold 
   sumTreefold :: Tree2 (Int) -> Int := t by t = 
          Leaf2 val    -> val 
          Node2 lc rc  -> lc + rc 


-- ================================================================
-- ================================================================

data Tree a =  Leaf a 
             | Node (Tree a) (Tree a)
             deriving (Eq,Show)

foldTree :: (a->b) -> (b -> b -> b) -> Tree a ->  b 
foldTree fleaf gnode (Leaf val)   = fleaf val
foldTree fleaf gnode (Node lc rc) = gnode (foldTree fleaf gnode lc)
                                          (foldTree fleaf gnode rc) 

sumTree :: Tree Int -> Int 
sumTree tree = foldTree (\x -> x) (\x y -> x + y) tree 

-- ================================================================
-- ================================================================

data Nat = Zero
          | Succ Nat
          deriving (Eq,Show)


foldNat :: b -> (b -> b) -> Nat -> b  
foldNat fzero gsucc nat 
       = case nat of 
             Zero     -> fzero
             Succ num -> gsucc (foldNat fzero gsucc num) 

add2Nums :: Nat -> Nat -> Nat
add2Nums n1 n2 = foldNat n2 (\nat -> Succ nat ) n1   