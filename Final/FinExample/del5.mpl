data List (A) -> C =
    Nil  ::     -> C 
    Cons :: A,C -> C 

data Bool -> C =
    False :: -> C 
    True  :: -> C 

protocol ProtTerm (A) => P =
    GetTerm   :: Get (A|P) => P 
    PutTerm   :: Put (A|P) => P
    Close     :: TopBot    => P  

coprotocol CP => Console (A) =
     GetIntC   :: CP => Put (A|CP)  
     PutIntC   :: CP => Get (A|CP) 
     CloseC    :: CP => TopBot 

protocol OnlyPut (A) => P = 
    JustPut :: Put (A|P) => P 
    CloseJ   :: TopBot => P   

{-
fun myappend :: [A],[A] -> [A] = 
  []   , ys -> ys 
  x:xs , ys -> x:myappend (xs,ys) 
-}


fun append123 :: [A],[A] -> [A] = 
  []    , ys -> ys 
  x:xs  , ys -> x:(append123 (xs,ys))


fun reverse :: [A] -> [A] = 
   []   -> []
   x:xs -> append123 (reverse(xs),[x])

proc p2 = 
   mode,list | ch => i2 -> do 
     case mode == 0 of
        True -> do 
            hcase ch of 
              JustPut -> do 
                get val on ch 
                p2 (1,val| ch => i2)

              CloseJ -> do
                hput Close on i2 
                close i2 
                halt ch  

        False -> do 
            case list of 
                [] -> do 
                    hcase ch of 
                      JustPut -> do 
                        get sthg on ch 
                        p2 (1,sthg| ch => i2)

                      CloseJ   -> do
                        hput Close on i2 
                        close i2 
                        halt ch  

                x:xs -> do 
                    hput PutTerm on i2 
                    put x on i2 
                    p2 (1,xs | ch => i2)

proc p1 = 
   list |co => i1 , ch -> do 
        hput GetTerm on i1 
        get val1 on i1 
        case val1 == '\n' of 
          True  -> do 
            hput JustPut on ch
            put reverse(list) on ch
            hput Close on i1
            close i1 
            hput CloseJ on ch 
            close ch
            hput CloseC on co 
            halt co 

          False -> do 
            p1 ( (val1:list) | co => i1,ch)



run cconsole => charTerm1,charTerm2 -> do
    plug 
      p1 ([]|cconsole => charTerm1,ch)
      p2 (0,[] |ch => charTerm2)