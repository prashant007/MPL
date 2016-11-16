data Lam -> C =  LVar  :: String -> C
                 LAbst :: String -> C -> C 
                 LApp  :: C -> C -> C
                 LAdd  :: C -> C -> C
                 LConst:: Int -> C

data DBL -> C = DBIndex :: Int -> C
                DBAbst  :: C -> C
                DBApp   :: C -> C -> C
                DBAdd   :: C -> C -> C
                DBConst :: Int -> C

convLamToDBL :: Lam -> DBL =
      lam -> let
               lamtoDBLHelper lam []                   
             where 
                lamtoDBLHelper =
                    l env -> 
                        case l of
                            LVar (var) ->
                                
                            LAbst(str,alam)->  
                            LApp (al1,al2) ->
                            LAdd (al1,al2) -> 
                            LConst(num) ->         
                 



















