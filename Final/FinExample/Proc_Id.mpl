coprotocol CP => Console (A) =
    GetIntC   :: CP => Put (A|CP)  
    PutIntC   :: CP => Get (A|CP) 
    CloseC    :: CP => TopBot  

protocol IntTerm (A) => P =
    GetInt   :: Get (A|P) => P 
    PutInt   :: Put (A|P) => P
    Close    :: TopBot    => P  

{-
protocol InfPut (A) => P = 
    Putter :: Put (A|P) => P 

protocol Passer (A) => P = 
      Pass :: A (+) A (*) P => P 

-}

defn of 
    fun f0 =
          []       -> "abc"
          (x:xs)   -> x
    
    {-  

    fun f1 =
          (x:xs)  -> let v1 
                       where
                         v1 = f2 (xs) 
                         fun f2 = 
                            (y:xs)  ->  1 + f3(xs) 
                         fun f3 = 
                            [] -> 0
    -} 
    fun f12 = 
      ys  -> f13(ys) 

    fun f13 = 
      []  -> 1
      zs  -> f12 (zs) 
  where 
    data List(A) -> C = Nil  ::   -> C
                        Cons :: A,C -> C 

proc p1 = 
  | console => w1 -> do 
       hput GetIntC on console
       get val on console
       put val on w1
       get val2 on w1
       hput PutIntC on console
       put val2 on console 
       close w1
       hput CloseC on console
       halt console

proc p2 =
  | w1 => w2 -> do 
       w2 |=| w1 

proc  p3 =
    | w2 => i1 -> do 
       get val on w2 
       hput PutInt on i1 
       put val on i1 
       hput GetInt on i1 
       get val2 on i1 
       put val2 on w2
       hput Close on i1 
       close i1 
       halt w2  

proc p4 = 
  | console => i2 ->
    plug 
      p1 ( | console => w1)
      p2 ( | w1 => w2)
      p3 ( | w2 => i2) 


run console => intTerm1 -> do 
           p4 (|console => intTerm1)


