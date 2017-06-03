

coprotocol CP => Console (A) =
     GetIntC   :: CP => Put (A|CP)  
     PutIntC   :: CP => Get (A|CP) 
     CloseC    :: CP => TopBot 

protocol ProtTerm (A) => P =
    GetTerm   :: Get (A|P) => P 
    PutTerm   :: Put (A|P) => P
    Close     :: TopBot    => P  

data List (A) -> C =
    Nil  ::     -> C 
    Cons :: A,C -> C 

data Bool -> C =
    False :: -> C 
    True  :: -> C 

proc p1 = 
   str | co => i1 -> do  
    case str of 
      [] -> do 

        hput Close on i1 
        close i1 
        hput CloseC on co  
        halt co   
      x:xs -> do 
        hput PutTerm on i1 
        put x on i1 
        p1 (xs| co => i1)
     

run cconsole => charTerm1 -> do
    p1 ("hola" ++ "hi" ++ "bye" ++ "sthg" | cconsole => charTerm1)