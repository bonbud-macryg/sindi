/-  *mast, *sindi, ra=rss-atom
/+  mast, rss-sub, verb, default-agent
^-  agent:gall
%+  verb  &
%-  mast
%-  agent:rss-sub
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent . %.n) bowl)
    pyk   :*  p=(scot %p our.bowl)
              q=q.byk.bowl
              r=(scot %da now.bowl)
              s=/(scot %p our.bowl)/[q.byk.bowl]/(scot %da now.bowl)
          ==
::
++  on-init
  ^-  (quip card:agent:gall _this)
  :_  this
  :~  :*  %pass   /bind
          %agent  [our.bowl q.byk.bowl]
          %poke   %mast-bind
          !>(`bind:mast`['sindi' [%sindi ~ (malt `(list (pair @tas path))`~[[%urls /rss-sub/urls] [%items /feed/items]])]])
  ==  ==
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
      =/  urls  .^((list link:ui) %gx (welp s.pyk /rss-sub/urls/noun))
      ~&  >>  urls
      %-  some
      %-  some
      :-  %sindi-items
      !>  ^-  (list item:ui)
      =/  ft=@da
        =/  d=date  (yore now.bowl)
        =/  mn=@ud  m.t.d
        %-  year
        [[a.d y.d] m.d [d.t.d h.t.d (sub mn (mod mn 15)) 0 ~[0x0]]]
      %-  skim
      :_  |=  =item:ui
          ^-  ?
          (lte time.item ft)
      ^-  (list item:ui)
      %-  zing
      %+  turn
        urls
      |=  src=link:ui
      =/  feed-item
        .^  (each (set item:rss:ra) (set entry:atom:ra))
            %gx
            (welp s.pyk /rss-sub/feed/items/(scot %t src)/noun)
        ==
      ?-  -.feed-item
          %&
        %+  turn  ~(tap in p.feed-item)
        |=  =item:rss:ra
        ^-  item:ui
        =/  elems  p.item
        =/  ttl  (murn elems |=(e=item-element:rss:ra ?.(?=([%title *] e) ~ `p.e)))
        =/  lnk  (murn elems |=(e=item-element:rss:ra ?.(?=([%link *] e) ~ `p.e)))
        =/  pub  (murn elems |=(e=item-element:rss:ra ?.(?=([%pub-date *] e) ~ `p.e)))
        :^  ?~(ttl '' i.ttl)
            src
            ?~(pub now.bowl i.pub)
        ?~(lnk '' i.lnk)
          %|
        %+  turn  ~(tap in p.feed-item)
        |=  =entry:atom:ra
        ^-  item:ui
        =/  elems  p.entry
        =/  ttl  (murn elems |=(e=entry-element:atom:ra ?.(?=([%title *] e) ~ `p.e)))
        =/  lnk  (murn elems |=(e=entry-element:atom:ra ?.(?=([%link *] e) ~ `p.e)))
        =/  pub  (murn elems |=(e=entry-element:atom:ra ?.(?=([%updated *] e) ~ `p.e)))
        :^  ?~(ttl '' i.ttl)
            src
            ?~(pub now.bowl i.pub)
        ?~(lnk '' i.lnk)
      ==
    ==
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--
