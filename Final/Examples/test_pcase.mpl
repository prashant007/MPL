protocol IntTerm (A|) => P =
        GetInt   :: Get (A|P) => P 
        PutInt   :: Put (A|P) => P
        Close    :: Top       => P  

coprotocol CP => Console (A|) =
        GetInt   :: CP => Get (A|CP)  
        PutInt   :: CP => Put (A|CP) 
        Close    :: CP => Bot  

data Bool -> C = False :: () -> C 
                 True  :: () -> C 



run console => intTerm1 -> do 
           hput IntTerm.GetInt on intTerm1
           get num1 on intTerm1
           hput IntTerm.GetInt on intTerm1
           get num2 on intTerm1
           case num2 <= num1 of                                               
                False -> do
                        hput IntTerm.PutInt on intTerm1
                        put num2 on intTerm1  
                True  -> do  
                        hput IntTerm.PutInt on intTerm1
                        put num1 on intTerm1  
 
           hput IntTerm.Close on intTerm1 
           close intTerm1
           hput Console.Close on console
           halt console  
