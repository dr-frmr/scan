::  scan [uqbar-dao]
::
::  Produce signed timestamps to be used by a QR code reader and generator,
::  in order to instantly verify ship control in a physical setting.
::
/-  *scanner
/+  default-agent, dbug, verb
|%
+$  card  card:agent:gall
+$  state-0
  $:  %0
      guests=(map ship ?)
      latest=(unit [code=@ expires-at=@da])
  ==
--
::
=|  state-0
=*  state  -
::
%-  agent:dbug
%+  verb  |
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
::
++  on-init  `this(state [%0 ~ ~])
::
++  on-save  !>(state)
++  on-load
  |=  =old=vase
  ^-  (quip card _this)
  =/  old-state  !<(state-0 old-vase)
  `this(state old-state)
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>  =(src.bowl our.bowl)
  ?+    -.path  !!
      %signer-updates
    ::  provide our most recent punch card
    ?~  latest.state  `this
    ~[[%give %fact ~ %signer-update !>([%new-sig u.latest])]]^this
  ::
      %reader-updates
    ::  provide updates on signatures we verify on this path
    =-  ~[[%give %fact ~ %reader-update -]]^this
    !>([%guest-list ~(tap by guests.state)])
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ?+    mark  !!
      %action
    =^  cards  state
      (handle-poke !<(action vase))
    [cards this]
  ==
  ::
  ++  handle-poke
    |=  =action
    ^-  (quip card _state)
    ?>  =(src.bowl our.bowl)
    ?-    -.action
        %create
      ::  generate signature to be QR'd on frontend
      ::  signature is timestamped for 5 minutes in future,
      ::  which %verify uses as an expiration date.
      ::  currently always hashing same message, can customize this
      ::  in the future
      =+  exp=(add now.bowl ~m5)
      =+  new=(jam [(sign our.bowl now.bowl (sham exp)) exp])
      ::  give subscriber notice of our new punch card, to be QR'd
      :_  state(latest `[new exp])
      ~[[%give %fact ~[/signer-updates] %signer-update !>([%new-sig new exp])]]
    ::
        %verify
      ::  take in jammed signature and verify correctness,
      ::  then mark ship as 'attended' in guest list
      =/  =punch  ;;(punch (cue code.action))
      ?.  (verify our.bowl signature.punch (sham time.punch) now.bowl)
        ~&  >>>  "%scan: received an invalid signature!"
        [(reader-card !>([%bad-sig ~])) state]
      =*  who  q.signature.punch
      ?:  (gth now.bowl time.punch)
        ~&  >>>  "%scan: received an expired signature!"
        [(reader-card !>([%expired-sig who])) state]
      ?.  (~(has by guests.state) who)
        ~&  >>>  "%scan: received a non-approved signature!"
        [(reader-card !>([%not-on-list who])) state]
      ?:  (~(got by guests.state) who)
        ~&  >>>  "%scan: received same guest's signature twice!"
        [(reader-card !>([%already-in who])) state]
      ::  give subscriber notice of GOOD signature!
      ~&  >  "%scan: received signature from {<who>}"
      =+  (~(put by guests.state) who %.y)
      :_  state(guests -)
      %+  weld  (reader-card !>([%guest-sig who]))
      (reader-card !>([%guest-list ~(tap by -)]))
    ::
        %set-guests
      ::  define new guest list
      ::  TODO make more customizeable, multi-list, etc
      =+  (malt (turn guests.action |=(=ship [ship %.n])))
      :_  state(guests -)
      (reader-card !>([%guest-list ~(tap by -)]))
    ::
        %clear-guests
      ::  reset state
      `state(guests ~)
    ==
  ::
  ++  reader-card
    |=  =^vase
    ^-  (list card)
    ~[[%give %fact ~[/reader-updates] %reader-update vase]]
  ::
  ++  sign
    |=  [our=ship now=time hash=@]
    ^-  signature
    =+  (jael-scry ,=life our %life now /(scot %p our))
    =+  (jael-scry ,=ring our %vein now /(scot %ud life))
    (sign:as:(nol:nu:crub:crypto ring) hash)^our^life
  ::
  ++  verify
    |=  [our=ship =signature hash=@ now=time]
    ^-  ?
    =+  (jael-scry ,lyf=(unit @) our %lyfe now /(scot %p q.signature))
    ?~  lyf  %.n
    ?.  =(u.lyf r.signature)  %.n
    =+  %:  jael-scry
          ,deed=[a=life b=pass c=(unit @ux)]
          our  %deed  now  /(scot %p q.signature)/(scot %ud r.signature)
        ==
    ?.  =(a.deed r.signature)  %.n
    =(`hash (sure:as:(com:nu:crub:crypto b.deed) p.signature))
  ::
  ++  jael-scry
    |*  [=mold our=ship desk=term now=time =path]
    .^  mold
      %j
      (scot %p our)
      desk
      (scot %da now)
      path
    ==
  --
::
++  on-agent  on-agent:def
++  on-arvo  on-arvo:def
++  on-peek  on-peek:def
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--
