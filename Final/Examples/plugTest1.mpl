coprotocol CP => Console (A) =
    GetIntC   :: CP => Put (A|CP)  
    PutIntC   :: CP => Get (A|CP) 
    CloseC    :: CP => TopBot  

protocol IntTerm (A) => P =
    GetInt   :: Get (A|P) => P 
    PutInt   :: Put (A|P) => P
    Close    :: TopBot    => P  


proc p1  =
   | console => ch1 -> do 
       hput GetIntC on console
       get x on console 
       put x on  ch1
       close ch1
       hput CloseC on console
       halt console
    
     
proc  p3 =
   | ch1 => ch2 -> do 
        get x on ch1
        put x on ch2
        close ch2
        halt ch1 
       

proc  p4  ( | ch2 => intTerm1) -> do  
      get x on ch2
      hput PutInt on intTerm1
      put x on intTerm1
      hput Close on intTerm1
      close intTerm1
      halt ch2
     
proc p2 ( |ch1 => intTerm1) -> do  
        plug 
          p3 ( |ch1 => ch2)
          p4  ( |ch2 => intTerm1)

       

         
run (console => intTerm1) -> do  
   plug  
     p1 ( | console => ch1)
     p2 ( | ch1 => intTerm1)  
       
