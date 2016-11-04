data List (A) -> D =   Nil  ::     -> D
                       Cons :: A,D -> D   

protocol IntTerm (A|) => P =
              GetInt   :: Get (A|P) => P 
              PutInt   :: Put (A|P) => P
              Close    :: Top       => P  

coprotocol CP => Console (A|) =
              GetInt   :: CP => Get (A|CP)  
              PutInt   :: CP => Put (A|CP) 
              Close    :: CP => Bot 

fun &+ :: List(Nat) -> List(Nat) = 
    Nil         -> Nil
    Cons(x,xs)  -> switch 
                      x >= 0  = x + 5 +& 6 =& 8 - 9 --Cons(x,guardFunc(xs))
                      default = guardFunc(xs) 


proc printList1 :: List(A) | Console (A|) => IntTerm (A|) = 
    Nil        | console => intTerm1 -> do  
                     hput IntTerm.Close on intTerm1
                     close intTerm1
                     hput Console.Close on console
                     halt console

    Cons(x,xs) | console => intTerm1 -> do 
                     hput IntTerm.PutInt on intTerm1
                     put x on intTerm1
                     printList1 (xs| console => intTerm1)


proc printList2 :: List(A) | Console (A|) => IntTerm (A|) = 
        list | console => intTerm1 ->  
                    switch  
                        eqString(list,Nil) = 
                              hput IntTerm.Close on intTerm1
                              close intTerm1
                              hput Console.Close on console
                              halt console
                        default =
                              hput IntTerm.PutInt on intTerm1
                              put x on intTerm1
                              printList1 (xs| console => intTerm1) 


proc printList2 :: List(A) | Console (A|) => IntTerm (A|) = 
        list | console => intTerm1 ->  
            case list of
                Nil         -> do
                     hput IntTerm.Close on intTerm1
                     close intTerm1
                     hput Console.Close on console
                     halt console                    
                Cons (x,xs) -> do 
                     hput IntTerm.PutInt on intTerm1
                     put x on intTerm1
                     printList1 (xs| console => intTerm1)

proc printList3 :: List(A) | Console (A|) => IntTerm (A|) = 
        list | console => intTerm1 ->
                    case eqString(list,Nil) of
                        True ->  do 
                              hput IntTerm.Close on intTerm1
                              close intTerm1
                              hput Console.Close on console
                              halt console
                        False -> do
                              hput IntTerm.PutInt on intTerm1
                              put x on intTerm1
                              printList1 (xs| console => intTerm)



run :: Console (A|) => IntTerm (A|) =
    console => intTerm1 -> 
        printList1 (list | console => intTerm1)
