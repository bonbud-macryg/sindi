/-  *sindi, ra=rss-atom
|%
++  fetch-feed-items
  |=  [our=@p =desk now=@da]
  ^-  (list item:ui)
  =/  pfx=path  /(scot %p our)/[desk]/(scot %da now)
  =/  urls  .^((list link:ui) %gx (welp pfx /rss-sub/urls/noun))
  ~&  >>  urls
  =/  ft=@da
    =/  d=date  (yore now)
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
        (welp pfx /rss-sub/feed/items/(scot %t src)/noun)
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
        ?~(pub now i.pub)
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
        ?~(pub now i.pub)
    ?~(lnk '' i.lnk)
  ==
--
