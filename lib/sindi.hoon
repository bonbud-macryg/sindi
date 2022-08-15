/-  *sindi
|%
++  alph
  !!
  ::  |=  a=(list link)
  ::  sort feeds alphabetically if specific logic needed
  ::  (you're not counting "https://", is the issue)
  ::  remove http://
  ::  remove https://
  ::  then sort gth
  ::  look at Text Processing i, ii, and iii
::
++  base
  |=  jay=@t
  ^-  @t
  =<
  =/  jay  `@u`jay
    %-  enb
  %-  oct
    jay
  |%
  ++  oct  |=(a=@u `octs`[(met 3 a) (swp 3 a)])
  ++  enb  |=(a=octs (~(en base64:mimes:html & &) a))
  --
::
::  TODO: unite these two under one arm?
++  parse-feeds
  =,  dejs:format
  |=  jay=json
  ^-  (list @t)
  %.  jay
  %-  ot
  :~  [%feeds (ar so)]
  ==
::
++  parse-keys
  =,  dejs:format
  |=  jay=json
  ^-  @t
  %.  jay
  %-  ot
  :~  [%keywords so]
  ==
::
++  sync
  !!
  ::  try to get new feeds
::
++  tick
  !!
  ::  tile function; do not trigger without also doing ++sync
::
++  wipe
::  delete items in list del from list src
  |=  [del=(list link) src=(list link)]
  ^-  (list link)
  ::  if del is null, return src
  ?~  `(list link)`del
    src
  |-
  ::  if del empty, return new src
  ?:  =(0 (lent del))
    src
  %=  $
    ::  oust first item in del
    del  (oust [0 1] del)
    ::  oust first item in del from src
    src
        %+  oust
      :_  1  u.+:(find ~[(snag 0 del)] src)
    src
  ==
--