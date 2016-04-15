;ShowRoomName v1.0 - 2008-10-31
;http://exonyte.com/mirc/
;Draws the window name in the background of channels and queries
;/srn.options to set options, or click the added toolbar icon
;Uses Color DLL and libraries\ShowFont.dll from mircscripts.org
;Special thanks to SplitFire, jas, and foreplay for suggestions, testing
; and occasional code ideas

;Note: You can manually use /srn.drawbg @window as well

;Triggers for drawing
on me:*:JOIN:#: srn.drawbg $chan
on *:OPEN:?:*: srn.drawbg $nick
on *:OPEN:=: srn.drawbg =$nick
on *:NICK: if ($window($newnick)) { srn.drawbg $newnick }
alias query !query $1 | srn.drawbg $1

;Options command
alias srn.options {
  if ($dialog(srn.options)) {
    dialog -v srn.options
  }
  else dialog -m srn.options srn.options
}

;Settings access
alias -l srn.ini {
  if ($isid) return $readini($+(",$scriptdir,srnopts.ini"),n,$1,$$2)
  writeini $+(",$scriptdir,srnopts.ini") $1 $$2-
}

;Used to draw the color buttons in the dialog
alias -l srn.drawcolor {
  window -fhp @srn.color -1 -1 $calc(39 * $dbuw) $calc(20 * $dbuh)
  drawfill -r @srn.color $2 $2 0 0
  drawsave @srn.color $+(",$scriptdir,colorpreview.bmp")
  window -c @srn.color
  did -g srn.options $1 $+(",$scriptdir,colorpreview.bmp")
  .remove $+(",$scriptdir,colorpreview.bmp")
}

;Draw and set the actual background image
alias srn.drawbg {
  var %order, %tw, %w = 0, %th, %h = 0, %i = 0
  window -phf @srn -1 -1 1000 200

  :drawstart
  if ($srn.ini(second,enable) && (!%order)) %order = second
  elseif ($srn.ini(main,enable) && (%order != main)) %order = main
  elseif (%order) goto finish
  else {
    window -c @srn
    return
  }

  drawtext -rp @srn $srn.ini(%order,color) " $+ $srn.ini(%order,fontname) $+ " - $+ $srn.ini(%order,fontsize) $srn.ini(%order,offsetx) $srn.ini(%order,offsety) $iif($srn.ini(%order,fontbold),$chr(2)) $+ $iif($srn.ini(%order,fontunder),$chr(31)) $+ $$1
  %tw = $calc($width($1,$srn.ini(%order,fontname),- $+ $srn.ini(%order,fontsize)) + $srn.ini(%order,offsetx) + 10)
  %th = $calc($height($1,$srn.ini(%order,fontname),- $+ $srn.ini(%order,fontsize)) + $srn.ini(%order,offsety) + 5)
  if (%tw > %w) %w = %tw
  if (%th > %h) %h = %th

  goto drawstart

  :finish
  window -phf @srns -1 -1 %w %h
  drawcopy @srn 1 1 %w %h @srns 1 1
  drawsave @srns $+(",$scriptdir,$mkfn($$1),.bmp")
  background -p $$1 $+(",$scriptdir,$mkfn($$1),.bmp")
  window -c @srn
  window -c @srns
  .remove $+(",$scriptdir,$mkfn($$1),.bmp")
}

;Draw and set the dialog preview image
alias -l srn.drawprev {
  var %order, %w = 0, %h = 0, %i = 0
  var %preview = $true
  tokenize 32 #Preview 

  window -phf @srn -1 -1 1000 200
  drawfill @srn $color(background) $color(background) 0 0

  :drawstart
  if ($did(srn.options,9).state && (!%order)) %order = second
  elseif ($did(srn.options,3).state && (%order != main)) %order = main
  else goto finish

  if (%order == second) drawtext -rp @srn $did(srn.options,26) " $+ $gettok($did(srn.options,11),1,44) $+ " - $+ $gettok($remove($did(srn.options,11),$chr(32)),2,44) $did(srn.options,22) $did(srn.options,24) $iif($did(srn.options,12).state,$chr(2)) $+ $iif($did(srn.options,13).state,$chr(31)) $+ $1
  elseif (%order == main) drawtext -rp @srn $did(srn.options,25) " $+ $gettok($did(srn.options,5),1,44) $+ " - $+ $gettok($remove($did(srn.options,5),$chr(32)),2,44) $did(srn.options,18) $did(srn.options,20) $iif($did(srn.options,6).state,$chr(2)) $+ $iif($did(srn.options,7).state,$chr(31)) $+ $1

  goto drawstart

  :finish
  %w = $calc(178 * $dbuw)
  %h = $calc(51 * $dbuh)
  window -phf @srns -1 -1 %w %h
  drawcopy @srn 1 1 %w %h @srns 1 1
  drawsave @srns $+(",$scriptdir,$mkfn($1),.bmp")
  did -g srn.options 15 $+(",$scriptdir,$mkfn($1),.bmp")
  window -c @srn
  window -c @srns
  .remove $+(",$scriptdir,$mkfn($1),.bmp")
}

