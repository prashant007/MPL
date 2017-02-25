data List (A) -> D =   Nil  ::     -> D
                       Cons :: A,D -> D   

data Bool -> A = True  :: -> A
                 False :: -> A  

protocol IntTerm (A)  => P =
              GetInt   :: Get (A|P) => P 
              PutInt   :: Put (A|P) => P
              Close    :: Top       => P  

coprotocol CP => Console (A) =
              GetIntC   :: CP => Get (A|CP)  
              PutIntC   :: CP => Put (A|CP) 
              CloseC    :: CP => Bot 

protocol InfGetPut (A) => P = 
    Putter :: Put (A|P) => P
    Getter :: Get (A|P) => P 

coprotocol  CP => CoProtInf (A) = 
    PutterC :: CP => Put (A|CP) 
    GetterC :: CP => Get (A|CP)  

defn of
   proc p2 =
       |ch1 => ch2 -> do 
            hput Getter on ch2
            get val on ch2 
            hput PutterC on ch1
            put val on ch1
            p1 (| ch1 => ch2) 

   proc p1 =
       |ch1 => ch2 -> do 
            hput GetterC on ch1
            get val on ch1 
            hput Putter on ch2
            put val on ch2
            p2 (|ch1 => ch2) 




proc printList2 :: List(A) | Console (A) => IntTerm (A) = 
        list | console => intTerm1 ->  
            case list of
                [] -> do
                     hput Close on intTerm1
                     close intTerm1
                     hput CloseC on console
                     halt console                    
                (x:xs) -> do 
                     hput PutInt on intTerm1
                     put x on intTerm1
                     printList2 (xs| console => intTerm1)


run :: Console (A) => IntTerm (A) =
    console => intTerm1 -> 
        printList2 ([1,2,3] | console => intTerm1)
