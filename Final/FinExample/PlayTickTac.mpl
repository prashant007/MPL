data List (A) -> C =
    Nil  ::     -> C 
    Cons :: A,C -> C 

data Bool -> C =
    False :: -> C 
    True  :: -> C 

data Status -> C = 
    Cont     :: -> C 
    Draw     :: -> C 
    Win      :: -> C  


data Either (A,B) -> C =
    Left  :: A -> C 
    Right :: B -> C 

data Row -> C = 
    Triple :: String,String,String -> C 

data Board -> C =
    Piece :: [Row] -> C 


protocol ProtTerm (A) => P =
    GetTerm   :: Get (A|P) => P 
    PutTerm   :: Put (A|P) => P
    Close     :: TopBot    => P  

protocol ProtMoves (A) => P =
    GetMove :: Get (A|P) => P 
    CloseM  :: TopBot    => P 

coprotocol CP => Console (A) =
    GetIntC   :: CP => Put (A|CP)  
    PutIntC   :: CP => Get (A|CP) 
    CloseC    :: CP => TopBot 

-- =======================================================================
-- ============GENERAL HELPER FUNCTIONS===================================


fun myappend :: [A],[A] -> [A] = 
  []   , ys -> ys 
  x:xs , ys -> x:myappend (xs,ys) 

{-
This function checks if a given element is present in the list 
-}

fun elem :: A,[A] -> Bool = 
  v    ,[] ->
    False 
  v    ,x:xs ->
    case x == v of 
      True ->
        True
      False -> 
        elem (v,xs)   


-- =======================================================================
-- ============FUNCTIONS FOR BOARD REPRESENTATION========================= 

{-
check if a move is a vlaid and a new move
-}

fun isRightMove :: Int,[Int] -> Either (String,Bool) =
  num,list ->
    case (num <= 9)  of 
      True  ->
        case elem (num,list) of 
          True ->
            Left ("Move repeated")  
          False ->
            Right (True)
             
      False ->
        Left ("Invalid Move.Enter a num between 1-9")

{-
checks if the first list is a part of the second list
-}
fun isPartOf :: [A],[A] -> Bool = 
  []    ,sList ->
    True
  (f:fs),sList ->
    case elem (f,sList) of 
      True  ->
        isPartOf (fs,sList)
      False -> 
        False

fun isSol :: [Int],[[Int]] -> Bool =
  moves,[]     ->
    False

  moves,(s:ss) ->
    case isPartOf (s,moves) of 
      True  -> True 
      False -> isSol (moves,ss)


fun getStatus :: [Int],Int -> Status =
  moves,count ->
    let
      case count == 9 of 
        True -> 
          case vict of 
            True  -> Win
            False -> Draw

        False ->
          case vict of 
            True  -> Win
            False -> Cont
    where
      vict    = isSol(moves,solList)
      solList = [[1,5,9],[3,5,7],[1,2,3],[4,5,6],
                 [7,8,9],[1,4,7],[2,5,8],[3,6,9]]



{-
Representation of an empty Board
-}

fun empBoard :: () -> Board  =
   -> let 
        Piece ([emptyRow,emptyRow,emptyRow]) 
      where
        emptyBox = "|   |"
        emptyRow = Triple (emptyBox,emptyBox,emptyBox)


{-
Below function change the representation of a board based on the move made
-}
fun replaceRow :: Row,Int,String -> Row =
  Triple (a,b,c),colN,newP ->
    case colN == 0 of 
      True  -> Triple (newP,b,c)
      False ->
        case colN == 1 of 
          True  -> Triple (a,newP,c)
          False -> Triple (a,b,newP)     



{-
modify the representation of board based on the input
-}
fun newBdRep :: Board,Int,Int -> Board = 
  Piece (rows),move,flag ->
    let
      case flag == 0 of 
        True ->
          Piece (newB_Help (rows,quot,rem,0,box_O,[]))
        False ->
          Piece (newB_Help (rows,quot,rem,0,box_X,[]))
    where
      box_X = "| X |"
      box_O = "| O |"
      nMove = move -1 
      quot  = quotI(nMove,3)
      rem   = nMove % 3
      
      fun newB_Help :: [Row],Int,Int,Int,String,[Row] -> [Row] =
        rList,r,c,count,newP,addR ->
          case rList of 
            []   -> []
            x:xs -> 
              case r == count of 
                True  ->
                  let
                    addR ++ (newRow:xs)
                  where
                    newRow = replaceRow (x,c,newP)
                False ->
                  newB_Help (xs,r,c,count+1,newP,addR ++ [x])  

