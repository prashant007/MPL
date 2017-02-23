protocol IntTerm (A|) => P =
              GetInt   :: Get (A|P) => P 
              PutInt   :: Put (A|P) => P
              Close    :: Top       => P  


coprotocol CP => Console (A|) =
              GetInt   :: CP => Get (Int|CP)  
              PutInt   :: CP => Put (Int|CP) 
              Close    :: CP => Bot 

mutual 
   fun even :: Nat -> Nat =
       Zero    -> True
       Succ(n) -> odd(n) 

   fun odd :: Nat -> Nat =
       Zero    -> False
       Succ(n) -> even(n)      


          
proc p1 :: | Console (Int|) => Put(Int|Bot) (+) Put(Int|Bot) ,IntTerm(Int|) = 
  | console => w,intTerm1 -> do 
        hput IntTerm.GetInt on intTerm1          
        get x on intTerm1
        split w into w1,w2
        put x on w1
        put x on w2
        close w1
        close w2
        hput IntTerm.Close on intTerm1
        close intTerm1
        hput Console.Close on console
        halt console

proc p2 :: | Put (Int|Bot) (+) Put (Int|Bot) => IntTerm(A|),IntTerm(A|) = 
    | w => intTerm2,intTerm3 -> 
          plug 
              p1 (list| console => w,intTerm1)
              do
                 fork w as 
                   w1 -> do 
                       get x on w1
                       hput IntTerm.PutInt on intTerm2
                       put x on intTerm2
                       hput IntTerm.Close on intTerm2
                       close intTerm2
                       halt w1
                   w2  -> do 
                       get x on w2
                       hput IntTerm.PutInt on intTerm3
                       put x on intTerm3
                       hput IntTerm.Close on intTerm3
                       close intTerm3
                       halt w2
           


run console => intTerm1,intTerm2,intTerm3 -> 
      plug 
           p1 ( | console => w,intTerm1)
           p2 ( | w => intTerm2,intTerm3)
