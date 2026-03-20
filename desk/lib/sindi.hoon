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
  --
--
