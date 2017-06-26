protocol IntTerm (A) => P =
    GetInt    :: Get (A|P) => P 
    PutInt    :: Put (A|P) => P
    Close     :: TopBot    => P  


proc p2 :: |  => IntTerm (Int),Put(Int|TopBot) =
    |  => s1,ch2 -> do 
        hput GetInt on s1
        get x on s1
        put x on ch2
        hput Close on s1
        close s1 
        halt ch2


proc p3 :: |  Put (Int|TopBot) => Put (Int|TopBot) =
    | ch2 => ch1 -> do 
       get x on ch2
       put x on ch1 
       close ch2
       halt ch1

proc p1 :: | Put (Int|TopBot) => IntTerm (Int) = 
     | ch1 => s2 -> do 
        get x on ch1 
        hput PutInt on s2 
        put x on s2 
        hput Close on s2 
        close s2
        halt ch1

run => intTerm1,intTerm2 -> do 
    plug
      p2 ( | => intTerm1,ch2)  
      p3 ( | ch2 => ch1) 
      p1 ( | ch1 => intTerm2 )
