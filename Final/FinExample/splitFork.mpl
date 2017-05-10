protocol IntTerm (A) => P =
              GetInt   :: Get (A|P) => P 
              PutInt   :: Put (A|P) => P
              Close    :: TopBot  => P  


coprotocol CP => Console (A) =
              GetIntC   :: CP => Put (A|CP)  
              PutIntC   :: CP => Get (A|CP) 
              CloseC    :: CP => TopBot 

          
proc p1 :: | Console (A) => Put(A|TopBot) (+) Put(A|TopBot) ,IntTerm(A) = 
  | console => w,intTerm1 -> do 
        hput GetInt on intTerm1          
        get x on intTerm1
        split w into w1,w2
        put x on w1
        put x on w2
        close w1
        close w2
        hput Close on intTerm1
        close intTerm1
        hput CloseC on console
        halt console

proc p2  = 
    | w => intTerm2,intTerm3 -> 
         fork w as 
           w1 -> do 
               get x on w1
               hput PutInt on intTerm2
               put x on intTerm2
               hput Close on intTerm2
               close intTerm2
               halt w1
           w2  -> do 
               get x on w2
               hput PutInt on intTerm3
               put x on intTerm3
               hput Close on intTerm3
               close intTerm3
               halt w2
           

proc p3 =
    | console => w1 -> do 
        hput GetIntC on console 
        get val on console
        put val on w1 
        close w1 
        hput CloseC on console
        halt console

proc p4 = 
   | w1 => w2 -> do 
        get val on w1 
        put val on w2 
        close w2 
        halt w1

proc p5 = 
   | w2 => i1 -> do 
      get val on w2 
      hput PutInt on i1  
      put val on i1 
      hput Close on i1 
      close i1 
      halt w2  

proc p6 = 
   | c => i1 ->  
      plug
         p3 (|c  => w1)
         p4 (|w1 => w2)
         p5 (|w2 => i1)






run console => intTerm1,intTerm2,intTerm3 -> 
      plug 
           p1 ( | console => w,intTerm1)
           p2 ( | w => intTerm2,intTerm3)
