protocol IntTerm (A) => P =
      GetInt   :: Get (A|P) => P 
      PutInt   :: Put (A|P) => P
      Close    :: TopBot    => P  


coprotocol CP => Console (A) =
      GetIntC   :: CP => Put (A|CP)  
      PutIntC   :: CP => Get (A|CP) 
      CloseC    :: CP => TopBot 

          
proc p1 :: | Console (A) => Put(A|TopBot) (+) Put(A|TopBot), IntTerm(A) = 
  | console => ch,intTerm1 -> do 
        hput GetInt on intTerm1          
        get x on intTerm1
        split ch into ch1,ch2
        put x on ch1
        --get y on ch1
        put x on ch2
        close ch1
        close ch2
        hput Close on intTerm1
        close intTerm1
        hput CloseC on console
        halt console


proc p21 = 
    | ch1 => intTerm2 -> do 
       get x on ch1
       hput PutInt on intTerm2
       put x*x on intTerm2
       hput Close on intTerm2
       close intTerm2
       halt ch1

proc p22 =
    | ch2 => intTerm3 -> do   
       get x on ch2
       --get y on ch2
       hput PutInt on intTerm3
       put x*x*x on intTerm3
       hput Close on intTerm3
       close intTerm3
       halt ch2


proc p2  = 
    | ch => intTerm2,intTerm3 -> 
       fork ch as 
         ch1 -> do 
           p21 ( | ch1 => intTerm2)   
         ch2  -> do 
           p22 ( | ch2 => intTerm3) 
          

run console => intTerm1,intTerm2,intTerm3 -> 
      plug 
         p1 ( | console => ch,intTerm1)
         p2 ( | ch => intTerm2,intTerm3)
