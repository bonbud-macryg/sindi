/-  *mast, *sindi
^-  mast
:-  ~[[%urls %feed-urls] [%items %sindi-items]]
^|
|_  =hull
++  spar
  |=  cro=crow
  ^-  blow
  =/  url=@t  (~(got by data.cro) 'url')
  ?+  path.cro  ~
  ::
      [%submit %add-feed ~]
    ~[[%rss-sub !>([%add-feed url])]]
  ::
      [%submit %del-feed ~]
    ~[[%rss-sub !>([%del-feed url])]]
  ==
++  sail
  ^-  manx
  =/  =feeds:ui  !<(feeds:ui fil:(~(got by res.hull) %urls))
  =/  =items:ui  !<(items:ui fil:(~(got by res.hull) %items))
  ;html
    ;head
      ;title: Sindi
    ==
    ;body
      ;h1: Sindi - RSS Reader
      ;section(id "add-feed")
        ;h2: Add Feed
        ;form(event "/submit/add-feed")
          ;input(name "url", type "text", placeholder "example.com/rss");
          ;button(type "submit"): Add
        ==
      ==
      ;section(id "feeds")
        ;h2: Subscribed Feeds
        ;*
        ^-  marl
        ?~  feeds
          :~  ;p: No feeds subscribed yet.
          ==
        %+  turn
          feeds
        |=  url=@t
        ^-  manx
        ;div(class "feed", key "{(trip url)}")
          ;span: {(trip url)}
          ;form(event "/submit/del-feed")
            ;input(name "url", type "hidden", value "{(trip url)}");
            ;button(type "submit"): Remove
          ==
        ==
      ==
      ;section(id "items")
        ;h2: Items
        ;*
        ^-  marl
        ?~  items
          :~  ;p: No items to show.
          ==
        %+  turn
          items
        |=  =item:ui
        ^-  manx
        ::  XX group by day
        ;div(class "item", key "{(trip link.item)}")
          ;div: {(trip title.item)}
          ;div: {(trip src.item)}
        ==
      ==
    ==
  ==
--
