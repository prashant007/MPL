--example for plugging on multiple channels
-- **** Get all the types RIGHT

protocol IntTerm (A|) => P =
              GetInt   :: Get (A|P) => P 
              PutInt   :: Put (A|P) => P
              Close    :: Top       => P  

coprotocol CP => Console (A|) =
              GetInt   :: CP => Get (A|CP)  
              PutInt   :: CP => Put (A|CP) 
              Close    :: CP => Bot 



proc p1 :: Int | Console(Int|) => Put (Int|Bot) = 
  st | console => ch1 -> do 
         hput Console.GetInt on console
         get x on console 
         put x on  ch1
         close ch1
         hput Console.Close on console
         halt console
    
     
proc  p3 :: | Put (Int|Bot) => Put(Int|Bot) = 
   | ch1 => ch2 -> do 
       get x on ch1
       put x on ch2
       close ch2
       halt ch1 
     

proc  p4 :: | Console (A|) => IntTerm (A|) = 
  | ch2 => intTerm1 -> do  
      get x on ch2
      hput IntTerm.PutInt on intTerm1
      put x on intTerm1
      hput IntTerm.Close on intTerm1
      close intTerm1
      halt ch2
     
proc p2 :: |Put (Int|Bot) => IntTerm (A|) = 
  | ch1 => intTerm1 ->
        plug 
            p3 ( |ch1 => ch2)
            p4 ( |ch2 => intTerm1)

       

         
run :: Console (A|) => IntTerm (A|) =
  console => intTerm1  -> 
    plug  
        p1 ( | console => ch1)
        p2 ( | ch1 => intTerm1)

