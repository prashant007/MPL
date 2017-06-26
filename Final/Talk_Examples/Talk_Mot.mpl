
proc p1 = 
  |  => ch-> do 
       get val on ch
       halt ch 

proc p2 =
  | ch =>  -> do 
      get val on ch
      halt ch 


run console => intTerm1 -> do 
    plug 
      p1 ( |    => ch)
      p2 ( | ch => )
