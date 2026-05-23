/-  *sindi
=,  format
|_  =items:ui
++  grab
  |%
  ++  noun  (list item:ui)
  --
++  grow
  |%
  ++  noun  items
  ++  json
    :-  %a
    %+  turn
       items
    |=  =item:ui
    ^-  ^json
    %-  pairs:enjs
    :~  ['title' s+title.item]
        ['source' s+src.item]
        ['published' (sect:enjs time.item)]
        ['url' s+link.item]
        ['read' b+read.item]
    ==
  --
++  grad  %noun
--
