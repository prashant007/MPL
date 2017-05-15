coprotocol CP => Console (A) =
    GetChanC   :: CP => Put (A|CP)  
    PutChanC   :: CP => Get (A|CP) 
    CloseC     :: CP => TopBot  

protocol Terminal (A) => P =
    GetChan   :: Get (A|P) => P 
    PutChan   :: Put (A|P) => P
    Close     :: TopBot    => P  

data List (A) -> C = Nil  :: -> C 
                     Cons :: A,C -> C   

proc getonChan :: 
    



run cconsole => charTerm1 -> do 
    hput PutChan on charTerm1
    put 'c' on charTerm1
    hput Close on charTerm1
    close charTerm1
    hput CloseC on cconsole
    halt cconsole
