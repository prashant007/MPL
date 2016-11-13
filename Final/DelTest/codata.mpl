codata C -> Stream (A) = Head :: C -> A
                         Tail :: C -> C 

data Tree (A) -> C  = Empty  :: -> C
                      Branch :: A,C,C -> C 

data Bool -> C = True  :: -> C
                 False :: -> C   

codata C -> Exp(A,B) = App :: A,C -> B 

data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 


data Rose(A) -> C = RLeaf :: A ->  C
                    RNode :: [C] -> C


fun map = 
     f,[]     -> []
     f,(x:xs) -> App (x,f):map (f,xs) 

fun append = 
     []   , ys     -> ys 
     (x:xs), ys    -> x:append (xs,ys) 

fun flatten =
    []     -> []
    (x:xs) -> append (x,flatten (xs))

fun collectRSElems_fold =
    r -> fold r of 
             RLeaf : x  = [x]
             RNode : xs = flatten (xs)


fun collectRSElems_case = 
    r -> case r of 
             RLeaf (x)   ->
                 [x]
             RNode (rts) ->
               let 
                 flatten (map (f1,rts))
               where
                  f1 = (: App (x) := collectRSElems_case (x) :)   

fun newNats = 
    n -> record of
             Head := 10
             Tail := newNats (n+1)

fun nats =
    n -> (: Head := n , Tail := nats (n+1) :)


fun filter :: A => Bool,[A] -> [A] =
          _,[]   -> []
          f,x:xs -> switch  
              App(x,f) = x:filter(f,xs) 
              default  = filter(f,xs) 

