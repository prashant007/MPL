data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

codata C -> Exp(B,A) = FunApp :: A,C -> B 

data Tree (A) -> C = Leaf  :: A  -> C
                     Node  :: C,C -> C 

data Rose (A) -> C =  RVar :: A -> C 
                      RS   :: List(C) -> C  

data Bool -> C = True  :: ->  C
                 False :: -> C

data Pair (A,B) -> C = Pair :: A,B -> C 

fun zipfun :: [A],[B] -> [<A,B>] = 
    []    ,[]      -> []
    (x:xs),(y:ys)  -> (<x,y>:zipfun (xs,ys)) 
