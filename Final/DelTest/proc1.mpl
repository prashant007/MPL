
coprotocol CP => Console (A) =
        GetIntC   :: CP => Get (A|CP)  
        PutIntC   :: CP => Put (A|CP) 
        CloseC    :: CP => TopBot  

protocol IntTerm (A) => P =
        GetInt   :: Get (A|P) => P 
        PutInt   :: Put (A|P) => P
        Close    :: TopBot    => P  



data Bool -> C = False ::  -> C 
                 True  ::  -> C 

data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

fun append = 
     []   , ys     -> ys 
     (x:xs), ys    -> x:append (xs,ys) 

proc p1 :: Int | Console(Int) => Put (Int|TopBot) = 
  st | console => ch1 -> do 
         hput GetIntC on console
         get x on console 
         put x on  ch1
         close ch1
         hput CloseC on console
         halt console

{-
proc p2 :: Int | Console(Int) => Put (Int|TopBot) = 
  st | console => ch1 -> do 
         hput GetInt on console
         get x on console 
         put x on  ch1
         close ch1
         hput Close on console
         halt console
-}

run console => intTerm1 -> do 
           hput GetInt on intTerm1
           get num1 on intTerm1
           hput GetInt on intTerm1
           get num2 on intTerm1
           hput Close on intTerm1 
           close intTerm1
           hput CloseC on console
           halt console  
