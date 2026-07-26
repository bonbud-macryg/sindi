/-  *sindi, ra=rss-atom
/+  rss-sub, verb, default-agent, *sindi
::
|%
+$  versioned-state
  $%  state-0
  ==
::
+$  state-0  [%0 feeds=(map link:ui (set item:ui))]
::
+$  card  card:agent:gall
--
::
=|  state-0
=*  state  -
::
^-  agent:gall
%+  verb  |
%-  agent:rss-sub
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent . %.n) bowl)
::
++  on-init
  ^-  (quip card _this)
  :_  this
  :~  :*  %pass   /update/feeds
          %agent  [our.bowl q.byk.bowl]
          %watch  /rss-sub/feeds
      ==
      :*  %pass  /sindi/kickoff
          %arvo  %b
          %wait  (add ~m10 (m10-floor now.bowl))
      ==
  ==
::
++  on-watch  |=(=path `this)
++  on-save   !>(state)
::
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  =/  saved  !<(versioned-state old)
  ?-  -.saved
    %0  [~ this(state saved)]
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %sindi-action
    =/  act  !<(action vase)
    ?-    -.act
        %add-feeds
      :_  this
      :~  :*  %pass  /ui/add-feeds
              %agent  [our.bowl q.byk.bowl]
              %poke   %rss-sub
              !>([%add-feeds links.act])
          ==
      ==
    ::
        %del-feed
      :_  this
      :~  :*  %pass  /ui/del-feed
              %agent  [our.bowl q.byk.bowl]
              %poke   %rss-sub
              !>([%del-feed link.act])
          ==
      ==
    ::
        %mark-read
      =/  updated-feeds=(map link:ui (set item:ui))
        %-  ~(gas by *(map link:ui (set item:ui)))
        %+  turn
          ~(tap by feeds)
        |=  [src=link:ui src-items=(set item:ui)]
        :-  src
        %-  silt
        %+  turn
          ~(tap in src-items)
        |=  =item:ui
        ?.  =(link.act link.item)
          item
        item(read .y)
      :_  %=  this
            feeds  updated-feeds
          ==
      :~  :*  %give  %fact  ~[/x/sindi/items]
              :-  %sindi-items
              !>  ^-  (list item:ui)
              %+  filter-items
                now.bowl
              (list-all-items updated-feeds)
      ==  ==
    ==
  ==
::
++  on-peek
    |=  =(pole knot)
    ^-  (unit (unit cage))
    ?+  pole
      (on-peek:def pole)
    ::
    ::  .^(json %gx /=sindi=/sindi/items/json)
    ::  .^((list item:ui:sindi) %gx /=sindi=/sindi/items/noun)
      [%x %sindi %items ~]
      %-  some
      %-  some
      :-  %sindi-items
      !>  ^-  (list item:ui)
      %+  filter-items
        now.bowl
      (list-all-items feeds)
    ::
    ::  .^(json %gx /=sindi=/sindi/urls/json)
    ::  .^((list link:ui:sindi) %gx /=sindi=/sindi/urls/noun)
      [%x %sindi %urls ~]
    ``feed-urls+!>(~(tap in ~(key by feeds)))
    ::
    ::  .^(mime %gx /=sindi=/sindi/icon/mime)
      [%x %sindi %icon ~]
    =/  svg=@t
      .^  @t
          %cx
          %+  welp
            /(scot %p our.bowl)/[q.byk.bowl]/(scot %da now.bowl)/web/images
          /[(icon-name now.bowl)]/svg
      ==
    ``[%mime !>([~['image' 'svg+xml'] [(met 3 svg) svg]])]
    ==
::
++  on-agent
  |=  [=(pole knot) =sign:agent:gall]
  ^-  (quip card _this)
  ?+    pole  (on-agent:def pole sign)
      [%update %feeds ~]
    ?+    -.sign  (on-agent:def pole sign)
        %fact
      ?+    p.cage.sign  (on-agent:def pole sign)
          %rss-sub-update
        =/  upd  !<(rss-sub-update:rs:rss-sub q.cage.sign)
        ?-    -.upd
            %feed-added
          :_  this
          :~  :*  %pass   /update/feed/(scot %t link.upd)
                  %agent  [our.bowl q.byk.bowl]
                  %watch  /rss-sub/feed/(scot %t link.upd)
          ==  ==
        ::
            %feed-deleted
          :_  this(feeds (~(del by feeds) link.upd))
          :~  :*  %give  %fact  ~[/x/sindi/urls]
                  feed-urls+!>(~(tap in ~(key by (~(del by feeds) link.upd))))
              ==
          ==
        ==
      ==
    ==
  ::
      [%update %feed link=@ta ~]
    ?+    -.sign  (on-agent:def pole sign)
        %watch-ack
      :_  %=  this
            feeds  (~(put by feeds) [(slav %t link.pole) *(set item:ui)])
          ==
      :~  :*  %give  %fact  ~[/x/sindi/urls]
              :-  %feed-urls
              !>(:-((slav %t link.pole) ~(tap in ~(key by feeds))))
      ==  ==
    ::
        %fact
      ?+    p.cage.sign  (on-agent:def pole sign)
          %rss-item
        =/  src=link:ui   (slav %t link.pole)
        =/  =item:rss:ra  !<(item:rss:ra q.cage.sign)
        =/  existing-items=(unit (set item:ui))
          (~(get by feeds) src)
        =/  incoming-items=(list item:ui)
          %:  feed-items-to-ui
              src
              now.bowl
              :-  %&
              (~(put in *(set item:rss:ra)) item)
          ==
        =/  updated-items=(set item:ui)
          %+  merge-items
            (fall existing-items *(set item:ui))
          incoming-items
        ::
        =/  updated-feeds=(map link:ui (set item:ui))
          (~(put by feeds) src updated-items)
        [~ this(feeds updated-feeds)]
      ::
          %atom-entry
        =/  src=link:ui     (slav %t link.pole)
        =/  =entry:atom:ra  !<(entry:atom:ra q.cage.sign)
        =/  existing-items=(unit (set item:ui))
          (~(get by feeds) src)
        =/  incoming-items=(list item:ui)
          %:  feed-items-to-ui
              src
              now.bowl
              :-  %|
              (~(put in *(set entry:atom:ra)) entry)
          ==
        =/  updated-items=(set item:ui)
          %+  merge-items
            (fall existing-items *(set item:ui))
          incoming-items
        ::
        =/  updated-feeds=(map link:ui (set item:ui))
          (~(put by feeds) src updated-items)
        [~ this(feeds updated-feeds)]
      ==
    ==
  ==
++  on-arvo
  |=  [=(pole knot) =sign-arvo]
  ^-  (quip card _this)
  ?+  pole
    (on-arvo:def pole sign-arvo)
  ::
      [%sindi %kickoff ~]
    ?>  ?=([%behn %wake *] sign-arvo)
    :_  this
    :~  :*  %pass  /sindi/rss-refresh
            %arvo  %b
            %wait  (next-rss-refresh now.bowl)
        ==
        :*  %pass  /sindi/ui-refresh
            %arvo  %b
            %wait  (add ~m15 now.bowl)
        ==
    ==
  ::
      [%sindi %rss-refresh ~]
    ?>  ?=([%behn %wake *] sign-arvo)
    :_  this
    :~  :*  %pass   ~
            %agent  [our.bowl q.byk.bowl]
            %poke   %rss-sub
            !>([%refresh-now ~])
        ==
        :*  %pass  /sindi/rss-refresh
            %arvo  %b
            %wait  (next-rss-refresh now.bowl)
        ==
    ==
  ::
      [%sindi %ui-refresh ~]
    ?>  ?=([%behn %wake *] sign-arvo)
    =/  new-items
      %+  filter-items
        now.bowl
      (list-all-items feeds)
    =/  icon-svg=@t
      .^  @t
          %cx
          %+  welp
            /(scot %p our.bowl)/[q.byk.bowl]/(scot %da now.bowl)/web/images
          /[(icon-name now.bowl)]/svg
      ==
    :_  this
    :~  :*  %give  %fact  ~[/x/sindi/items]
            [%sindi-items !>(new-items)]
        ==
        :*  %pass  /sindi/ui-refresh
            %arvo  %b
            %wait  (add ~m15 (m15-floor (add ~m1 now.bowl)))
        ==
        :*  %give  %fact  ~[/x/sindi/icon]
            :-  %mime
            !>  ^-  mime
            :+    ~['image' 'svg+xml']
                (met 3 icon-svg)
            icon-svg
    ==  ==
  ==
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--
