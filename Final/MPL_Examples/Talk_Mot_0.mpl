protocol IntTerm (A) => P =
    GetInt    :: Get (A|P) => P 
    PutInt    :: Put (A|P) => P
    Close     :: TopBot    => P  

proc p1 = 
  |  => ch-> do 
       get val on ch
       halt ch 

proc p2 =
  | ch =>  -> do 
      put 5 on ch
      halt ch 


run console => intTerm1 -> do 
    plug 
      p1 ( |    => ch)
      p2 ( | ch => )
