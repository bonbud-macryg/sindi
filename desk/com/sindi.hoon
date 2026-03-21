/-  *mast, *sindi
/+  si=sindi
^-  mast
=<
:-  ~[[%urls %feed-urls] [%items %sindi-items]]
^|
|_  =hull
::
::  endpoints
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
::
::  container
++  sail
  ^-  manx
  =/  =feeds:ui  !<(feeds:ui fil:(~(got by res.hull) %urls))
  =/  =items:ui  !<(items:ui fil:(~(got by res.hull) %items))
  =/  base=tape    "/sindi"
  =/  assets=tape  "/apps/sindi"
  ;html
    ;head
      ;title: Sindi
      ;meta(charset "utf-8");
      ;meta(name "viewport", content "width=device-width, initial-scale=1.0");
      ;link(rel "manifest", href "{assets}/manifest.json");
      ;meta(name "theme-color", content "#f9f5dc", media "(prefers-color-scheme: light)");
      ;meta(name "theme-color", content "#212121", media "(prefers-color-scheme: dark)");
      ;meta(name "mobile-web-app-capable", content "yes");
      ;meta(name "apple-mobile-web-app-capable", content "yes");
      ;meta(name "apple-mobile-web-app-title", content "Sindi");
      ;link(rel "apple-touch-icon", href "{assets}/images/apple-touch-icon.png");
      ;style: {(trip style:ui:si)}
      ;script: if ('serviceWorker' in navigator) navigator.serviceWorker.register('{assets}/sw.js');
    ==
    ;body
      ;section(id "nav", style "display: flex; align-items: center; gap: 1rem;")
        ;a(href "{base}", style "text-decoration: none")
          ;img(src "{assets}/images/ring22.svg", alt "Sindi", style "height: 4rem; width: 4rem; display: block;");
        ==
        ;a(href "{base}/feeds", style "text-decoration: none")
          ;button: Feeds
        ==
      ==
      ;+
      ::
      ::  router
      ?+  rut.hull
        (main-view items base)
          [%feeds ~]
        (feeds-view feeds base)
      ==
    ==
  ==
--
::
|%
::
::  list of items
++  main-view
  |=  [=items:ui base=tape]
  ^-  manx
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
::
::  add/remove feeds
++  feeds-view
  |=  [=feeds:ui base=tape]
  ^-  manx
  ;div
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
  ==
--
