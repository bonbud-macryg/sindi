|%
+$  name   @t
+$  link   @t
+$  term   @t
+$  date   @da
::  +$  item   [name link date]
+$  based  @t  ::  json'd [feeds terms]
+$  feeds  (list link)
+$  terms  (list term)
::
::  actions to take
+$  take
  $%  [%add-feeds (list link)]
      [%del-feeds (list link)]
      [%new-terms (list term)]
  ==
::  info to give
+$  give
  $%  [%url based]
  ==
--