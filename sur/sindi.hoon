|%
+$  name   @t
+$  link   @t
+$  keys   @t
+$  date   @da
::  +$  item   [name link date]
+$  based  @t  ::  json'd [feeds keys]
+$  feeds  (list link)
::
::  actions to take
+$  take
  $%  [%add-feeds @t]
      [%del-feeds @t]
      [%new-keys @t]
  ==
::  info to give
+$  give
  $%  [%url based]
  ==
--