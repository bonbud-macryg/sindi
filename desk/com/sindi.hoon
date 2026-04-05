/-  *mast, *sindi
^-  mast
=<
:-  ~[[%urls %feed-urls] [%items %sindi-items] [%icon %sindi-icon]]
^|
|_  =hull
::
::  endpoints
++  spar
  |=  cro=crow
  ^-  blow
  =/  urls=(list @t)
    (split:input (~(got by data.cro) 'urls'))
  ?+  path.cro  ~
  ::
      [%submit %add-feed ~]
    %+  turn  urls
    |=(url=@t [%rss-sub !>([%add-feed url])])
  ::
      [%submit %del-feed ~]
    %+  turn  urls
    |=(url=@t [%rss-sub !>([%del-feed url])])
  ==
::
::  container
++  sail
  ^-  manx
  =/  =feeds:ui  !<(feeds:ui fil:(~(got by res.hull) %urls))
  =/  =items:ui  !<(items:ui fil:(~(got by res.hull) %items))
  =/  icon       !<(@t fil:(~(got by res.hull) %icon))
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
      ;style: {style}
      ;script: if ('serviceWorker' in navigator) navigator.serviceWorker.register('{assets}/sw.js');
    ==
    ;body
      ;section(id "nav", style "display: flex; align-items: center; gap: 1rem;")
        ;a(href "{base}", style "text-decoration: none")
          ;+  (render-icon icon)
        ==
        ;a(href "{base}/feeds", style "text-decoration: none")
          ;button: Feeds
        ==
      ==
      ;+
      ::
      ::  router
      ?:  =(our.hull src.hull)
        ?+  rut.hull
          not-found:response:view
            ~
          (main:view items base now.hull)
            [%feeds ~]
          (feeds:view feeds base)
        ==
      unauthorized:response:view
    ==
  ==
--
::
|%
::
++  input
  |%
  ++  split
    |=  links=@t
    ^-  (list @t)
    =/  ts=tape  (trip links)
    =|  [acc=(list @t) cur=tape]
    |-  ^-  (list @t)
    ?~  ts
      ?.  =(~ cur)
        =/  tok=@t  (crip (flop cur))
        ?:  =(~ (de-purl:html tok))  (flop acc)
        (flop [tok acc])
      (flop acc)
    ?:  |(=(' ' i.ts) =(i.ts '\09') =(i.ts '\0a') =(i.ts '\0d'))
      ?.  =(~ cur)
        =/  tok=@t  (crip (flop cur))
        ?:  =(~ (de-purl:html tok))
          $(ts t.ts, cur ~)
        $(ts t.ts, acc [tok acc], cur ~)
      $(ts t.ts)
    $(ts t.ts, cur [i.ts cur])
  --
++  link
  |%
  ++  trim-protocol
    |=  url=@t
    ^-  cord
    =/  tu=tape  (trip url)
    ?:  =("http://" (scag 7 tu))
      (crip (slag 7 tu))
    ?:  =("https://" (scag 8 tu))
      (crip (slag 8 tu))
    ~|  %not-a-url
    !!
  ::
  ++  trim-www
    |=  url=@t
    ^-  cord
    =/  tu=tape  (trip url)
    ?.  =("www." (scag 4 tu))
      url
    (crip (slag 4 tu))
  ::
  ++  uri
    |=  url=@t
    ^-  cord
    =/  tu=tape  (trip url)
    =/  scheme=tape
      (scag :_(tu (sub (lent tu) (lent (trip (trim-protocol url))))))
    (crip (welp scheme (trip (hostname url))))
  ::
  ++  hostname
    |=  url=@t
    ^-  cord
    %-  trim-www
    %-  crip
    %+  join
     '.'
    %-  flop
    %-  (list @t)
    p.r.p:(need (de-purl:html url))
  --
::
++  render-icon
  |=  svg=@t
  ^-  manx
  =/  tu=tape  (trip svg)
  =/  start=(unit @ud)  (find "<svg" tu)
  ?~  start
    ;span(style "height: 3rem; width: 3rem; display: block;");
  =/  svg-tape=tape  (slag u.start tu)
  =/  parsed=(unit manx)  (de-xml:html (crip svg-tape))
  ?~  parsed
    ;span(style "height: 3rem; width: 3rem; display: block;");
  =/  =manx  u.parsed
  %_  manx
    a.g  [[%style "height: 3rem; width: 3rem; display: block;"] a.g.manx]
  ==
