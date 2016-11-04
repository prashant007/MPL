data Tree (A) -> C = Leaf ::  -> C 
                     Branch :: A,C,C -> C 

data Nat -> C = Succ :: C -> C 
                Zero ::   -> C 

data Bool -> C = True  ::  -> C 
                 False ::  -> C 

data List(A) -> C = Nil  ::   -> C
                    Cons :: C -> C 


-- ====================================================================
fun foldTree :: B ,(B,B,B => B),Tree (A) -> B =
    fleaf,fbranch,tree ->
          case tree of
              Leaf   ->
                  fleaf 
              Branch(bval,lc,rc) ->
                   FunApp(
                           bval,
                           FunApp (
                                    foldTree(fleaf,gnode,lc),
                                    FunApp (
                                             foldTree(fleaf,gnode,rc),
                                             fbranch
                                           )

                                  )
                         )
-- ==========================================================================
fun sumTree :: Tree (Nat) -> Nat =
     t -> fold t of 
             Leaf :  =
                 Zero
             Branch : bval,lc,rc =
                 val + lc + rc 

fun mapTree :: (A => B),Tree(A) -> Tree (B) =
     func,tree -> fold tree of 
                     Leaf : =
                         Leaf
                     Branch :bval,lc,rc =
                         Branch (
                                 FunApp(bval,func),
                                 lc,
                                 rc
                                )

fun inorder :: Tree(A) -> List (A) = 
    t -> fold t of 
             Leaf : =
                 Nil
             Branch : val,lc,rc = 
                 append([val],append(lc,rc)) -- [val] ++ lc ++ rc

fun preorder :: Tree(A) -> List (A) = 
    t -> fold t of 
             Leaf : =  
                 [] ++ Nil 
             Branch : val,lc,rc =  
               lc ++ [val] ++ rc  