
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
   tot | ch => i3 -> do 
       hcase ch of 
         -- client is trying to find out the number of tickets left 
         GetInt -> do 
           -- show the status of the server             
           hput PutInt on i3
           put tot on i3
           put tot on ch  
           ticketServer (tot | ch => i3)
         
         -- client is booking a ticket
         PutInt -> do 
           get bookTicks on ch 
           ticketServer (tot-bookTicks | ch => i3)

         Close -> do
           hput Close on i3 
           close i3 
           halt ch  


proc ticketClients =
    totBooked | console => i1,ch -> do 
        -- get remaining number on tickets from the server
        hput GetInt on ch 
        get remTicks on ch 
        
        -- display the number of available tickets 
        hput PutInt on i1 
        put remTicks on i1 

        -- get number of tickets to be booked 
        hput GetInt on i1 
        get bookTicks on i1 
        
        -- check if there are enough tickets for booking
        case remTicks - bookTicks <= 0 of 
          -- tickets can be booked 
          False -> do
            -- book the tickets by sending a message to the server 
            hput PutInt on ch 
            put bookTicks on ch 
            ticketClients (totBooked + bookTicks | console => i1,ch)

          -- tickets can't be booked (ticket exhausted/booking more than available)
          True -> do 
            -- if tickets have been all exhausted 
            case remTicks - bookTicks == 0 of 
              -- end the booking program   
              True  -> do 
                hput PutInt on i1 
                put totBooked + bookTicks on i1 
                hput Close on i1 
                close i1 
                hput Close on ch 
                close ch 
                hput CloseC on console
                halt console

              -- decrease the value of number of tickets   
              False ->
                ticketClients (totBooked |console => i1,ch)


run console => intTerm1,intTerm3 -> do 
    plug
       ticketClients  ( 0| console => intTerm1,ch)
       ticketServer   (10| ch => intTerm3)
      
      
      
