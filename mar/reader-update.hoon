/-  *scanner
=,  enjs:format
|_  upd=reader-update
++  grab
  |%
  ++  noun  reader-update
  --
++  grow
  |%
  ++  noun  upd
  ++  json
    ?-    -.upd
        %guest-list
      %-  pairs
      %+  turn  `(list [@p ?])`guests.upd
      |=  [s=@p here=?]
      [(crip (scow %p s)) [%b here]]
    ::
      %bad-sig      ~
      %already-in   (who who.upd)
      %expired-sig  (who who.upd)
      %not-on-list  (who who.upd)
    ==
  ++  who
    |=  s=@p
    (frond ['who' [%s (scot %p s)]])
  --
++  grad  %noun
--
