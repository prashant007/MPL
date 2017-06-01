data List (A) -> C =
    Nil  ::     -> C 
    Cons :: A,C -> C 

data GetPut(A) -> C = 
    ListGt :: List (A) -> C 
    ListPt :: List (A) -> C 
    Ready  ::          -> C 

data Bool -> C =
    False :: -> C 
    True  :: -> C 

{-
protocol ProtListTerm (B) => P =
    GetList  :: Get (List (B)) => P 
    PutList  :: Put (List (B)) => P
    CloseL   :: TopBot         => P  
-}

protocol ProtTerm (A) => P =
    GetTerm  :: Get (A|P) => P 
    PutTerm  :: Put (A|P) => P
    Close    :: TopBot    => P  

coprotocol CP => CoprotTerm (A) =
    GetTermC :: CP => Put (A|CP)  
    PutTermC :: CP => Get (A|CP) 
    CloseC   :: CP => TopBot  


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
          GetTerm -> 
            charlistTerm (ListGt(Nil) | ch => out1,out2) 

          PutTerm -> do 
            get x on ch 
            charlistTerm (ListPt(x) | ch => out1,out2) 

          Close -> do 
            hput Close on out1
            close out1
            hput Close on out2
            close out2
            halt ch
       
      -- intlistTerm process collecting input until there is a newline character '\n'
      ListGt(xs) -> do         
        hput GetTerm on out1
        get x on out1                        
        case eqC (x,'\n') of
          True -> do 
            --put reverse(xs) on ch
            put xs on ch 
            charlistTerm (Ready | ch => out1,out2)

          False -> do                       
            charlistTerm( ListGt(x:xs) | ch => out1,out2)
       
      ListPt(xs) ->         -- inlistTerm process outputs a list
        case xs of
          [] -> do
            charlistTerm( Ready | ch => out1,out2)

          y:ys -> do
            hput PutTerm on out2 
            put y on out2
            charlistTerm( ListPt(ys) | ch => out1,out2) 

run cconsole => charTerm1,charTerm2 -> do
    plug 
      do
          -- this process collects two lists
          hput GetTerm on ch 
          get v1 on ch  
          hput GetTerm on ch
          get v2 on ch  
          hput PutTerm on ch 
          put append(v1,v2) on ch
          hput Close on ch 
          close ch
          hput CloseC on cconsole 
          halt cconsole
 
      charlistTerm(Ready|ch => charTerm1,charTerm2) 
               
