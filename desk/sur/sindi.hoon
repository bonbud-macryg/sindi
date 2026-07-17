|%
+$  action
  $%  [%add-feeds links=(list link:ui)]
      [%del-feed =link:ui]
      [%mark-read =link:ui]
  ==
::
++  ui
  |%
  +$  link   @t
  +$  feeds  (list link)
  +$  items  (list item)
  +$  item
    $:  title=@t
        read=?
        src=@t
        =time
        =link
    ==
  --
--
