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
  ::  |=  a=status
  ::  encode to base64
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