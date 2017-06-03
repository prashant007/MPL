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
proc getNums = 
    list | cco  => i1,ch -> do 
        hput GetTerm on i1 
        get num on i1  
        case num == 0 of 
          True -> do 
            hput JustPut on ch 
            put list  on ch
            hput CloseJ on ch 
            close ch 
            hput Close on i1 
            close i1
            hput CloseC on cco 
            halt cco 

          False -> 
            getNums (list ++ toStr(num)| cco => i1,ch)   

proc receiveNums =
    | ch => c1 -> do 
       hcase ch of 
         JustPut -> do 
           get val on ch 
           receiveNums ( | ch => c1 )
          
         CloseJ -> do 
           hput Close on c1 
           close c1
           halt ch         



proc printNums  = 
    str | ch => c1 -> do 
      hcase ch of 
        CloseJ -> 
      case str of 
        [] -> do 
           hput Close on c1 
           close c1 
           hput CloseJ on ch 
           halt ch 
        
        x:xs -> do
           hput PutTerm on c1 
           put x on c1
           printNums (xs | ch => c1)


run cconsole => charTerm1,intTerm1 ->  
    plug 
      getNums ("" |cconsole  => intTerm1,ch)
      receiveNums (| ch => charTerm1) 
-}

proc getNums = 
    list | cco  => i1,ch -> do 
        hput GetTerm on i1 
        get num on i1  
        case num == 0 of 
          True -> do 
            hput JustPut on ch 
            put list  on ch
            --getNums (list | cco => i1,ch)
            hput CloseJ on ch 
            close ch 
            hput Close on i1 
            close i1
            hput CloseC on cco 
            halt cco 

          False -> 
            getNums (list ++ unstring (toStr(num))| cco => i1,ch)   

proc receiveNums =
    | ch => pch -> do 
       hcase ch of 
         JustPut -> do 
           get val on ch 
           hput JustPut on pch 
           put val on pch
           receiveNums ( | ch => pch)
          
         CloseJ -> do 
           hput CloseJ on pch 
           close pch 
           halt ch         



proc printNums  = 
    str,mode | pch => c1 -> do 
        case mode /= 0 of 
          True -> 
            case str of 
              []    -> do 
                hcase pch of 
                  JustPut -> do 
                    get sthg on pch
                    printNums (['a'],1 | pch => c1)
                  CloseJ -> do 
                    hput Close on c1
                    close c1 
                    halt pch 

              x:xs  -> do 
                hput PutTerm on c1
                put x on c1
                printNums (xs,mode | pch => c1)

          False -> do 
            hcase pch of 
                JustPut -> do 
                  get list on pch 
                  printNums (list,1 | pch => c1)
                CloseJ   -> do 
                    hput Close on c1
                    close c1 
                    halt pch 


run cconsole => charTerm1,intTerm1 ->  
    plug 
      getNums ( ['a'] |cconsole  => intTerm1,ch)
      receiveNums (| ch => pch) 
      printNums  (['a'],0 | pch => charTerm1)