fun finBdRep :: Board,Int,Int -> Board = 
  board,oMv,xMv -> 
    let 
      newBdRep (sBoard,xMv,1)
    where
      sBoard = newBdRep (board,oMv,0)   

-- ============================================================================
-- ============================================================================
fun hLine :: () -> String = 
    -> " -------------\n"

fun stars :: () -> String =
  -> "\n********************\n"

fun addNL :: String -> String = 
  piece  -> piece ++ "\n"

fun addHL :: String -> String =
  piece  -> hLine ++ piece

fun repRow :: Row -> String =
  Triple (s1,s2,s3) -> 
      addHL (s1) ++ s2 ++ addNL (s3)

fun drawBoardHelp :: [Row] ,String -> [Char] = 
  [],list ->
    list ++ hLine ++ stars   
  (row:rest),list ->
     let 
       drawBoardHelp (rest,newList)
     where
       rowStr = repRow (row) 
       newList = list ++ rowStr

fun drawBoard :: Board -> [Char] =
  Piece (rList) ->
      drawBoardHelp (rList," ")

{-
Modify the board based on the move 
-}
fun drawMdfdBd :: Board,Int,Int -> [Char] = 
  board,move,flag -> 
    let 
      drawBoard (newBoard)
    where 
      newBoard = newBdRep (board,move,flag)


fun drawFnBd :: Board,Int,Int -> [Char] = 
   board,mvO,mvX ->
     let 
       drawBoard (finBoard)
     where
       finBoard = finBdRep (board,mvO,mvX)
      
-- ====================================================================
-- ====================================================================

proc printString = 
  charList |  => c1 -> do  
    case charList of
      []  -> do 
        hput Close on c1
        halt c1

      x:xs -> do 
        hput PutTerm on c1
        put x on c1
        printString (xs |  => c1) 

proc playerShow = 
  mode,cList | pch => c1 -> do 
    case mode == "receive" of 
      True -> 
        hcase pch of 
          GetTerm -> do 
            put " " on pch 
            playerShow (mode,cList| pch => c1)

          PutTerm -> do
            get board on pch 
            playerShow ("show",board | pch => c1)

          Close   -> do 
            hput Close on c1 
            close c1
            halt pch 
      
      False -> 
        case cList of 
          []  -> do 
            playerShow ("receive"," " | pch => c1)

          x:xs -> do 
            hput PutTerm on c1
            put x on c1
            playerShow ("show",xs| pch  => c1) 

        
fun errorMsg :: Int,String -> [Char] =
  num,emsg -> 
    let 
      case num == 1 of
        True  ->
          xmsg
        False ->
          ymsg
    where
      xplay = "(by player X) /Try Again.\n"
      yplay = "(by player O) /Try Again.\n"
      xmsg  = emsg ++ xplay
      ymsg  = emsg ++ yplay

fun winDrawMsg :: Bool,String -> [Char] =
  win,player ->
    let 
      case win of 
        True ->
          case player == "X" of 
            True  -> helperFun ("X WINS")
            False -> helperFun ("O WINS") 
        False -> helperFun ("MATCH DRAWN")
    where
      fun helperFun :: String -> [Char] = 
        msg -> msg ++ "\n" ++ stars


fun turnMsg :: String -> [Char] = 
  player -> 
    switch
      player == "X"  = stars ++ "X's Turn" ++ stars 
      default        = stars ++ "O's Turn" ++ stars

-- ===================================================================
-- =============================PLAYER 1==============================

proc closeP1 = 
  win,player | cco => i1,pch,ch -> do 
    hput PutTerm on pch
    put winDrawMsg (win,player) on pch 
    hput CloseM on ch 
    close ch 
    hput Close on pch 
    close pch 
    hput Close on i1
    close i1 
    hput CloseC on cco 
    halt cco 


