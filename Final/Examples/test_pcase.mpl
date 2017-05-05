protocol IntTerm (A) => P =
              GetInt   :: Get (A|P) => P 
              PutInt   :: Put (A|P) => P
              Close    :: Top       => P  

coprotocol CP => Console (A) =
    GetIntC   :: CP => Put (A|CP)  
    PutIntC   :: CP => Get (A|CP) 
    CloseC    :: CP => TopBot  


data Bool -> C = False ::  -> C 
                 True  ::  -> C 

run console => intTerm1 -> do 
       hput GetInt on intTerm1
       get num1 on intTerm1
       hput GetInt on intTerm1
       get num2 on intTerm1
       case num2 <= num1 of                                               
            False -> do
               hput PutInt on intTerm1
               put num2 on intTerm1  
               hput Close on intTerm1 
               close intTerm1
               hput CloseC on console
               halt console  

            True  -> do  
              hput PutInt on intTerm1
              put num1 on intTerm1  
              hput Close on intTerm1 
              close intTerm1
              hput CloseC on console
              halt console  

