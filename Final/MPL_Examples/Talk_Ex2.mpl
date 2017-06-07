protocol ProtTerm (A) => P =
    GetTerm   :: Get (A|P) => P 
    PutTerm   :: Put (A|P) => P
    Close     :: TopBot    => P  

coprotocol CP => Console (A) =
     GetIntC   :: CP => Put (A|CP)  
     PutIntC   :: CP => Get (A|CP) 
     CloseC    :: CP => TopBot 

protocol PutGetP (A) => P  = 
    HandPutGet :: Put (A|Get(A|P)) => P  
    HandClose  :: TopBot  => P 


proc putGet = 
    |co => i1,ch -> do 
        hput GetTerm on i1 
        get val on i1 
        hput HandPutGet on ch 
        put val on ch 
        get rval on ch 
        hput PutTerm on i1 
        put rval on i1 
        putGet (| co => i1,ch)

proc getPut =
    | ch => i2 -> do 
        hcase ch of 
          HandPutGet -> do 
            get val on ch 
            hput PutTerm on i2
            put val on i2
            hput GetTerm on i2 
            get sval on i2 
            put sval on ch 
            getPut (| ch => i2)

          HandClose -> do 
            hput Close on i2 
            close i2 
            halt ch 

run console => intTerm1,intTerm2 -> do 
    plug
      putGet  (| console => intTerm1,ch)
      getPut  (| ch => intTerm2)