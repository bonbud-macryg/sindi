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
  ::  TODO: turn output cell to list
  ::        fix that ^-
  ::        cast %feeds output to @t
  ::        take arb. feeds
  =,  dejs:format
  |=  [a=%feeds b=json]
  ::  must spit out list
  ::  look into ar:so
  ^-  [@t @t @t @t]
  %.  b
  %-  ot
  :~  [%feeds (at ~[so so so so])]
  ==
::
++  parse-keys
  =,  dejs:format
  |=  [a=%keys b=json]
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