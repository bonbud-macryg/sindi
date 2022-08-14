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
++  parse-feeds
  ::  reparser
  =,  dejs:format
  |=  b=json
  ^-  (list @t)
  %.  b
  %-  ot
  :~  [%feeds (ar so)]
  ==
::
++  parse-keys
  =,  dejs:format
  |=  b=json
  ^-  @t
  %.  b
  %-  ot
  :~  [%keywords so]
  ==
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