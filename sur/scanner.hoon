|%
++  expiration  ~m5
+$  signature   [p=@ux q=ship r=life]
+$  punch       [=signature =time]
::
+$  action
  $%  [%create ~]
      [%verify code=@]
      [%set-guests guests=(list ship)]
      [%clear-guests ~]
  ==
::
+$  signer-update
  $%  [%new-sig code=@ expires-at=time]
  ==
+$  reader-update
  $%  [%guest-list guests=(list [@p ?])]
      [%bad-sig ~]
      [%already-in who=ship]
      [%expired-sig who=ship]
      [%not-on-list who=ship]
  ==
--
