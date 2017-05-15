protocol IntTerm (A) => P =
              GetInt   :: Get (A|P) => P 
              PutInt   :: Put (A|P) => P
              Close    :: Top       => P  

coprotocol CP => Console (A) =
    GetIntC   :: CP => Put (A|CP)  
    PutIntC   :: CP => Get (A|CP) 
    CloseC    :: CP => TopBot  

codata C -> InfList (A) =
          Head :: C -> A  
          Tail :: C -> C       


fun sthg =
  -> 1 

fun sthg2 =
   -> 123445 + sthg 
          
fun random = 
  x,y,z -> let 
              f1 
           where
              v1 = x + y + z
              fun f1 = 
                 -> v1 * v1


proc proc1 =
  ns|c => in1 -> do 
       hput PutInt on in1
       put ns on in1
       proc1 (ns| c => in1)
                       
run console => intTerm1 -> do  
    proc1 ( random(1,2,3) | console => intTerm1)
