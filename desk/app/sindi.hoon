/-  *mast, *sindi, ra=rss-atom
/+  mast, rss-sub, verb, default-agent, *sindi
^-  agent:gall
%+  verb  &
%-  mast
%-  agent:rss-sub
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent . %.n) bowl)
::
++  on-init
  ^-  (quip card:agent:gall _this)
  :_  this
  :~  :*  %pass   /bind
          %agent  [our.bowl q.byk.bowl]
          %poke   %mast-bind
          !>(`bind:mast`['sindi' [%sindi ~ (malt `(list (pair @tas path))`~[[%urls /rss-sub/urls] [%items /feed/items]])]])
      ==
      :*  %pass  /sindi/kickoff
          %arvo  %b
          %wait  =/  d=date  (yore now.bowl)
                 =/  mn=@ud  m.t.d
                 %+  add  (mul ~m1 (sub 10 (mod mn 10)))
                 (year [[a.d y.d] m.d [d.t.d h.t.d mn 0 ~[0x0]]])
      ==
  ==
++  on-watch  |=(=path `this)
++  on-save   on-save:def
++  on-load   on-load:def
++  on-poke   on-poke:def
++  on-peek
    |=  =(pole knot)
    ^-  (unit (unit cage))
    ~&  >>  pole
    ?+  pole
      (on-peek:def pole)
    ::
    ::  all items in all feeds (filtered by time)
    ::  .^(json %gx /=sindi=/feed/items/json)
    ::  .^((list item:ui:sindi) %gx /=sindi=/feed/items/noun)
        [%x %feed %items ~]
      %-  some
      %-  some
      :-  %sindi-items
      !>  (fetch-feed-items our.bowl q.byk.bowl now.bowl)
    ==
++  on-agent  on-agent:def
++  on-arvo
  |=  [=(pole knot) =sign-arvo]
  ^-  (quip card:agent:gall _this)
  ?+  pole  (on-arvo:def pole sign-arvo)
    [%sindi %kickoff ~]
      ?>  ?=([%behn %wake *] sign-arvo)
      :_  this
      :~  :*  %pass   ~
              %agent  [our.bowl q.byk.bowl]
              %poke   %rss-sub
              !>([%set-refresh `~m10])
          ==
      ==
  ==
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--