;Redraws or clears all currently open windows
alias -l srn.drawall {
  var %c = 1, %q = 1, %d = 1
  if ($1 == -r) {
    while (%c <= $chan(0)) {
      background -x $chan(%c)
      inc %c
    }
    while (%q <= $query(0)) {
      background -x $query(%q)
      inc %q
    }
    while (%d <= $chat(0)) {
      background -x $chat(%d)
      inc %d
    }
  }
  else {
    var %c = 1, %q = 1, %d = 1
    while (%c <= $chan(0)) {
      srn.drawbg $chan(%c)
      inc %c
    }
    while (%q <= $query(0)) {
      srn.drawbg $query(%q)
      inc %q
    }
    while (%d <= $chat(0)) {
      srn.drawbg $chat(%d)
      inc %d
    }
  }
}

menu channel,query {
  ShowRoomName Options:srn.options
}

dialog -l srn.options {
  title "ShowRoomName Options"
  size -1 -1 186 140
  option dbu

  button "OK", 1, 106 125 37 12, ok
  button "Cancel", 2, 146 125 37 12, cancel

  ;Main
  check "Enabled", 3, 8 7 50 10
  box "Main Font", 4, 3 0 89 68, disable
  button "(font)", 5, 8 19 80 12, disable
  check "Bold", 6, 8 34 40 10, disable
  check "Underline", 7, 8 43 40 10, disable
  icon 8, 49 34 39 20
  text "Offset X:", 17, 5 57 25 8, right disable
  edit "", 18, 31 55 15 10, disable
  text "Offset Y:", 19, 48 57 25 8, right disable
  edit "", 20, 74 55 15 10, disable
  ;Main Color
  edit "", 25, 1 1 0 0, hide

  ;Second
  check "Enabled", 9, 99 7 50 10
  box "Secondary Font", 10, 94 0 89 68, disable
  button "(font)", 11, 99 19 80 12, disable
  check "Bold", 12, 99 34 40 10, disable
  check "Underline", 13, 99 43 40 10, disable
  icon 14, 140 34 39 20
  text "Offset X:", 21, 96 57 25 8, right disable
  edit "", 22, 122 55 15 10, disable
  text "Offset Y:", 23, 139 57 25 8, right disable
  edit "", 24, 165 55 15 10, disable
  ;Second Color
  edit "", 26, 1 1 0 0, hide

  ;Preview Box
  icon 15, 4 71 178 51

  link "Version 1.0 - http://exonyte.com/mirc/", 16, 3 127 100 8
}


on *:DIALOG:srn.options:init:0: {
  if ($srn.ini(main,enable)) {
    did -c $dname 3
    did -e $dname 4,5,6,7,8,17,18,19,20
  }
  if ($srn.ini(second,enable)) {
    did -c $dname 9
    did -e $dname 10,11,12,13,14,21,22,23,24
  }
  if (!$srn.ini(main,enable)) did -b $dname 8
  if (!$srn.ini(second,enable)) did -b $dname 14
  did -ra $dname 5 $iif($srn.ini(main,fontname),$v1 $+ $chr(44) $srn.ini(main,fontsize),Comic Sans MS $+ $chr(44) 36)
  if ($srn.ini(main,fontbold)) did -c $dname 6
  if ($srn.ini(main,fontunder)) did -c $dname 7
  did -ra $dname 18 $srn.ini(main,offsetx)
  did -ra $dname 20 $srn.ini(main,offsety)
  did -ra $dname 25 $srn.ini(main,color)
  did -ra $dname 11 $iif($srn.ini(second,fontname),$v1 $+ $chr(44) $srn.ini(second,fontsize),Comic Sans MS $+ $chr(44) 36)
  if ($srn.ini(second,fontbold)) did -c $dname 12
  if ($srn.ini(second,fontunder)) did -c $dname 13
  did -ra $dname 22 $srn.ini(second,offsetx)
  did -ra $dname 24 $srn.ini(second,offsety)
  did -ra $dname 26 $srn.ini(second,color)

  srn.drawcolor 8 $did(25)
  srn.drawcolor 14 $did(26)
  srn.drawprev
}

on *:DIALOG:srn.options:sclick:1: {
  srn.ini main enable $did(3).state
  srn.ini main fontname $gettok($did(5),1,44)
  srn.ini main fontsize $gettok($did(5),2,44)
  srn.ini main fontbold $did(6).state
  srn.ini main fontunder $did(7).state
  srn.ini main offsetx $iif($did(18) != $null,$v1,0)
  srn.ini main offsety $iif($did(20) != $null,$v1,0)
  srn.ini main color $did(25)
  srn.ini second enable $did(9).state
  srn.ini second fontname $gettok($did(11),1,44)
  srn.ini second fontsize $gettok($did(11),2,44)
  srn.ini second fontbold $did(12).state
  srn.ini second fontunder $did(13).state
  srn.ini second offsetx $iif($did(22),$v1,3)
  srn.ini second offsety $iif($did(24),$v1,3)
  srn.ini second color $did(26)
  scid -a srn.drawall
}

