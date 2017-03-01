coprotocol CP => Console (A) =
    GetIntC   :: CP => Put (A|CP)  
    PutIntC   :: CP => Get (A|CP) 
    CloseC    :: CP => TopBot  

protocol IntTerm (A) => P =
    GetInt   :: Get (A|P) => P 
    PutInt   :: Put (A|P) => P
    Close    :: TopBot    => P  

protocol InfPut (A) => P = 
    Putter :: Put (A|P) => P 

proc p1 = 
  | console => w1,w2 -> do 
       hput GetIntC on console
       get val on console
       close w1
       close w2
       hput CloseC on console
       halt console

proc p2 = 
  | w1,w2 =>  -> do 
       w1 |=| neg w2 

proc p3 = 
  | console =>  -> do 
       plug 
          p1 ( | console => w1,w2)
          p2 ( | w1,w2   => )


run console => intTerm1 -> do 
           hput GetInt on intTerm1
           get num1 on intTerm1
           hput GetInt on intTerm1
           get num2 on intTerm1
           hput Close on intTerm1 
           close intTerm1
           hput CloseC on console
           halt console  