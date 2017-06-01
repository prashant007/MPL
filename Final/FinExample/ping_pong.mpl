data List (A) -> C =
    Nil  ::     -> C 
    Cons :: A,C -> C 

data Bool -> C =
    False :: -> C 
    True  :: -> C 

proc printStr = 
  list | ch => c -> do 
    case list of
      [] ->
        hcase ch of 
          GetTerm ->
          Put


proc ping =
  times | cco => c1,ch 
  case times == 0 of 
    True  -> do 
      hput Close on c1 
      close c1
      hput Close on ch 
      close ch 
      hput CloseC on cco
      halt cco 

    False -> do 
      hput PutTerm on ch 
      put pingMsg on ch    


