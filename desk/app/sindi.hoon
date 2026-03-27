/-  *mast, *sindi, ra=rss-atom
/+  mast, rss-sub, verb, default-agent, *sindi
::
|%
+$  versioned-state
  $%  state-0
  ==
::
+$  state-0  [%0 items=(set item:ui)]
::
+$  card  card:agent:gall
--
::
=|  state-0
=*  state  -
::
^-  agent:gall
%+  verb  &
%-  mast
%-  agent:rss-sub
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent . %.n) bowl)
::
++  on-init
  ^-  (quip card _this)
  :_  this
  :~  :*  %pass   /bind
          %agent  [our.bowl q.byk.bowl]
          %poke   %mast-bind
          !>  ^-  bind:mast
          :-  'sindi'
          :*  %sindi
              ~
              %-  malt
              ^-  (list (pair @tas path))
              :~  [%items /sindi/items]
                  [%urls /rss-sub/urls]
              ==
          ==
      ==
      :*  %pass  /sindi/kickoff
          %arvo  %b
          %wait  (add ~m10 (m10-floor now.bowl))
      ==
  ==
::
++  on-watch  |=(=path `this)
++  on-save   !>(state)
++  on-poke   on-poke:def
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  =/  saved  !<(versioned-state old)
  ?-  -.saved
    %0  [~ this(state saved)]
  ==
::
++  on-peek
    |=  =(pole knot)
    ^-  (unit (unit cage))
    ~&  >>  pole
    ?+  pole
      (on-peek:def pole)
    ::
    ::  .^(json %gx /=sindi=/sindi/items/json)
    ::  .^((list item:ui:sindi) %gx /=sindi=/sindi/items/noun)
      [%x %sindi %items ~]
    ``[%sindi-items !>((filter-items now.bowl ~(tap in items)))]
    ==
++  on-agent  on-agent:def
++  on-arvo
  |=  [=(pole knot) =sign-arvo]
  ^-  (quip card _this)
  ?+  pole
    (on-arvo:def pole sign-arvo)
  ::
      [%sindi %kickoff ~]
    ?>  ?=([%behn %wake *] sign-arvo)
    :_  this
    :~  :*  %pass   ~
            %agent  [our.bowl q.byk.bowl]
            %poke   %rss-sub
            !>([%set-refresh `~m10])
        ==
        :*  %pass  /sindi/refresh
            %arvo  %b
            %wait  (add ~m15 now.bowl)
        ==
    ==
  ::
      [%sindi %refresh ~]
    ?>  ?=([%behn %wake *] sign-arvo)
    =/  new-items  (fetch-feed-items our.bowl q.byk.bowl now.bowl)
    =/  all-items  (~(gas in items) new-items)
    :_  %=  this
          items  all-items
        ==
    :~  :*  %give  %fact  ~[/x/sindi/items]
            [%sindi-items !>((filter-items now.bowl ~(tap in all-items)))]
        ==
        :*  %pass  /sindi/refresh
            %arvo  %b
            %wait  (add ~m15 (m15-floor (add ~m1 now.bowl)))
    ==  ==
  ==
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--
