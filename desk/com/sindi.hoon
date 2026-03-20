/-  *mast, *sindi
/+  si=sindi
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
      ;meta(charset "utf-8");
      ;meta(name "viewport", content "width=device-width, initial-scale=1.0");
      ;style: {(trip style:ui:si)}
    ==
    ;body
      ;section(id "add-feed")
        ;form(event "/submit/add-feed")
          ;input(name "url", type "text", placeholder "Add URL");
          ;button(type "submit"): Add
        ==
      ==
      ;section(id "feeds-section")
        ;ul(id "feeds")
          ;*
          ^-  marl
          ?~  feeds
            ~
          %+  turn
            feeds
          |=  url=@t
          ^-  manx
          ;li
            ;form(event "/submit/del-feed")
              ;input(name "url", type "hidden", value "{(trip url)}");
              ;button(class "remove", type "submit"): x
            ==
            ;span: {(trip url)}
          ==
        ==
      ==
      ;article
        ;ul(id "news")
          ;*
          ^-  marl
          ?~  items
            :~  ;li: No items yet.
            ==
          %+  turn
            items
          |=  =item:ui
          ^-  manx
          ::  XX group by day
          ;li
            ;a(href "{(trip link.item)}", target "_blank", rel "noopener noreferrer")
              ;span: {(trip title.item)}
            ==
            ;a(href "{(trip (uri:link:ui:si src.item))}", target "_blank", rel "noopener noreferrer")
              ;em: {(trip (hostname:link:ui:si src.item))}
            ==
          ==
        ==
      ==
    ==
  ==
--
