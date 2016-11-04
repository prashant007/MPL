data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

data Tree (A) -> C = Leaf  :: A  -> C
                     Node  :: C,C -> C 


codata C -> Exp(B,A) = FunApp :: A,C -> B 

data Pair (A,B) -> C = Pair :: A,B -> C 

fun append = 
     []   , ys     -> ys 
     (x:xs), ys    -> (x:(append (xs,ys))) 


fun zipfun = 
    []    ,[]     -> []
    (x:xs),(y:ys) -> Cons (Pair (x,y),zipfun (xs,ys))  


fun collect = 
     Leaf (a)     -> [a] 
     Node (t1,t2) -> append (collect (t1),collect (t2)) 

fun interchange =
      Leaf (a) -> Leaf (a)
      Node (t1,t2) -> Node (interchange (t1),interchange (t2))


fun reverse =
     []    , ys -> ys
     (x:xs), ys -> reverse (xs,(x:ys))

fun zipWithType :: [A],[B] -> [Pair(A,B)] = 
    []    ,[]     -> []
    (x:xs),(y:ys) -> (Pair (x,y):zipWithType (xs,ys))  

fun f1 =
      []      -> 0
      (x:xs)  -> f1 (xs)
   
fun f2 = 
        x  -> f1(x)    

mutual
   fun mfun1 =
         a, b,c -> mfun2 (a,c)

   fun mfun2 =
         "sthg",c -> 0
         x,c      -> mfun3 (x,c)

   fun mfun3 = 
        a,c -> mfun1 (a,0,c)          


fun listofList = 
     [] -> []
     (x:xs) -> ([x] : listofList (xs))    

fun flattenTree =
    t -> fold t of 
        Leaf : val   = [val] 
        Node : t1,t2 = append (t1,t2) 