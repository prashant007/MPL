--1. Find the last element of a list.
data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

data Maybe (A) -> C = Just    :: A -> C 
                      Nothing ::   -> C 

data Bool -> C = True  :: -> C
                 False :: -> C   

data Tree (A) -> C  = Empty  :: -> C
                      Branch :: A,C,C -> C 

fun myLast = 
    []     -> Nothing 
    [x]    -> Just (x) 
    (x:xs) -> myLast (xs) 

-- 2.Find the last but one element of a list.

fun myButLast = 
    []      -> []
    [x]     -> [] 
    (x:xs)  -> x:myButLast (xs)

-- (3) Find the K'th element of a list. The first element in the list is number 1.
fun elemAtK = 
    list,k -> case list of 
                  []     -> Nothing 
                  (l:ls) -> 
                     switch
                        k == 1   = Just (l) 
                        default  = elemAtK (ls,k-1)

-- (4) Find the number of elements of a list.
fun myLength = 
      list -> fold list of
                Nil  :        = 0
                Cons : xl,xsl = 1 + xsl 


fun append = 
     []   , ys     -> ys 
     (x:xs), ys    -> x:append (xs,ys) 

-- (5) Reverse a list.
fun myReverse =
      list -> case list of
                 []    -> []
                 l:ls  -> append(myReverse (ls),[l])       

fun eqList = 
     []  ,[]   -> True
     x:xs,y:ys -> switch
                     x == y  = eqList (xs,ys)
                     default = False

-- (6) Find out whether a list is a palindrome.
fun isPalindrome = 
     list -> switch 
               eqList(list,myReverse(list)) = True
               default = False

-- (7) Flatten a nested list structure.
fun flatten =
     []     -> []
     (x:xs) -> append (x,flatten (xs))

--(8) Eliminate consecutive duplicates of list elements.
fun compresHelper = 
       [],_  ->
           []
       l:ls,pelem -> 
           switch
               l == pelem = compresHelper (ls,pelem)
               default    = l:compresHelper (ls,l)   


fun compress =
      []   -> []
      l:ls -> l:compresHelper (ls,l)

--  (54) Check whether a given term represents a balanced binary tree

fun noOfNodes = 
     tree -> 
         fold tree of 
             Empty  : = 1
             Branch : a,t1,t2 = 1 + t1 + t2 

fun cbalTree = 
      Empty -> True 
      Branch (b,t1,t2) -> 
          let 
            res 
          where 
            res = balanceCond (t1,t2)
            fun balanceCond = 
               t1,t2 -> 
                    let num1-num2 == 0 || num1-num2 == 1
                     where    
                        num1 = noOfNodes (t1)
                        num2 = noOfNodes (t2)

         
           