::
++  render-items
  |=  [=items:ui now=@da]
  ^-  marl
  ?~  items
    :~  ;li: No items yet.
    ==
  =/  months=(list tape)
    :~  ""
        "January"
        "February"
        "March"
        "April"
        "May"
        "June"
        "July"
        "August"
        "September"
        "October"
        "November"
        "December"
    ==
  =/  its=items:ui
    %+  sort
      items
    |=  [a=item:ui b=item:ui]
    (gth time.a time.b)
  =/  prev=(unit [? @ud @ud @ud])  ~
  |-  ^-  marl
  ?~  its  ~
  =/  it=item:ui  i.its
  =/  dt=date  (yore time.it)
  =/  this-day=[? @ud @ud @ud]  [a.dt y.dt m.dt d.t.dt]
  =/  show-date=?
    ?~  prev  %.y
    !=(u.prev this-day)
  =/  now-year=@ud  y:(yore now)
  =/  show-year=?
    !=(y.dt now-year)
  =/  date-str=tape
    =/  year=tape  (skim (scow %ud y.dt) |=(c=@t !=(c '.')))
    ?.  show-year
      (zing ~[(scow %ud d.t.dt) " " (snag m.dt months)])
    (zing ~[(scow %ud d.t.dt) " " (snag m.dt months) " " year])
  :_  $(its t.its, prev `this-day)
  ;li
    ;*  ?.  show-date  ~
        :~  ;h3: {date-str}
        ==
    ;a(href "{(trip link.it)}", target "_blank", rel "noopener noreferrer")
      ;span: {(trip title.it)}
    ==
    ;a(href "{(trip (uri:link src.it))}", target "_blank", rel "noopener noreferrer")
      ;em: {(trip (hostname:link src.it))}
    ==
  ==
++  view
  |%
  ::
  ::  list of items
  ++  main
    |=  [=items:ui base=tape now=@da]
    ^-  manx
    ;article
      ;ul(id "news")
        ;*  (render-items items now)
      ==
    ==
  ++  response
    |%
    ::
    ::  404 not found
    ++  not-found
      ^-  manx
      ;article
        ;section(id "not-found")
          ;h2: 404
          ;p: Not found.
        ==
      ==
    ::
    ::  401 unauthorized
    ++  unauthorized
      ^-  manx
      ;article
        ;section(id "unauthorized")
          ;h2: 401
          ;p: Unauthorized.
        ==
      ==
    --
  ::
  ::  add/remove feeds
  ++  feeds
    |=  [=feeds:ui base=tape]
    ^-  manx
    ;div
      ;section(id "add-feed")
        ;form(event "/submit/add-feed")
          ;button(type "submit", style "white-space: pre;"): {(trip 'Add ')}
          ;input(name "urls", type "text", placeholder "links");
        ==
      ==
      ;section(id "feeds-section")
        ;ul(id "feeds")
          ;*
          ^-  marl
          ?~  feeds
            ~
          %+  turn
            (sort :_(aor (turn :_(trim-www:link (turn feeds trim-protocol:link)))))
          |=  url=@t
          ^-  manx
          ;li
            ;span: {(trip url)}
            ;form(event "/submit/del-feed")
              ;input(name "urls", type "hidden", value "{(trip url)}");
              ;button(class "remove", type "submit", style "white-space: pre;"): {(trip ' remove')}
            ==
          ==
        ==
      ==
    ==
  --
::
++  style
  ^~
  %-  trip
  '''
  @font-face {
    font-family: 'AdobeCaslonRegular';
    src: url('/apps/sindi/fonts/acaslonpro-regular.woff') format('woff'),
         url('/apps/sindi/fonts/acaslonpro-regular.woff2') format('woff2');
    font-style: normal;
    font-weight: normal;
    -webkit-font-smoothing: antialiased;
  }
  @font-face {
    font-family: 'AdobeCaslonBold';
    src: url('/apps/sindi/fonts/acaslonpro-bold.woff') format('woff'),
         url('/apps/sindi/fonts/acaslonpro-bold.woff2') format('woff2');
    font-style: normal;
    font-weight: normal;
    -webkit-font-smoothing: antialiased;
  }
  :root {
    --color-text: #212121;
    --color-text-secondary: #c2c0b3;
    --color-text-visited: #757575;
    --color-background: #f9f5dc;
    --color-orange: #f09652;
    --line-height: 140%;
    --font-regular: 'AdobeCaslonRegular', serif;
    --font-bold: 'AdobeCaslonBold', serif;
  }
  @media (prefers-color-scheme: dark) {
    :root {
      --color-text: #f9f5dc;
      --color-text-secondary: #757575;
      --color-text-visited: #757575;
      --color-background: #212121;
    }
  }
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  html {
    font-family: var(--font-regular);
    font-size: 62.5%;
    background: var(--color-background);
  }
  body {
    font-family: var(--font-regular);
    font-size: 1.8em;
    background: var(--color-background);
    color: var(--color-text);
    line-height: var(--line-height);
    overflow-x: hidden;
  }
  body::-webkit-scrollbar {
    display: none;
  }
  body {
    -ms-overflow-style: none;
    scrollbar-width: none;
  }
  ul,
  li {
    list-style: none;
    padding: 0;
  }
  a {
    cursor: pointer;
    color: var(--color-text);
  }
  button,
  input {
    font-family: inherit;
    font-size: inherit;
    color: inherit;
    outline: none;
    border-radius: 3px;
    background: none;
  }
  input {
    max-width: 100%;
    border: none;
    padding: 0;
    width: 90%;
    color: var(--color-text-secondary);
  }
  button {
    color: var(--color-text);
    cursor: pointer;
    border: none;
  }
  section {
    margin: 2rem;
  }
  nav {
    display: flex;
    align-items: center;
    height: 6rem;
    padding: 0 1rem;
  }
  #feeds {
    white-space: nowrap;
  }
  #feeds li {
    display: flex;
    align-items: center;
  }
  .remove {
    color: var(--color-text-secondary);
    padding-right: 5px;
    cursor: pointer;
  }
  #news {
    padding: 0 3rem 2rem 2rem;
  }
  #news a {
    font-family: var(--font-regular);
    font-style: normal;
    text-decoration: none;
    color: var(--color-text);
  }
  #news h3 {
    margin-top: 1.5rem;
    margin-bottom: 0.5rem;
  }
  #news li {
    margin-bottom: 0.5rem;
  }
  #news em {
    padding: 0 0.5rem;
    color: var(--color-text-visited);
    font-family: var(--font-regular);
    font-style: normal;
  }
  #news a:visited,
  #news a:visited em {
    color: var(--color-text-visited);
  }
  #not-found,
  #unauthorized {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
  #not-found h2,
  #unauthorized h2 {
    font-family: var(--font-bold);
  }
  #not-found p,
  #unauthorized p {
    color: var(--color-text-secondary);
  }
  '''
--
