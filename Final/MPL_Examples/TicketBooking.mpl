
data Bool -> C =
    False :: -> C 
    True  :: -> C 


protocol IntTerm (A) => P =
      GetInt   :: Get (A|P) => P 
      PutInt   :: Put (A|P) => P
      Close    :: TopBot    => P  

coprotocol CP => Console (A) =
     GetIntC   :: CP => Put (A|CP)  
     PutIntC   :: CP => Get (A|CP) 
     CloseC    :: CP => TopBot 

proc ticketServer = 
   tot,i,tot1,tot2 | ch1,ch2 => i3 -> do 
         -- show the status of the server             
         hput PutInt on i3
         put tot on i3
         case i%2 == 1 of 
            True -> do 
               hput PutIntC on ch1
               -- pass the number of tickets to the client1
               put tot on ch1     

               hput GetIntC on ch1
               -- client1 books tickets 
               get tick1 on ch1  

               case (tot-tick1) <= 0 of
                  False -> do 
                       ticketServer (tot-tick1,i+1,tot1+tick1,tot2 | ch1,ch2 => i3)

                  True  -> do 
                    case (tot-tick1) == 0 of
                      True -> do
                        hput PutInt on i3  
                        put (tot1+tick1) on i3
                        hput PutInt on i3  
                        put tot2 on i3  
                        hput PutIntC on ch1 
                        put tot1 on ch1  
                        hput Close on i3
                        close i3 
                        hput CloseC on ch1 
                        close ch1 
                        hput CloseC on ch2 
                        halt ch2 

                      False -> 
                        ticketServer (tot ,i,tot1,tot2 | ch1,ch2 => i3)

            False -> do 
               hput PutIntC on ch2
               -- pass the number of tickets to the client2
               put tot on ch2   

               hput GetIntC on ch2
               -- client2 books tickets 
               get tick2 on ch2 
               
               case (tot-tick2) <= 0 of
                  False -> do 
                       ticketServer (tot-tick2,i+1,tot1,tot2 + tick2 | ch1,ch2 => i3)

                  True -> do 
                    case (tot-tick2) == 0 of
                      True -> do 
                        hput PutInt on i3  
                        put tot1 on i3
                        hput PutInt on i3  
                        put (tot2 + tick2) on i3                                
                        hput Close on i3
                        close i3 
                        hput CloseC on ch1 
                        close ch1 
                        hput CloseC on ch2 
                        halt ch2 

                      False -> 
                        ticketServer (tot ,i,tot1,tot2 | ch1,ch2 => i3)

proc server_Main = 
    | ch => i3 -> do 
        split ch into ch1,ch2
        hput GetInt on i3 
        get tot on i3
        ticketServer (tot,1,0,0| ch1,ch2 => i3)

proc ticketClients =
     | => i1,ch -> do 
        hcase ch of 
          GetIntC -> do
            -- get number of tickets to be booked 
            hput GetInt on i1 
            get bookTicks on i1 
            put bookTicks on ch 
            ticketClients (| => i1,ch)

          PutIntC -> do 
            -- get remaining number on tickets from the server
            get remTicks on ch  
            -- display the number of available tickets 
            hput PutInt on i1 
            put remTicks on i1                          
            ticketClients( | => i1,ch)

          CloseC  -> do 
            close ch 
            hput Close on i1
            halt i1 


proc clientFrontEnd =
    | console => i1,i2,ch -> do 
      hput CloseC on console
      close console
      fork ch as 
        ch1 -> do 
          ticketClients ( | => i1,ch1)

        ch2 -> do  
          ticketClients ( | => i2,ch2) 


run console => intTerm1,intTerm2,intTerm3 -> do 
    plug
       clientFrontEnd ( | console => intTerm1,intTerm2,ch)
       server_Main    ( | ch => intTerm3)
      
      
      
