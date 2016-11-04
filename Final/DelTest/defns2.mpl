data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

codata C -> Exp(B,A) = FunApp :: A,C -> B 

data Tree (A) -> C = Leaf  :: A  -> C
                     Node  :: C,C -> C 

data Rose (A) -> C =  RVar :: A -> C 
                      RS   :: List(C) -> C  

data Pair (A,B) -> C = Pair :: A,B -> C 

fun append = 
     []   , ys     -> ys 
     (x:xs), ys    -> (x:(append (xs,ys))) 

fun flattenTree =
    t -> fold t of 
        Leaf : val   = [val] 
        Node : t1,t2 = append (t1,t2) 

fun foldReverse = 
      t -> fold t of 
              Nil  :      = []
              Cons : x,r  = append (r,[x])


fun pattTerms1 = 
    [x],y -> [x]
    a  ,b -> b 

fun zipfun = 
    []    ,[]     -> []
    (x:xs),(y:ys) -> Cons (Pair (x,y),zipfun (xs,ys)) 

fun reverse =
     l -> case l of 
              []     -> []
              (x:xs) -> append (reverse (xs),[x])
