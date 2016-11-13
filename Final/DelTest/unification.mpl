data UnifData -> C =  Funs :: Int,[C] -> C 
                      Var  :: Int -> C    

data UnifEqn -> C = Eqn :: UnifData,UnifData -> C 

data SF (A) -> C = SS :: A -> C  
                   FF ::   -> C

data Bool -> C = True  :: -> C
                 False :: -> C   


data List(A) -> C = Nil  ::   -> C
                    Cons :: A,C -> C 

fun append = 
     []   , ys     -> ys 
     (x:xs), ys    -> x:append (xs,ys) 

fun length =
    []     -> 0
    (x:xs) -> 1 + length (xs) 


defn of
    fun occursCheck =
        Var(num),ud -> case ud of 
            Var (n)      -> True
            Funs (fn,uds) -> ocheckList (Var(num) ,uds)

    fun ocheckList =
        v,[]   -> True
        v,u:us -> occursCheck (v,u) && ocheckList (v,us)          
    
    fun match_Help  = 
           Funs(fname1,fuds1),Funs (fname2,fuds2) ->
               switch
                  fname1 == fname2 && length (fuds1) == length (fuds2) = 
                       help_Funs (fuds1,fuds2)             
                  default =
                       FF  

           Funs(fname,fuds),Var(n)  ->
               case ocheckList (Var (n),fuds)  of
                   True  -> SS ([Eqn (Var(n),Funs(fname,fuds))])
                   False -> FF

           Var(n),Funs (fname,fuds) ->
               case ocheckList (Var(n),fuds) of
                   True  -> SS ([Eqn (Var(n),Funs(fname,fuds))])
                   False -> FF

           Var(num1),Var(num2) -> 
               switch
                   num1 == num2 = SS ([])
                   default      = SS ([Eqn (Var(num1),Var (num2))])

    fun help_Funs = 
            [],[] ->
                SS ([])
            (u1:ud1),(u2:ud2) ->
                case match_Help (u1,u2) of 
                    FF        -> FF 
                    SS (fEqns) -> 
                      case help_Funs (ud1,ud2) of
                          FF           -> FF
                          SS (remEqns) -> SS (append (fEqns,remEqns))



fun unify :: UnifEqn -> SF ([UnifEqn]) = 
    Eqn (ud1,ud2) -> 
            match_Help (ud1,ud2)





    