
protocol IntTerm (A) => P =
              GetInt   :: Get (A|P) => P 
              PutInt   :: Put (A|P) => P
              Close    :: TopBot    => P  

coprotocol CP => Console (A) =
    GetIntC   :: CP => Put (A|CP)  
    PutIntC   :: CP => Get (A|CP) 
    CloseC    :: CP => TopBot  

proc  p1 =
  | c1 => c2,w1 -> do 
      hput GetInt on c2
      get x on c2
      put x on w1
      get y on w1
      hput PutInt on c2
      put y on c2
      close w1 
      hput Close on c2
      close c2
      hput CloseC on c1
      halt c1
  
  
proc  p2 = 
   | w1 => w2 -> do  
      get x on w1
      put x on w2
      get y on w2
      put y on w1
      close w2
      halt w1
    
    
proc p3 = 
   | w2 => c4 -> do   
     get x on w2
     hput PutInt on c4
     put x on c4
     hput GetInt on c4 
     get y on c4
     put y on w2
     hput Close on c4
     close c4
     halt w2
    
run console => intTerm1,intTerm2 -> do  
   plug  
     p1 ( | console => intTerm1,w1) 
     p2 ( | w1 => w2)
     p3 ( | w2 => intTerm2) 