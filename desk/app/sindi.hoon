/-  *mast, *sindi, ra=rss-atom
/+  mast, rss-sub, verb, default-agent, *sindi
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
              :~  [%icon /sindi/icon]
                  [%urls /sindi/urls]
                  [%items /sindi/items]
              ==
          ==
      ==
      :*  %pass   /sindi/feeds-sub
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
              (fetch-feed-items our.bowl q.byk.bowl now.bowl)
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
    (fetch-feed-items our.bowl q.byk.bowl now.bowl)
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
      [%sindi %feeds-sub ~]
    ?.  ?=(%fact -.sign)
      `this
    =/  upd  !<(rss-sub-update:rs:rss-sub q.cage.sign)
    ?-    -.upd
        %feed-added
      =/  new-feeds  (~(put by feeds) link.upd ~)
      :_  this(feeds new-feeds)
      :~  :*  %give  %fact  ~[/x/sindi/urls]
              [%feed-urls !>(~(tap in ~(key by new-feeds)))]
          ==
      ==
    ::
        %feed-deleted
      =/  new-feeds  (~(del by feeds) link.upd)
      :_  this(feeds new-feeds)
      :~  :*  %give  %fact  ~[/x/sindi/items]
              :-  %sindi-items
              !>  ^-  (list item:ui)
              %+  filter-items
                now.bowl
              (fetch-feed-items our.bowl q.byk.bowl now.bowl)
          ==
          :*  %give  %fact  ~[/x/sindi/urls]
              feed-urls+!>(~(tap in ~(key by new-feeds)))
          ==
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
      (fetch-feed-items our.bowl q.byk.bowl now.bowl)
    ::
    ::  guard against saving the same
    ::  item twice with two headlines
    =/  deduplicated-items
      %+  murn
        new-items
      |=  =item:ui
      ^-  (unit item:ui)
      ?.  %+  levy
            new-items
          |=  other=item:ui
          ?|  !=(link.other link.item)
              (gte time.other time.item)
          ==
        ~
      `item
    =/  all-items  (silt deduplicated-items)
    =/  new-feeds
      %-  ~(gas by *(map link:ui (set item:ui)))
      %+  turn
        ~(tap in ~(key by feeds))
      |=  src=link:ui
      :-  src
      %-  silt
      %+  murn
        deduplicated-items
      |=  =item:ui
      ?.(=(src.item src) ~ `item)
    =/  icon-svg=@t
      .^  @t
          %cx
          %+  welp
            /(scot %p our.bowl)/[q.byk.bowl]/(scot %da now.bowl)/web/images
          /[(icon-name now.bowl)]/svg
      ==
    :_  %=  this
          feeds  new-feeds
        ==
    :~  :*  %give  %fact  ~[/x/sindi/items]
            [%sindi-items !>((filter-items now.bowl ~(tap in all-items)))]
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
