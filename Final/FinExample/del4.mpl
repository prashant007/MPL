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

<<<<<<< HEAD
=======

>>>>>>> Experiment
protocol OnlyPut (A) => P = 
    JustPut :: Put (A|P) => P 
    CloseJ   :: TopBot => P   

<<<<<<< HEAD
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
        case val1 == 0 of 
          True  -> do 
            hput JustPut on ch
            put list on ch
            hput Close on i1
            close i1 
            hput CloseJ on ch 
            close ch
            hput CloseC on co 
            halt co 

          False -> do 
            p1 (val1:list | co => i1,ch)



run console => intTerm1,intTerm2 -> do
    plug 
      p1 ([]|console => intTerm1,ch)
      p2 (0,[] |ch => intTerm2)
=======

fun append :: [A],[A] -> [A] =
  []   ,ys    -> ys 
  x:xs ,ys  -> x:append (xs,ys)


fun reverse :: [A] -> [A] =
  []     -> []
  x:xs   -> append(reverse (xs),[x])

fun stringify_H :: [Int] -> [Char] = 
   []    -> [] 
   [x]   -> unstring(toStr(x))
   x:xs -> let 
            append(putComma,stringify_H(xs))
           where
            charRep = unstring(toStr(x)) 
            putComma= append (charRep,[','])

fun stringify :: [Int] -> [Char] =
  iList  -> let 
              '[':append (chList,[']'])
            where
              chList = stringify_H (iList)


proc getNums = 
    list | cco  => i1,ch -> do 
        hput GetTerm on i1    
        get num on i1

        case num == 0 of 
          True -> do 
            hput JustPut on ch 
            put reverse(list) on ch
            hput Close on i1
            close i1 
            hput CloseJ on ch 
            close ch 
            hput CloseC on cco
            halt cco 
          False -> 
            getNums (num:list| cco => i1,ch)   


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
        case str of 
          []    -> do 
            hcase pch of 
              JustPut -> do 
                get list on pch
                printNums (stringify(list),1 | pch => c1)
              CloseJ -> do 
                hput Close on c1
                close c1 
                halt pch 

          x:xs  -> do 
            hput PutTerm on c1
            put x on c1
            printNums (xs,mode | pch => c1)



proc appendNums =
    | ch => charTerm1 -> do 
    plug  
        receiveNums (| ch => pch) 
        printNums  (unstring("\nFinal List\n"),0 | pch => charTerm1)      
 


run cconsole => charTerm1,intTerm1 ->  
    plug 
      getNums    ( [] |cconsole  => intTerm1,ch)
      appendNums (|ch => charTerm1)
>>>>>>> Experiment
