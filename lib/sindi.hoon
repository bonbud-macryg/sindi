/-  *sindi
|%
++  alph
  !!
  ::  |=  a=(list link)
  ::  sort feeds alphabetically if specific logic needed
  ::  (you're not counting "https://", is the issue)
::
++  base
  !!
  ::  |=  [=feeds =keys]
  ::  encode to base64
::
++  pars
  ::  reparser
  ::  TODO: turn output cell to list
  ::        fix that ^-
  ::        cast %feeds output to @t
  ::        take arb. feeds
  =,  dejs:format
  |=  [a=?(%feeds %keys) b=json]
  ^-  ?(^ @t)
  ?-  a
    %feeds  %.  b
            %-  ot
            :~  [%feeds (at ~[so so so so])]
            ==
    %keys   %.  b
            %-  ot
            :~  [%keywords so]
  ==        ==
::
++  wipe
  |=  [del=(list link) src=(list link)]
  ^-  (list link)
  ?~  `(list link)`del
    src
  |-
  ?:  =(0 (lent del))
    src
  %=  $
    del  (oust [0 1] del)
    src
        %+  oust
      :_  1  u.+:(find ~[(snag 0 del)] src)
    src
  ==
--