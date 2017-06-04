protocol IntTerm (A) => P =
              GetInt   :: Get (A|P) => P 
              PutInt   :: Put (A|P) => P
              Close    :: Top       => P  

coprotocol CP => Console (A) =
    GetIntC   :: CP => Put (A|CP)  
    PutIntC   :: CP => Get (A|CP) 
    CloseC    :: CP => TopBot  
        
codata C -> Exp(A,B) = App :: A,C -> B 

fun f1  =
   ->  (: App(y) :=  y + 1 :) 

run console => intTerm1 -> do 
     hput GetInt on intTerm1  
     get num on intTerm1
     hput PutInt on intTerm1  
     put App(num,f1) on intTerm1
     hput Close on intTerm1  
     close intTerm1 
     hput CloseC on console 
     halt console