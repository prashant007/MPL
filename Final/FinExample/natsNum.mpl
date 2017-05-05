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
             
fun someThing =
   ns -> Head (ns)
          
proc proc1 =
  ns|c => in1 -> do 
       hput PutInt on in1
       put  Head (ns) on in1
       proc1 (Tail (ns)  | c => in1)
      
fun nats = 
  n ->
     (: Head := n , Tail := nats (n+1) :)               
                       
run console => intTerm1 -> do  
    hput GetInt on intTerm1
    get num on intTerm1
    proc1 ( nats(num) | console => intTerm1)
