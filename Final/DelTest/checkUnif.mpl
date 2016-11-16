data UnifData -> C =  Funs :: Int,[C] -> C 
                      Var  :: Int -> C    

data UnifEqn -> C = Eqn :: UnifData,UnifData -> C 

data SF (A) -> C = SS :: A -> C  
                   FF ::   -> C

data Bool -> C = True  :: -> C
                 False :: -> C   


data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

defn of

    fun occursCheck :: UnifData,UnifData -> Bool =
        Var(num),ud -> case ud of 
            Var (n) -> 
                True 
            Funs (fn,uds) ->
                ocheckList (Var(num) ,True)  

    fun ocheckList  =
        v,[]   -> True
        v,u:us -> occursCheck (v,u) && ocheckList (v,us)  





    