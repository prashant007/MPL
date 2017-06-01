protocol ProtTerm (A) => P =
    GetTerm  :: Get (A|P) => P 
    PutTerm  :: Put (A|P) => P
    Close    :: TopBot    => P  

coprotocol CP => CoprotTerm (A) =
    GetTermC :: CP => Put (A|CP)  
    PutTermC :: CP => Get (A|CP) 
    CloseC   :: CP => TopBot  

data Bool -> C =
    False :: -> C 
    True  :: -> C 

proc someProc1 = 
  n |  => ch,i1 -> do 
    hput GetTerm on i1 
    get val on i1 
    hput PutTerm on ch 
    put val on ch
    case n == 4 of 
        True  -> do 
          hput GetTerm on ch 
          get chVal on ch 
          hput PutTerm on i1 
          put chVal on i1
          someProc1 (n+1| => ch,i1)

        False -> do 
          someProc1 (n+1| => ch,i1)

proc someProc2 = 
    | ch => i2 -> do 
        hcase ch of 
          GetTerm -> do 
             hput GetTerm on i2 
             get val on i2
             put val on ch 
             someProc2 (|ch => i2)

          PutTerm -> do 
            get val on ch 
            hput PutTerm on i2 
            put val on i2 
            someProc2 (|ch => i2)
            

          Close -> do
            hput Close on i2 
            close i2 
            halt ch 


run  => intTerm1,intTerm2 -> do 
    plug 
      someProc1 (0| => ch,intTerm1)
      someProc2 ( |ch => intTerm2)