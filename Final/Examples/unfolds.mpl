codata C -> Stream (A) = Head :: C -> A
                         Tail :: C -> C 

data Nat -> A = Zero ::   -> A
                Succ :: A -> A 

-- ============================================================
-- =======================UNFOLDS==============================

-- without unfold

fun streamNats_rec :: Nat -> Stream (Nat) = 
      n -> (| 
              Head :=  n,
              Tail := streamNats_rec (Succ n)
           |)

fun streamNats :: Stream (Nat) =
      num  -> streamNats_rec (num) 


-- with unfold 
fun altStreamNats :: Nat -> Stream (Nat) = 
     num -> unfold num with 
                 Head   -> num 
                 Tail n -> Succ (n)

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

{-

can get rid of this syntax(switch) and replace it with something cleaner namely
the case pattern below ????

fun filter :: A => Bool, List(A) -> List(A) =
          _,[]   -> []
          f,x:xs -> switch  
              f x     -> x:filter(f,xs) 
              default -> filter(f,xs) 
-}

-- ===========================================================
-- =======================CASE PATTERN========================

fun someCaseExm :: A =>Bool,B=>Bool,A,B -> Nat = 
      funca,funcb,a,b -> 
          case (FunApp(a,funca),FunApp(v,funcb)) of
              True ,True  -> Zero 
              True ,False -> Succ (Zero)
              False,True  -> Succ (Succ(Zero))
              False,False -> Succ (Succ (Succ (Zero)))