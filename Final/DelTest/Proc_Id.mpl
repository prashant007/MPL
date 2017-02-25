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

proc p1 = 
  | console => w1 -> do 
       hput GetIntC on console
       get val on console
       put val on w1
       close w1
       hput CloseC on console
       halt console

proc p2 =
  | w1 => w2 -> do 
       w2 =|= w1 

proc  p3 =
    | w2 => i1 -> do 
       get val on w2 
       hput PutInt on i1 
       put val on i1 
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
           hput GetInt on intTerm1
           get num1 on intTerm1
           hput GetInt on intTerm1
           get num2 on intTerm1
           hput Close on intTerm1 
           close intTerm1
           hput CloseC on console
           halt console  