proc p1Get = 
  xs,os,bd,xRep,ct| cco => i1,pch,ch -> do 
    case xRep of 
      True  -> do 
        hput PutTerm on pch 
        put turnMsg("X") on pch 
        hput GetTerm on i1 
        get xMv on i1 

        case isRightMove (xMv,myappend(xs,os)) of 
          Left(emsg) -> do 
            hput PutTerm on pch 
            put errorMsg(1,emsg) on pch 
            p1Get (xs,os,bd,True,ct|cco=> i1,pch,ch)

          Right(bool1)  -> do 
            hput PutTerm on pch 
            put drawMdfdBd (bd,xMv,1) on pch
            case getStatus (xMv:xs,ct+1) of 
              Draw -> 
                closeP1 (False,"X"  |cco => i1,pch,ch)
              Win  ->
                closeP1 (True ,"X" |cco => i1,pch,ch)
              Cont ->
                p1Get(xMv:xs,os,newBdRep(bd,xMv,1),False,ct+1|cco=> i1,pch,ch)

      False -> do 
        hput PutTerm on pch 
        put turnMsg("O") on pch 

        hput GetMove on ch 
        get oMv on ch

        case isRightMove (oMv,myappend(xs,os)) of 
          Left(emsg) -> do 
            hput PutTerm on pch 
            put errorMsg(2,emsg) on pch 
            p1Get (xs,os,bd,xRep,ct| cco => i1,pch,ch)

          Right(bool) -> do 
            hput PutTerm on pch 
            put drawMdfdBd (bd,oMv,0) on pch

            case getStatus (oMv:os,ct+1) of 
              Draw -> do
                closeP1 (False,"O" |cco => i1,pch,ch)
              Win  -> do 
                closeP1 (True,"O"  |cco => i1,pch,ch)
              Cont -> do 
                hput PutTerm on pch 
                put turnMsg("X") on pch 
                hput GetTerm on i1 
                get xMv on i1 

                case isRightMove (xMv,myappend(xs,oMv:os)) of 
                  Left(emsg) -> do 
                    hput PutTerm on pch 
                    put errorMsg(1,emsg) on pch 
                    p1Get (xs,oMv:os,newBdRep(bd,oMv,0),True,ct|cco=> i1,pch,ch)

                  Right(bool) -> do 
                    hput PutTerm on pch 
                    put drawFnBd (bd,oMv,xMv) on pch
                    case getStatus (xMv:xs,ct+1) of 
                      Draw -> 
                        closeP1 (False,"X"  |cco => i1,pch,ch)
                      Win  ->
                        closeP1 (True ,"X" |cco => i1,pch,ch)
                      Cont ->
                        p1Get(xMv:xs,oMv:os,finBdRep(bd,oMv,xMv),xRep,ct+1|cco=> i1,pch,ch)



proc p1Init =
  | cco => i1,pch,ch -> do 
    hput GetTerm on i1 
    get xMv on i1 

    case isRightMove (xMv,[]) of 
      Left(emsg) -> do 
        hput PutTerm on pch 
        put errorMsg(1,emsg) on pch 
        p1Init (| cco=> i1,pch,ch)

      Right (bool)  -> do 
        hput PutTerm on pch 
        put drawMdfdBd (empBoard,xMv,1) on pch
        p1Get ([xMv],[],newBdRep(empBoard,xMv,1),False,2|cco=> i1,pch,ch)


proc player1  = 
  board |cco => i1,c1,ch ->  
    case board of 
      [] -> 
        plug
          p1Init  (| cco => i1,pch,ch)
          playerShow  ("receive"," " | pch => c1)
      x:xs -> do 
        hput PutTerm on c1 
        put x on c1 
        player1 (xs | cco => i1,c1,ch)



-- ===================================================================
-- =============================PLAYER 2==============================

proc player2 = 
  | ch => i2 -> do 
    hput PutTerm on i2 
    put 5 on i2 
    hcase ch of
      -- P1 is asking P2 to make a move and put it on ch  
      GetMove -> do 
        hput GetTerm on i2 
        get move on i2 
        put move on ch
        player2 (| ch => i2)         
      CloseM   -> do 
        hput Close on i2 
        close i2 
        halt ch  

-- ================================================================
-- ================================================================

run cconsole => charTerm1,intTerm1,intTerm2 -> do 
  plug 
    player1 (drawBoard(empBoard)|cconsole => intTerm1,charTerm1,ch)
    player2 (| ch => intTerm2)
