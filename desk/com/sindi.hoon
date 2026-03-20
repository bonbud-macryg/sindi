/-  *mast, *sindi
/+  si=sindi
=>
|%
++  style
  '''
  :root {
    --color-text: #212121;
    --color-text-secondary: #c2c0b3;
    --color-text-visited: #757575;
    --color-background: #f9f5dc;
    --color-orange: #f09652;
    --line-height: 140%;
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
    font-size: 62.5%;
    background: var(--color-background);
  }
  body {
    font-family: serif;
    font-size: 1.8em;
    background: var(--color-background);
    color: var(--color-text);
    line-height: var(--line-height);
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
    font-style: normal;
    text-decoration: none;
    color: var(--color-text);
  }
  #news h3:not(:empty) {
    margin-top: 2rem;
    margin-bottom: 1rem;
  }
  #news li {
    margin-bottom: 0.5rem;
  }
  #news em {
    padding: 0 0.5rem;
    color: var(--color-text-visited);
    font-style: italic;
  }
  #news a:visited,
  #news a:visited em {
    color: var(--color-text-visited);
  }
  '''
--
::
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
      ;style: {(trip style)}
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
