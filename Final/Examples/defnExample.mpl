defn of 
     fun f1 = 
         x,y -> x + whereFunc(x,y)

     proc p1 =
         | console => w,intTerm1 -> do 
              hput IntTerm.GetInt on intTerm1
              get val1 on intTerm1
              hput IntTerm.GetInt on intTerm1
              get val2 on intTerm1
              put f1(val1,val2) on w 
              close w 
              hput IntTerm.Close on intTerm1
              close intTerm1
              hput Console.Halt on console 
              halt console 
  where
      fun whereFunc :: A,A -> A =
          a,b -> a + b            


proc p2  =
     | w => intTerm2 -> do 
          get res on w 
          hput IntTerm.PutInt on intTerm2
          put res on intTerm2
          hput IntTerm.Close on intTerm2
          close intTerm2
          halt w 

run console => intTerm1,intTerm2 -> 
      plug 
           p1 ( | console => w,intTerm1)
           p2 ( | w => intTerm2)



  
