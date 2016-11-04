fun preorder :: Tree(A) -> List (A) = 
    t -> fold t of 
             Leaf :  =  
                  x ++ z : y 
             --Branch : val,lc,rc =  
             --  lc ++ [val] ++ rc  