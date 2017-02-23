protocol IntTerm (A) => P =
              GetInt   :: Get (A|P) => P 
              PutInt   :: Put (A|P) => P
              Close    :: Top       => P  

coprotocol CP => Console (A) =
              GetIntC   :: CP => Get (Int|CP)  
              PutIntC   :: CP => Put (Int|CP) 
              CloseC    :: CP => Bot 

data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

fun zipfun :: [A],[B] -> [<A,B>] = 
    []    ,[]      -> []
    (x:xs),(y:ys)  -> (<x,y>:zipfun (xs,ys)) 
  
proc p1  = 
  st | console => ch1,ch2 -> do 
         hput GGetInt on console
         get x on console 
         put x on  ch1
         close ch1
         close ch2
         hput Close on console
         halt console

      


run console => intTerm1,intTerm2,intTerm3 -> 
      plug 
           p1 ( | console => w,intTerm1)
           p2 ( | w => intTerm2,intTerm3)
