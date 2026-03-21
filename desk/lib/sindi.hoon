/-  sindi
|%
++  ui
  |%
  ++  link
    |%
    ++  uri
      |=  url=@t
      ^-  cord
      ?.  =("https://" (scag 8 (trip url)))
        (crip (welp "http://" (trip (hostname url))))
      (crip (welp "https://" (trip (hostname url))))
    ::
    ++  hostname
     |=  url=@t
     ^-  cord
     %-  crip
     %+  join
       '.'
     %-  flop
     %-  (list @t)
     p.r.p:(need (de-purl:html url))
    --
  ::
  ++  style
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
      font-family: 'AdobeCaslonItalic';
      src: url('/apps/sindi/fonts/acaslonpro-italic.woff') format('woff'),
           url('/apps/sindi/fonts/acaslonpro-italic.woff2') format('woff2');
      font-style: italic;
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
      --font-italic: 'AdobeCaslonItalic', serif;
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
      font-family: var(--font-italic);
    }
    #news a:visited,
    #news a:visited em {
      color: var(--color-text-visited);
    }
    '''
  ::
  ++  render-items
    |=  [=items:ui:sindi now=@da]
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
    =/  its=items:ui:sindi
      %+  sort
        items
      |=  [a=item:ui:sindi b=item:ui:sindi]
      (gth time.a time.b)
    =/  prev=(unit [? @ud @ud @ud])  ~
    |-  ^-  marl
    ?~  its  ~
    =/  it=item:ui:sindi  i.its
    =/  dt=date  (yore time.it)
    =/  this-day=[? @ud @ud @ud]  [a.dt y.dt m.dt d.t.dt]
    =/  show-date=?
      ?~  prev  %.y
      !=(u.prev this-day)
    =/  now-year=@ud  y:(yore now)
    =/  show-year=?
      ?~  prev  !=(y.dt now-year)
      !=(y.dt -.+.u.prev)
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
  --
--
