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


coprotocol CP => OnlyPut (A)  = 
    JustPut  :: CP => Get (A|CP)  
    CloseJP  :: CP => TopBot 

protocol OnlyGet (A) => P  = 
    JustGet :: Get (A|P) => P  
    CloseJG :: TopBot  => P 


fun append :: [A],[A] -> [A] =
  []   ,ys    -> ys 
  x:xs ,ys  -> x:append (xs,ys)


fun reverse :: [A] -> [A] =
  []     -> []
  x:xs   -> append(reverse (xs),[x])

fun stringify_H :: [Int] -> [Char] = 
   []    -> [] 
   [x]   -> unstring(toStr(x))
   x:xs -> append(putComma,stringify_H(xs))
            where
              charRep = unstring(toStr(x)) 
              putComma= append (charRep,[','])

fun stringify :: [Int] -> [Char] =
  iList  -> '[':remList
              where
               chList  = stringify_H (iList)
               remList = append (chList,unstring("]\n\n"))

fun aListHelp :: [[Int]] -> [Int] = 
   []     -> []
   x:xs   -> (append (x,aListHelp(xs)))


fun appendList :: [[Int]] -> [Int] = 
  list -> aListHelp (rlist)
           where
            rlist = reverse (list)



proc mainProc = 
  | pch => ch -> do 
    hput JustGet on ch 
    get l1 on ch 
    hput JustPut on pch 
    put l1 on pch 
    hput JustGet on ch 
    get l2 on ch 
    hput JustPut on pch 
    put l2 on pch 
    hput JustPut on pch 
    put append(l1,l2) on pch 
    hput CloseJG on ch 
    close ch 
    hput CloseJP on pch 
    halt pch 



proc printNums  = 
    str | cco => c1,pch -> do 
        case str of 
          []    -> do 
            hcase pch of 
              JustPut -> do 
                get list on pch
                printNums (stringify(list) | cco => c1,pch)
              CloseJP -> do 
                hput Close on c1
                close c1 
                hput CloseC on cco
                close cco 
                halt pch 

          x:xs  -> do 
            hput PutTerm on c1
            put x on c1
            printNums (xs | cco => c1,pch)


proc numsGetter = 
  list,count | ch => i1 -> do 
    case count <= 2 of 
      False  -> do
        hcase ch of 
          JustGet -> do 
            put [] on ch
            numsGetter ([],count| ch => i1)            
          CloseJG -> do 
            hput Close on i1 
            close i1
            halt ch 

      True -> do
        hput GetTerm on i1 
        get num on i1
        case num <= 0 of 
          True  -> do
            hcase ch of 
              JustGet -> do 
                put reverse(list) on ch
                numsGetter ([],count + 1| ch => i1)            
              CloseJG -> do 
                hput Close on i1 
                close i1
                halt ch 

          False -> do
            numsGetter (num:list,count | ch => i1)

run cconsole => charTerm1,intTerm1 -> do
   plug 
     printNums (unstring("\nList Rep:\n\n")|cconsole => charTerm1,pch)
     mainProc  (| pch => ch)
     numsGetter ([],1 | ch => intTerm1)
     
