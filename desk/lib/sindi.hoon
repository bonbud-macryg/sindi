/-  *sindi
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
--
