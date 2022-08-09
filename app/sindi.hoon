/-  *sindi
/+  *sindi, default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  card     card:agent:gall
+$  state-0  [%0 =feeds =keys]
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
++  on-init
    ^-  (quip card _this)
    `this(feeds ~, keys '')
++  on-save  !>(state)
++  on-load  on-load:def
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+  mark  (on-poke:def mark vase)
    %take
    =/  action  !<(take vase)
    ::  TODO: confirm state of `+.action` is $json
    ~!  +.action
    ?-  -.action
      %new-keys   `this(keys (parse-keys [%keys +.action]))
                  ::  needs to spit out list
      %add-feeds  `this(feeds (welp feeds (parse-feeds [%feeds +.action])))
      %del-feeds  `this(feeds (wipe (parse-feeds [%feeds +.action]) feeds))
    ==
    ::
    %give
    =/  update  !<(give vase)
    ?-  -.update
      %url  !!  ::  json:based
    ==
  ==
::
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--