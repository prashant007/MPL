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
              '[':remList
            where
              chList  = stringify_H (iList)
              remList = append (chList,unstring("]\n\n"))

fun aListHelp :: [[Int]] -> [Int] = 
   []     -> []
   x:xs   -> (append (x,aListHelp(xs)))


fun appendList :: [[Int]] -> [Int] = 
  list -> let 
             aListHelp (rlist)
          where
             rlist = reverse (list)

proc getNums = 
    list,count | cco  => i1,ch -> do 
        case count <= 0 of 
          True  -> do 
            hput Close on i1
            close i1 
            hput CloseJ on ch 
            close ch 
            hput CloseC on cco
            halt cco 
          False -> do 
            hput GetTerm on i1    
            get num on i1
            case num == 0 of 
              True -> do 
                hput JustPut on ch 
                put reverse(list) on ch
                getNums ([],count-1| cco => i1,ch) 
              False -> 
                getNums (num:list,count| cco => i1,ch)   


proc receiveNums =
    list | ch => pch -> do 
       hcase ch of 
         JustPut -> do 
           get val on ch 
           hput JustPut on pch 
           put val on pch
           receiveNums ( val:list| ch => pch)
          
         CloseJ -> do 
           hput JustPut on pch 
           put appendList (list) on pch 
           hput CloseJ on pch 
           close pch 
           halt ch         



proc printNums  = 
    str | pch => c1 -> do 
        case str of 
          []    -> do 
            hcase pch of 
              JustPut -> do 
                get list on pch
                printNums (stringify(list) | pch => c1)
              CloseJ -> do 
                hput Close on c1
                close c1 
                halt pch 

          x:xs  -> do 
            hput PutTerm on c1
            put x on c1
            printNums (xs | pch => c1)



proc appendNums =
    | ch => charTerm1 -> do 
    plug  
        receiveNums ([]| ch => pch) 
        printNums  (unstring("\n\nList Representation\n\n") | pch => charTerm1)      
 


run cconsole => charTerm1,intTerm1 ->  
    plug 
      getNums    ( [],2 |cconsole  => intTerm1,ch)
      appendNums (|ch => charTerm1)
