coprotocol CP => Console (A) =
    GetIntC   :: CP => Put (A|CP)  
    PutIntC   :: CP => Get (A|CP) 
    CloseC    :: CP => TopBot  

protocol IntTerm (A) => P =
    GetInt   :: Get (A|P) => P 
    PutInt   :: Put (A|P) => P
    Close    :: TopBot    => P  

protocol InfPut (A) => P = 
    Putter :: Put (A|P) => P 



proc p5 = 
  | ch1 => i1 -> do 
        hcase ch1 of 
            Putter -> do 
               get val on ch1 
               hput Putter on i1 
               put val on i1 
               p5 (| ch1 => i1)


proc p6 = 
  | ch1 => i1 -> do 
        hcase ch1 of 
            GetInt -> do 
              hput GetInt on i1     
              get x on i1 
              put x on ch1
              p6 (|ch1 => i1) 

            PutInt -> do 
              hput PutInt on i1   
              get x on ch1 
              put x on i1 
              p6 (|ch1 => i1)

            Close  -> do
              hput Close on i1    
              close i1 
              halt ch1  


proc p8 = 
   | ch1 => ch2 -> do 
       hcase ch2 of 
            GetIntC -> do 
              hput GetIntC on ch1 
              get val on ch1 
              put val on ch2
              p8 (| ch1 => ch2)

            PutIntC -> do 
              hput PutIntC on ch1 
              get val on ch2 
              put val on ch1
              p8 (| ch1 => ch2)

            CloseC  -> do 
              close ch2 
              hput CloseC on ch1
              halt ch1  



proc p7 = 
    | ch => iterm -> do 
        hput GetInt on iterm
        get x on iterm 
        fork ch as 
            ch1 -> do
               put x on ch1 
               hput Close on iterm
               close iterm
               halt ch1 
            ch2 -> do
               put x on ch2 
               halt ch2 

proc  p3 :: | Put (A|TopBot) => Put(A|TopBot) = 
   | ch1 => ch2 -> do 
       get x on ch1
       put x on ch2
       close ch2
       halt ch1 
     

proc  p4 :: |  Put (A|TopBot) => IntTerm (A) = 
  | ch2 => intTerm1 -> do  
      get x on ch2
      hput PutInt on intTerm1
      put x on intTerm1
      hput Close on intTerm1
      close intTerm1
      halt ch2
     
proc p2 :: |Put (A|TopBot) => IntTerm (A) = 
  | ch1 => intTerm1 ->
        plug 
            p3 ( |ch1 => ch2)
            p4 ( |ch2 => intTerm1)


run console => intTerm1 -> do 
           hput GetInt on intTerm1
           get num1 on intTerm1
           hput GetInt on intTerm1
           get num2 on intTerm1
           hput Close on intTerm1 
           close intTerm1
           hput CloseC on console
           halt console  

{-

[TQuant ([], [1,2])
        [TSimp (TypeVarInt 0, ProtProc ([], [TypeVarInt 1], [TypeVarInt 2], (4, 1))),
         TQuant ([], [3])
                [TSimp (TypeVarInt 1, ProtNamed ("InfPut", [TypeVarInt 11], (1, 24))),
                 TSimp (TypeVarInt 3,
                        Put (TypeVarInt 11,
                             ProtNamed ("InfPut", [TypeVarInt 11], (1, 24)),
                             (2, 15))),
                 TQuant ([], [7,8])
                        [TSimp (TypeVarInt 3, Put (TypeVarInt 7, TypeVarInt 8, (8, 16))),
                         TQuant ([], [9,10])
                                [TSimp (TypeVarInt 9, TypeVarInt 7),
                                 TSimp (TypeVarInt 2,
                                        Put (TypeVarInt 9, TypeVarInt 10, (9, 16))),
                                 TQuant ([], [])
                                        [TSimp (TypeVarInt 8, TypeVarInt 1),
                                         TSimp (TypeVarInt 10, TypeVarInt 2)]]]]]]

-}