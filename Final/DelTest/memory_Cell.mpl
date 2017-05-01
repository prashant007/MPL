coprotocol CP => Console (A) =
      GetIntC   :: CP => Get (Int|CP)  
      PutIntC   :: CP => Put (Int|CP) 
      CloseC    :: CP => TopBot 

protocol MEM (A) => P = 
      PUT :: Put (A|P) => P 
      GET :: Get (A|P) => P 
      CLS :: TopBot    => P
                
protocol IntTerm (A) => P =
      GetInt   :: Get (A|P) => P 
      PutInt   :: Put (A|P) => P
      Close    :: TopBot    => P  
                    
protocol Passer (A) => P = 
      Pass :: A (+) Neg (A) (*) P => P 

proc memory = 
  x | ch => -> do 
      hcase ch of
        PUT -> do 
                 get y on ch
                 memory(y|ch => )

        GET -> do 
                 put x on  ch
                 memory(x|ch => )

        CLS -> 
                 halt ch

proc p2 = 
  | p => in, mem -> do 
       hcase p of 
            Pass -> do  
                hput GET on mem
                get y on mem
                hput PutInt on in 
                put y on  in
                hput GetInt on in 
                get x on  in
                hput PUT on mem 
                put x on  mem           
                fork p as 
                   mm -> do 
                       mm |=| mem
                   nmpp -> do 
                       split nmpp into nm,pp
                       plug  
                          p2 ( | pp => in,z)
                          z |=| neg nm
                                  
          
                    
proc p1 =  
     | => p,io -> do 
        hput Pass on p 
        split p into mm,nmpp 
        hput GET on mm 
        get y on  mm
        hput PutInt on io 
        put y on io
        hput GetInt on io 
        get x on io
        hput PUT on mm 
        put x on  mm
        fork nmpp  as
            nm -> do 
              nm |=| neg mm

            pp -> 
               p1( | => pp,io) 



run  => intTerm1,intTerm2 -> do 
   plug  
       p1( | => c1,intTerm1)
       p2( | c1 => intTerm2,m)
       memory(10 |m => )