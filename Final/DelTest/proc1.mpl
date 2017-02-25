
coprotocol CP => Console (A) =
    GetIntC   :: CP => Get (A|CP)  
    PutIntC   :: CP => Put (A|CP) 
    CloseC    :: CP => TopBot  

protocol IntTerm (A) => P =
    GetInt   :: Get (A|P) => P 
    PutInt   :: Put (A|P) => P
    Close    :: TopBot    => P  

protocol InfPut (A) => P = 
    Putter :: Put (A|P) => P 

data Bool -> C = False ::  -> C 
                 True  ::  -> C 

data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

fun append = 
     []   , ys     -> ys 
     (x:xs), ys    -> x:append (xs,ys) 


proc p6 =
  (p:ps),(q:qs) | ch1 => ch2 -> do 
       get x on ch1
       put x on ch2
       put p + q on ch1
       close ch2 
       halt ch1 


proc p1 :: A | Console (B) => Put (B|TopBot)   = 
  st | console => ch1 -> do 
         hput GetIntC on console
         get x on console 
         put x on  ch1
         close ch1
         hput CloseC on console
         halt console

proc p4 :: | Console (A) => Put (A|TopBot),TopBot =
  | console => ch1,ch2 -> do
        close ch2  
        p1 (0| console => ch1)


proc p3  = 
  st | console => ch1 -> do 
         hput GetIntC on console
         get x on console 
         hput Putter on ch1 
         put x on ch1 
         p3 (st|console => ch1)


proc p2  = 
  st | ch1 => i1 -> do 
         hput GetInt on i1 
         get x on i1  
         put x on  ch1
         close ch1
         hput Close on i1 
         halt i1 



run console => intTerm1 -> do 
           hput GetInt on intTerm1
           get num1 on intTerm1
           hput GetInt on intTerm1
           get num2 on intTerm1
           hput Close on intTerm1 
           close intTerm1
           hput CloseC on console
           halt console  


