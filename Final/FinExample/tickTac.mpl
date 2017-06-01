data List (A) -> C =
    Nil  ::     -> C 
    Cons :: A,C -> C 

data Bool -> C =
    False :: -> C 
    True  :: -> C 

data Either (A,B) -> C =
    Left  :: A -> C 
    Right :: B -> C 

data Tuple2 (A,B) -> C = 
    Pair :: A,B -> C 

data Row -> C = 
    Triple :: String,String,String -> C 

data Board -> C =
    Piece :: [Row] -> C 

protocol ProtTerm (A) => P =
      GetTerm   :: Get (A|P) => P 
      PutTerm   :: Put (A|P) => P
      Close     :: TopBot    => P  

coprotocol CP => Console (A) =
     GetIntC   :: CP => Put (A|CP)  
     PutIntC   :: CP => Get (A|CP) 
     CloseC    :: CP => TopBot 

-- =======================================================================
-- ============GENERAL HELPER FUNCTIONS===================================

{-
This function concatenates a list of strings
-}
fun concatList :: [String] -> String =
  []   -> ""
  x:xs -> concat (x,concatList(xs))

fun append :: [A],[A] -> [A] = 
  []   , ys -> ys 
  x:xs , ys -> x:append (xs,ys) 

{-
This function checks if a given element is present in the list 
-}

fun elem :: Int,[Int] -> Bool = 
  v    ,[] ->
    False 
  v    ,x:xs ->
    case x == v of 
      True ->
        True
      False -> 
        elem (v,xs)   

{-
This element checks if all the elements of the first list 
are present in the second list
-}
fun isPresent :: [Int],[Int] -> Bool = 
  []   ,ys   -> 
    True 
  x:xs , ys -> 
    case elem (x,ys) of 
      True ->
        isPresent (xs,ys)
      False -> 
        False
 
-- =======================================================================
-- ============FUNCTIONS FOR BOARD REPRESENTATION========================= 

{-
check if a move is a vlaid and a new move
-}

fun isRightMove :: Int,[Int] -> Either (String,Bool) =
  num,list ->
    case num <= 9 of 
      True  ->
        case elem (num,list) of 
          True -> 
            Right (True)
          False ->
            Left ("Move repeated.Retry\n")  
      False ->
        Left ("Move greater than 9.Retry\n")
          
{-
List of possible solutions based on the move
-}


fun solList :: () -> [[Int]] =
  -> [
      [1,5,9],[3,5,7],[1,2,3],[4,5,6],
      [7,8,9],[1,4,7],[2,5,8],[3,6,9]
     ]

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
Blow function change the representation of a board based on the move made
-}
fun replaceRow :: Row,Int,String -> Row =
  Triple (a,b,c),colN,newP ->
    case colN == 0 of 
      True  -> Triple (newP,b,c)
      False ->
        case colN == 1 of 
          True  -> Triple (a,newP,c)
          False -> Triple (a,b,newP)     

fun newB_Help :: [Row],Int,Int,Int,String,[Row] -> [Row] =
  rList,r,c,count,newP,addR ->
    case rList of 
      []   -> []
      x:xs -> 
        case r == count of 
          True  ->
            let
              append(addR,newRow:xs)
            where
              newRow = replaceRow (x,c,newP)
          False ->
            newB_Help (xs,r,c,count+1,newP,append(addR,[x]))   



fun newBoardRep :: Board,Int,Int -> Board = 
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


-- ============================================================================
-- ============================================================================
fun hLine :: () -> String = 
    -> " -------------\n"

fun addNL :: String -> String = 
  piece  -> concat (piece,"\n")

fun addHL :: String -> String =
  piece  -> concat (hLine,piece)

fun repRow :: Row -> String =
  Triple (s1,s2,s3) -> 
    let 
      concat (s1s2,addNL (s3))
    where
      ns1   = addHL (s1)
      s1s2  = concat (ns1,s2)

fun drawBoardHelp :: [Row] ,String -> String = 
  [],list ->
    let
      concatList ([list,hLine,stars]) 
    where
      stars = "\n********************\n"
    
  (row:rest),list ->
     let 
       drawBoardHelp (rest,newList)
     where
       rowStr = repRow (row) 
       newList = concat (list,rowStr)   

fun drawBoard :: Board -> [Char] =
  Piece (rList) ->
      unstring (drawBoardHelp (rList,""))

fun drawModBoard :: Board,Int,Int -> [Char] = 
  board,move,flag -> 
    let 
      drawBoard (newBoard)
    where 
      newBoard = newBoardRep (board,move,flag)

-- ====================================================================
-- ====================================================================

proc player1 = 
  | => ch1,i1 -> do 
    hput GetTerm on i1 
    get val on i1 
    case val <= 9 of 
      True -> do 
        hput PutTerm on ch1 
        put val on ch1 
        player1 ( | => ch1,i1)
      False -> 
        player1 ( | => ch1,i1)


proc frontEnd = 
  count,board,bRep,mode | ch1,ch2 => c1 -> do  
    case mode == "receive" of 
      True -> do 
        case count % 2 == 1 of
          True -> 
            hcase ch1 of 
              GetTerm -> do 
                put 0 on ch1 
                frontEnd (count,board,bRep,mode| ch1,ch2 => c1)

              PutTerm -> do
                get move on ch 
                frontEnd (count + 1,newBoardRep (board,move,1),)


              Close   -> do 

          False -> 
            hcase ch2 of 
              GetTerm ->
              PutTerm ->
              Close   ->

      False -> 
        case bRep of 
          []  -> do 
            frontEnd (count,"receive",board,['x'] | ch1,ch2 => c1)

          x:xs -> do 
            hput PutTerm on c1
            put x on c1
            frontEnd (count,"show",board,xs| ch1,ch2  => c1) 


proc something = 
    | ch => -> do 
      split ch into ch1,ch2 
      frontEnd (1,empBoard|ch1,ch2 =>)

proc somethingElse = 
   | => ch,i1,i2 -> do 
     fork ch as 
        ch1 -> 
          player1 ( | => ch1,i1)
        ch2 ->  
          player1 ( | => ch2,i2)


