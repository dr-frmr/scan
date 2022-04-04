|%
++  expiration  ~m5
+$  signature   [p=@ux q=ship r=life]
+$  punch       [=signature =time]
::
+$  action
  $%  [%create ~]
      [%verify code=@]
      [%set-guests ships=(list ship)]
      [%clear-guests ~]
  ==
::
+$  signer-update
  $%  [%new-sig code=@ expires-at=time]
  ==
+$  reader-update
  $%  [%guest-list ships=(list ship)]
      [%bad-sig ~]
      [%expired-sig who=ship]
      [%not-on-list who=ship]
  ==
--