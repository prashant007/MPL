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


protocol ProtListTerm (B) => P =
    GetList  :: Get (List (B)| P) => P 
    PutList  :: Put (List (B)| P) => P
    CloseL   :: TopBot         => P  


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
  v | ch => out1,out2 -> 
      case v of 
        Ready  -> do 
          hcase ch of 
            GetList -> do 
              charlistTerm (ListGt ([]) | ch => out1,out2)

            PutList -> do 
              get list on ch 
              charlistTerm (ListPt (list) | ch => out1,out2)

            CloseL  -> do 
              hput Close on out1 
              close out1 
              hput Close on out2
              close out2
              halt ch 

        ListGt (xl) -> do
          get val on out1
          case eqC (val,'\n') of 
            True  -> do 
              put xl on ch  
              charlistTerm (Ready | ch => out1,out2)

            False -> do 
              charlistTerm (ListGt (val:xl)| ch => out1,out2)

        ListPt (xl) -> do 
          case xl of 
            [] -> 
              charlistTerm (Ready | ch => out1,out2)
            (x:xs) -> do 
              hput PutTerm on out1 
              put x on out1
              charlistTerm (ListPt (xs) |ch => out1,out2)





proc mainProc = 
  | cconsole => ch -> do 
      hput GetList on ch 
      get v1 on ch  
      --hput GetList on ch
      --get v2 on ch  
      hput PutList on ch 
      put v1 on ch
      hput CloseL on ch 
      close ch
      hput CloseC on cconsole 
      halt cconsole



run cconsole => charTerm1,charTerm2 -> do
    plug 
      mainProc (|cconsole => ch)
      charlistTerm(Ready|ch => charTerm1,charTerm2) 
               
