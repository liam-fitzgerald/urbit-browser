/+  *server, default-agent, auto=language-server-complete, easy-print=language-server-easy-print
/=  index
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/browser/index
  /|  /html/
      /~  ~
  ==
/=  tile-js
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/browser/js/tile
  /|  /js/
      /~  ~
  ==
/=  script
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/browser/js/index
  /|  /js/
      /~  ~
  ==
/=  style
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/browser/css/index
  /|  /css/
      /~  ~
  ==
/=  browser-png
  /^  (map knot @)
  /:  /===/app/browser/img  /_  /png/
::
|%
+$  card  card:agent:gall
--
^-  agent:gall
=<
  |_  bol=bowl:gall
  +*  this       .
      browser-core  +>
      bc         ~(. browser-core bol)
      def        ~(. (default-agent this %|) bol)
  ::
  ++  on-init
    ^-  (quip card _this)
    =/  launcha  [%launch-action !>([%browser / '/~browser/js/tile.js'])]
    :_  this
    :~  [%pass /browser %agent [our.bol %browser] %watch /browser]
        [%pass / %arvo %e %connect [~ /'~browser'] %browser]
        [%pass /browser %agent [our.bol %launch] %poke launcha]
    ==
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  (team:title our.bol src.bol)
    ?+    mark  (on-poke:def mark vase)
        %handle-http-request
      =+  !<([eyre-id=@ta =inbound-request:eyre] vase)
      :_  this
      %+  give-simple-payload:app  eyre-id
      %+  require-authorization:app  inbound-request
      poke-handle-http-request:bc
    ::
    ==

  ++  on-watch
    |=  =path
    ^-  (quip card:agent:gall _this)
    ?:  ?=([%http-response *] path)
      `this
    ?.  =(/primary path)
      (on-watch:def path)
    [[%give %fact ~ %json !>(get-doc-json:bc)]~ this]
  ::
  ++  on-agent  on-agent:def
  ::
  ++  on-arvo   
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    ?.  ?=(%bound +<.sign-arvo)
      (on-arvo:def wire sign-arvo)
    [~ this]
  ::
  ++  on-save  on-save:def
  ++  on-load  on-load:def
  ++  on-leave  on-leave:def
  ++  on-peek   on-peek:def
  ++  on-fail   on-fail:def
  --
::
::
|_  bol=bowl:gall
::
++  get-doc-json
  ^-  json
  =/  identifiers
    (get-identifiers:auto -:!>(..add))
  =,  enjs:format
  %+  frond  'update'
  %+  frond  'inbox'
  %-  pairs
  %+  turn  identifiers
  |=  [=term =type]
  :-  term
  ^-  json
  (tape ~(ram re ~(duck easy-print type)))
::
++  poke-handle-http-request
  |=  =inbound-request:eyre
  ^-  simple-payload:http
  =+  url=(parse-request-line url.request.inbound-request)
  ?+  site.url  not-found:gen
      [%'~browser' %css %index ~]  (css-response:gen style)
      [%'~browser' %js %tile ~]    (js-response:gen tile-js)
      [%'~browser' %js %index ~]   (js-response:gen script)
  ::
      [%'~browser' %img @t *]
    =/  name=@t  i.t.t.site.url
    =/  img  (~(get by browser-png) name)
    ?~  img
      not-found:gen
    (png-response:gen (as-octs:mimes:html u.img))
  ::
      [%'~browser' *]  (html-response:gen index)
  ==
::
--
