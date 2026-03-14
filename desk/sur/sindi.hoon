|%
+$  name   @t
+$  link   @t
+$  keys   @t
+$  date   @da
::  +$  item   [name link date]
+$  feeds  (list link)
::
::  actions to take
+$  take
  $%  [%add-feeds json]
      [%del-feeds json]
      [%new-keys json]
  ==
::  info to give
+$  give
  $%  [%base @t]
  ==
--