;Enable main
on *:DIALOG:srn.options:sclick:3: {
  if ($did(3).state) did -e $dname 4,5,6,7,8,17,18,19,20
  else did -b $dname 4,5,6,7,8,17,18,19,20
  srn.drawprev
}

;Select main font
on *:DIALOG:srn.options:sclick:5: {
  var %x = $dll($scriptdir $+ libraries\ShowFont.dll,ShowFont,$dialog($dname).hwnd > $gettok($did(5).text,1,44) > $gettok($did(5).text,2,44) > $iif($did(6).state,b,r))
  if (%x) {
    did -ra $dname 5 $gettok(%x,1,44) $+ $chr(44) $gettok(%x,2,44)
    if (b isincs $gettok(%x,3,44)) did -c $dname 6
    else did -u $dname 6
    srn.drawprev
  }
}

;Update on main bold/underline change
on *:DIALOG:srn.options:sclick:6: srn.drawprev
on *:DIALOG:srn.options:sclick:7: srn.drawprev

;Select main color
on *:DIALOG:srn.options:sclick:8: {
  var %x = $dll($scriptdir $+ libraries\color.dll,Color,$did(25))
  if (%x !== $false) {
    did -ra $dname 25 %x
    srn.drawcolor 8 %x
    srn.drawprev
  }
}

;Enable second
on *:DIALOG:srn.options:sclick:9: {
  if ($did(9).state) did -e $dname 10,11,12,13,14,21,22,23,24
  else did -b $dname 10,11,12,13,14,21,22,23,24
  srn.drawprev
}

;Select second font
on *:DIALOG:srn.options:sclick:11: {
  var %x = $dll($scriptdir $+ libraries\ShowFont.dll,ShowFont,$dialog($dname).hwnd > $gettok($did(11).text,1,44) > $gettok($did(11).text,2,44) > $iif($did(12).state,b,r))
  if (%x) {
    did -ra $dname 11 $gettok(%x,1,44) $+ $chr(44) $gettok(%x,2,44)
    if (b isincs $gettok(%x,3,44)) did -c $dname 12
    else did -u $dname 12
    srn.drawprev
  }
}

;Update on second bold change
on *:DIALOG:srn.options:sclick:12: srn.drawprev
on *:DIALOG:srn.options:sclick:13: srn.drawprev

;Select second color
on *:DIALOG:srn.options:sclick:14: {
  var %x = $dll($scriptdir $+ libraries\color.dll,Color,$did(26))
  if (%x !== $false) {
    did -ra $dname 26 %x
    srn.drawcolor 14 %x
    srn.drawprev
  }
}

;Open website on click
on *:DIALOG:srn.options:sclick:16: run http://exonyte.com/srn/

;Update on offset changes
on *:DIALOG:srn.options:edit:*: if ($istok(18 20 22 24,$did,32)) srn.drawprev

;Startup
on *:START: {
  if ($version >= 6.2) {
    toolbar -as SRNSep
    toolbar -a SRNOptions "ShowRoomName Options" $+(",$scriptdir,srnbtn.png") /srn.options
  }
}

;Initial setup
on *:LOAD: {
  if ($version == 6.3) {
    noop $input(ShowRoomName will not work in mIRC v6.3 due to a /background bug. You must upgrade to a newer version!,ohd,ShowRoomName Error)
  }
  if (!$isfile($+(",$scriptdir,srnopts.ini"))) {
    srn.ini main enable 1
    srn.ini main fontname Comic Sans MS
    srn.ini main fontsize 36
    srn.ini main fontbold 0
    srn.ini main fontunder 0
    srn.ini main offsetx 3
    srn.ini main offsety 0
    srn.ini main color 0
    srn.ini second enable 1
    srn.ini second fontname Comic Sans MS
    srn.ini second fontsize 36
    srn.ini second fontbold 0
    srn.ini second fontunder 0
    srn.ini second offsetx 5
    srn.ini second offsety 2
    srn.ini second color 4210752
  }
  scid -a srn.drawall
  window @ShowRoomName
  echo @ShowRoomName ShowRoomName v1.0 - 2008-10-31
  echo @ShowRoomName http://exonyte.com/mirc/
  linesep @ShowRoomName
  echo @ShowRoomName Draws the window name in the background of channels and queries.
  echo @ShowRoomName Type /srn.options to set options, or click the new icon in the mIRC toolbar.
  echo @ShowRoomName Uses Color DLL and libraries\ShowFont.dll from mircscripts.org.
  linesep @ShowRoomName
  echo @ShowRoomName Special thanks to SplitFire, jas, and foreplay for suggestions, testing
  echo @ShowRoomName and occasional code ideas.
  linesep @ShowRoomName
  echo @ShowRoomName Note: You can manually use /srn.drawbg @window as well
}

;Uninstall on onload
on *:UNLOAD: {
  if ($version >= 6.2) {
    toolbar -d SRNOptions
    toolbar -d SRNSep
  }
  scid -a srn.drawall -r
  if ($input(Do you want to remove your ShowRoomName settings?,dwy,ShowRoomName)) .remove $+(",$scriptdir,srnopts.ini")
}
