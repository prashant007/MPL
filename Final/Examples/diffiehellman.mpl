------------------------------------------------------------------------------------------- 
-----------------------------Diffie-Hellman key exchange-----------------------------------
-------------------------------------------------------------------------------------------

process alice :: (
                   Key, Key |
                              Put(Key|Top),
                              Put(Msg|Top) => 
                              Put (
                                    Key | Get (Key| Put(Msg | Top))
                                  )
                 ) = 
              (key1,key2|secretA, messageA => cipher) ->>  
                            get skey on secretA
                            put mod(key2^skey, key1) on cipher
                            get bkey on cipher
                            get msg on messageA
                            put encode(msg,mod(key2^bkey, key1)) on cipher
                            close cipher
                            close messageA
                            end secretA

process bob:: (Key, Key|Put( Key | Get ( Key | Put (Msg|Top))) => Get(Key|Bot), Put(Msg|Top)) = 
             (key1,key2 |cipher => secretB, messageB ) ->>
                           get skey1 on secretB
                           get bkey1 on cipher 
                           put mod(bkey1^skey1,key1) on cipher
                           get enmsg on cipher
                           put decode(enmsg,mod(bkey1^skey1,key1)) on messageB
                           close secretB 
                           close cipher
                           end messageB


process alicebob:: (Key, Key| Put(Key|Top), Put(Msg|Top) => Get(Key|Bot), Put(Msg|Bot)) = 
                  (key1, key2 | secretA, messageA => secretB, messageB) ->>
                              alice(key1, key2 | secretA, messageA => cipher)
                              bob  (key1, key2 | cipher => secretB, messageB )

process sa ::  (Key | => Put (Key | Top))   = 
                ( k | => m ) ->>
                  put k on m
                  end m

process ma :: ( Msg |  => Put (Msg|Top))  = 
                ( k | => m ) ->>
                    put k on m
                    end m

process sb :: ( | Get(Key | Bot) => )  = 
              ( | m =>) ->>
                  get k on m
                  close m

process mb :: ( Msg | Put(Msg|Bot) => )  = 
            ( k | m =>) ->>
                put k on m
                end m

process done :: (Key, Msg, Msg, Key, Key |  => ) =  
        (k,m1,m2,k1,k2 | => ) ->> 
              sa( k | => n1  )
              put k on n1
              ma( m1 | => n2 )
              sb( | n3 =>  )
              mb( m2 | n4 => )
              sa(  k1 |  => n17 )
              alicebob( k1,k2 | n1,n2 => n3,n4 )

process reallydone :: ( | => )  =
         ( | => )   ->>
              done(  a,b,c,d,e |  => )

