data List (A) -> C =
    Nil  ::     -> C 
    Cons :: A,C -> C 

data GetPut(A) -> C = 
    ListGt :: List (A) -> C 
    Ready  ::          -> C 

data Bool -> C =
    False :: -> C 
    True  :: -> C 


protocol ProtTerm (A) => P =
    GetTerm  :: Get (A|P) => P 
    PutTerm  :: Put (A|P) => P
    Close    :: TopBot    => P  

coprotocol CP => CoprotTerm (A) =
    GetTermC :: CP => Put (A|CP)  
    PutTermC :: CP => Get (A|CP) 
    CloseC   :: CP => TopBot  

protocol ProtListTerm (B) => P =
    GetList  :: Get (List (B)| P) => P 
    CloseL   :: TopBot            => P  


fun append = 
    []    , ys  -> ys 
    (x:xs), ys  -> x:append (xs,ys) 

fun reverse =
    l -> case l of 
           []     -> []
           (x:xs) -> append (reverse (xs),[x])



proc charlistTerm =
  d | ch => out1,out2 -> 
    case d of
      Ready ->              -- charlistTerm process is ready for input from calling routine
        hcase ch of 
          GetList -> 
            charlistTerm (ListGt(Nil) | ch => out1,out2) 
      
      -- intlistTerm process collecting input until there is a newline character '\n'
      ListGt(xs) -> do         
        hput GetTerm on out1
        get x on out1                        
        charlistTerm( ListGt(x:xs) | ch => out1,out2)                   
            


run cconsole => charTerm1,charTerm2 -> do
    hput Close on charTerm1
    close charTerm1
    hput Close on charTerm2
    close charTerm2
    hput CloseC on cconsole
    halt cconsole


    {-
    plug 
      do
          -- this process collects two lists
          hput GetList on ch 
          get v1 on ch  
          hput CloseL on ch 
          close ch
          hput CloseC on cconsole 
          halt cconsole
 
      charlistTerm(Ready|ch => charTerm1,charTerm2) 
    -}           
