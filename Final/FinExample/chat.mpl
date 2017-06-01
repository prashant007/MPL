data List (A) -> C =
    Nil  ::     -> C 
    Cons :: A,C -> C 

data Bool -> C =
    False :: -> C 
    True  :: -> C 

data Mode -> C = 
    Snd  :: [Char] -> C 
    Rcv  ::        -> C 
    Prnt :: [Char] -> C 

data Mode2 -> C = 
    Sd :: [Char] -> C 
    Pt :: [Char] -> C 

protocol ProtTerm (A) => P =
    GetTerm   :: Get (A|P) => P 
    PutTerm   :: Put (A|P) => P
    Close     :: TopBot    => P  

protocol OnlyGet (A) => P =
    JustGet   :: Get (A|P) => P 
    CloseJG   :: TopBot    => P  

protocol JustPut (A) => P =
    OnlyPut   :: Get (A|P) => P 

coprotocol CP => Console (A) =
    GetIntC   :: CP => Put (A|CP)  
    PutIntC   :: CP => Get (A|CP) 
    CloseC    :: CP => TopBot 



fun reverse :: [A] -> [A] =
    list -> 
      let
       rev_help(list,[]) 
      where
        fun rev_help :: [A],[A] -> [A] =
            []    ,rList -> rList
            (x:xs),rList -> rev_help(xs,x:rList)

fun append :: [A],[A] -> [A] = 
  []   , ys -> ys 
  x:xs , ys -> x:append (xs,ys) 

fun printName :: [Char] -> [Char] =
   name -> let  
             append (name,mSays)
           where
             mSays = unstring (" says :")


fun empStr :: () -> [Char] =
    -> [' ']

fun formatMsg :: [Char],[Char] -> [Char] =
    msg,name ->
      let 
        append (prnName,rmsg) 
      where
        rmsg    = reverse (msg)
        prnName = printName (name)

{-
This function concatenates a list of strings
-}
fun concatList :: [String] -> String =
  []   -> ""
  x:xs -> concat (x,concatList(xs))

fun salut :: [Char] -> [Char] =
    name ->
      let
        append (inchs3,inchs2)
      where
        space  = "            "
        stars  = "*********************************************\n"
        inStr1 = concatList ([space,stars,space,space])
        inStr2 = concatList (["\n",space,stars,"\n"])
        inchs1 = unstring (inStr1)
        inchs2 = unstring (inStr2)
        inchs3 = append (inchs1,name)
     

proc chatter1  =  
    mode,name |cco => c1,ch -> do 
      case mode of 
        Snd (msg) -> do 
          hput GetTerm on c1 
          get char on c1 
          case eqC(char,'\n') of
            True  -> do 
              hput PutTerm on ch 
              put formatMsg(char:msg,name) on ch  
              chatter1 (Rcv,name|cco => c1,ch)

            False -> do 
              chatter1 (Snd(char:msg),name | cco => c1,ch)

        Rcv -> do 
          hput GetTerm on ch 
          get prnMsg on ch 
          chatter1 (Prnt(prnMsg),name | cco => c1,ch)

        Prnt (msg) -> do 
          case msg of 
            []    -> do 
              hput PutTerm on c1
              put '>' on c1
              hput PutTerm on c1
              put ' ' on c1
              chatter1 (Snd([' ']),name | cco => c1,ch)
            x:xs -> do 
              hput PutTerm on c1 
              put x on c1 
              chatter1 (Prnt(xs),name | cco => c1,ch)  


proc chatter2 = 
    mode,name,flag | ch => c2 -> do
      case mode of 
        Snd(msg) -> do 
          hput GetTerm on c2 
          get char on c2 
          case eqC(char,'\n') of
            True  -> do 
              hcase ch of
                GetTerm -> do 
                  put formatMsg(char:msg,name) on ch 
                  chatter2 (Rcv,name,flag|ch => c2)

                PutTerm -> do 
                  get pmsg on ch 
                  chatter2 (Prnt(pmsg),name,flag| ch => c2)  

                Close   -> do 
                  hput Close on c2
                  close c2 
                  halt ch  
                    
            False -> do 
              chatter2 (Snd(char:msg),name,flag | ch => c2)

        Rcv -> do
          hcase ch of 
            GetTerm -> do 
              put [' '] on ch 
              chatter2 (Snd ([' ']),name,flag| ch => c2)  
            PutTerm -> do 
              get prnMsg on ch 
              chatter2 (Prnt(prnMsg),name,flag | ch => c2)
            Close   -> do  
              hput Close on c2
              close c2 
              halt ch  

        Prnt(msg)->
          case msg of 
            []    -> do 
              hput PutTerm on c2
              put '>' on c2
              hput PutTerm on c2
              put ' ' on c2
              case flag == 0 of 
                True  ->
                  chatter2 (Rcv,name,1 | ch => c2)
                False ->
                  chatter2 (Snd([' ']),name,flag |  ch => c2)
            x:xs -> do 
              hput PutTerm on c2 
              put x on c2 
              chatter2 (Prnt(xs),name,flag|  ch => c2)  

proc startChat = 
  | cco => c1,c2,ch -> do 
      hput JustGet on ch 
      get usnm1 on ch 
      hput JustGet on ch 
      get usnm2 on ch 
      hput CloseJG on ch 
      close ch 
      plug 
        chatter1 (Prnt(salut(usnm1)),usnm1  |  cco => c1,nch)
        chatter2 (Prnt(salut(usnm2)),usnm2,0| nch => c2)


proc getUserName = 
  name | ch => c3 -> do 
    hput GetTerm on c3 
    get char on c3  
    case eqC (char,'\n') of
      True  ->
        hcase ch of
          JustGet -> do 
            put reverse(name) on ch 
            getUserName (empStr| ch => c3)
          CloseJG -> do 
            hput Close on c3
            close c3 
            halt ch 

      False ->
        getUserName (char:name | ch => c3)


run cconsole => charTerm1,charTerm2,charTerm3 -> do
   plug 
     startChat   ( | cconsole => charTerm1,charTerm2,ch)
     getUserName (empStr | ch => charTerm3)
   
