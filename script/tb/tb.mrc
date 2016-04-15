;########################################################################
;########################################################################
;########################################################################

alias tb {
if $dialog(toolbar_opts) = $null { dialog -ma toolbar_opts toolbar_opts } }

dialog toolbar_opts {
  title "Настройки верхней панели"
  size -1 -1 400 422
  option pixels
  icon icons\cpanel.ico, 0
  list 1, 5 89 390 299, size
  box "Общие настройки", 2, 5 1 390 84
  check "Запускать при старте", 3, 11 19 133 20
  check "Вкл/Выкл Анимацию панели", 10, 11 37 161 20
  button "Врубить", 4, 287 13 100 20
  button "Вырубить", 5, 287 34 100 20
  list 6, 5 392 240 25, size
  list 7, 300 392 96 25, size
  box "", 8, 175 1 220 58
  button "Обновить", 9, 194 21 75 25
  text "Размер панели:", 11, 12 63 79 16
  radio "Большой", 12, 107 62 68 20, group
  radio "Маленький", 13, 177 62 79 20
  box "", 14, 5 51 257 34
}

on *:dialog:toolbar_opts:init:*:{
  dll libraries\mdx.dll MarkDialog $dname
  dll libraries\mdx.dll SetControlMDX $dname 1 listview rowselect showsel report single > libraries\views.mdx
  did -i $dname 1 1 headerdims 130 130 100
  did -i $dname 1 1 headertext Иконка $chr(9) Название $chr(9) Команда
  dll libraries\mdx.dll SetBorderStyle 6,7
  dll libraries\mdx.dll SetControlMDX $dname 6,7 toolbar flat wrap nodivider list >  libraries\bars.mdx

  did -i $dname 6 1 bmpsize 16 16

  did -i $dname 6 1 setimage +nh icon small icons\go.ico
  did -i $dname 6 1 setimage +nh icon small icons\go.ico
  did -i $dname 6 1 setimage +nh icon small icons\go.ico

  did -a $dname 6 1 Добавить $+ $chr(9) $+ Добавить
  did -a $dname 6 2 Изменить $+ $chr(9) $+ Изменить 
  did -a $dname 6 3 Удалить $+ $chr(9) $+ Удалить 

  did -i $dname 7 1 bmpsize 16 16
  did -i $dname 7 1 setimage +nh icon small icons\go.ico
  did -a $dname 7 1 Разделить $+ $chr(9) $+ Разделить

  if %toolbar = on { did -c toolbar_opts 3 }
  ;######if %skins.tb = on { did -c toolbar_opts 10 }
  if %ticons = 1 { did -c toolbar_opts 12 }
  if %ticons = 2 { did -c toolbar_opts 13 }
  tbopts.init
}

on *:dialog:toolbar_opts:sclick:3: { if ($did(toolbar_opts,3).state = 1) { set %toolbar on } | else { set %toolbar off | /toolbar -r } }
;on *:dialog:toolbar_opts:sclick:10: { if ($did(toolbar_opts,10).state = 1) { set %skins.tb on | /tbreset } | else { set %skins.tb off | /tbreset } }
on *:dialog:toolbar_opts:sclick:12: { if ($did(toolbar_opts,12).state = 1) { set %ticons 1 | /toolbar1 } }
on *:dialog:toolbar_opts:sclick:13: { if ($did(toolbar_opts,13).state = 1) { set %ticons 2 | /toolbar2 } }

on *:dialog:toolbar_opts:sclick:4: {     
  if (%ticons = 1) { /toolbar1 }
  if (%ticons = 2) { /toolbar2 } 
}
on *:dialog:toolbar_opts:sclick:5: { toolbar -r }
on *:dialog:toolbar_opts:sclick:9: { tbreset }

on *:dialog:toolbar_opts:sclick:6: {
  if ($did(6).sel == 2) { tbicon_add }
  if ($did(6).sel == 3) { tbicon_edit }
  if ($did(6).sel == 4) { tbicon_del }
}

on *:dialog:toolbar_opts:sclick:7: {
  if ($did(7).sel == 2) { .write $shortfn(script\tb\toolbar.dat) $+(-) | tbopts.init }
}

alias tbopts.init { 
  var %t = 1
  did -r toolbar_opts 1
  did -i toolbar_opts 1 1 clearicons normal
  :cikl
  if (!$read(script\tb\toolbar.dat,%t)) { halt }
  else if ($gettok($read(script\tb\toolbar.dat,%t),1,42) == $chr(45)) { 
    did -a toolbar_opts 1 $gettok($read(script\tb\toolbar.dat,%t),1,42) 
    did -i toolbar_opts 1 1 seticon normal 0 $gettok($read(script\tb\toolbar.dat,%t),1,42) 
    inc %t | goto cikl 
    } else {
    did -i toolbar_opts 1 1 seticon normal 0 $gettok($read(script\tb\toolbar.dat,%t),1,42)
    did -a toolbar_opts 1 0 + %t 0 0 $gettok($read(script\tb\toolbar.dat,%t),1,42) $chr(9) $gettok($read(script\tb\toolbar.dat,%t),2,42) $chr(9) $gettok($read(script\tb\toolbar.dat,%t),3,42)
    inc %t
    goto cikl
  }
}



alias tbicon_add {
if $dialog(tbicon_add) = $null { dialog -ma tbicon_add tbicon_add } }
dialog tbicon_add {
  title "Добавить текст"
  size -1 -1 190 106
  icon icons\toolbar.ico, 0
  box "Добавление", 1, 4 0 183 79
  text "Иконка:", 3, 9 16 67 16
  edit "icons\", 4, 79 14 102 20, autohs
  text "Название:", 5, 9 36 67 16
  edit "", 6, 79 34 102 20, autohs
  text "Команда:", 7, 9 56 67 16
  edit "/", 8, 79 54 102 20, autohs
  button "Добавить", 100, 4 83 183 20, cancel
}

on *:DIALOG:tbicon_add:sclick:100: {
  if (($did(4) != $null) && ($did(6) != $null) && ($did(8) != $null)) { 
    .write $shortfn(script\tb\toolbar.dat) $+($did(4).text,$chr(42),$did(6).text,$chr(42),$did(8).text,$chr(42),$chr(34),$did(8).text,$chr(34)) | if ($dialog(toolbar_opts)) { did -r toolbar_opts 1 | tbopts.init }
  }
  dialog -c tbicon_add
}

alias tbicon_edit {
  if ($did(toolbar_opts,1).sel) {
    var %sel = $calc($ifmatch - 1)
    if $dialog(tbicon_edit) = $null { dialog -ma tbicon_edit tbicon_edit }
    did -ra tbicon_edit 4 $gettok($read(script\tb\toolbar.dat,%sel),1,42)
    did -ra tbicon_edit 6 $gettok($read(script\tb\toolbar.dat,%sel),2,42)
    did -ra tbicon_edit 8 $gettok($read(script\tb\toolbar.dat,%sel),3,42)
    did -ra tbicon_edit 101 %sel
  }
}

dialog tbicon_edit {
  title "Изменить текст"
  size -1 -1 190 106
  icon icons\toolbar.ico, 0
  box "Добавление", 1, 4 0 183 79
  text "Иконка:", 3, 9 16 67 16
  edit "", 4, 79 14 102 20, autohs
  text "Название:", 5, 9 36 67 16
  edit "", 6, 79 34 102 20, autohs
  text "Команда:", 7, 9 56 67 16
  edit "", 8, 79 54 102 20, autohs
  button "Изменить", 100, 4 83 183 20, cancel
  text "", 101, 0 0 0 0, hide
}

on *:DIALOG:tbicon_edit:sclick:100: {
  if (($did(4) != $null) && ($did(6) != $null) && ($did(8) != $null)) { 
    .write -l $+ $did(101).text $shortfn(script\tb\toolbar.dat) $+($did(4).text,$chr(42),$did(6).text,$chr(42),$did(8).text,$chr(42),$chr(34),$did(8).text,$chr(34)) | if ($dialog(toolbar_opts)) { did -r toolbar_opts 1 | tbopts.init }
  }
  dialog -c tbicon_edit
}

alias tbicon_del {
  if ($did(toolbar_opts,1).sel) {
    var %s = $calc($did(toolbar_opts,1).sel - 1)
    write -dl $+ %s script\tb\toolbar.dat
    tbopts.init
  }
}

on *:active:*:{
  scid $activecid 
  tb.refresh
}

on *:connect:{
  scid $activecid 
  tb.refresh
}

on *:disconnect:{
  scid $activecid 
  tb.refresh
}

alias tb.connect {
  server $1 $2 $3 $4 $5
  scid $activecid
  tb.refresh
}

alias tb.disconnect {
  disconnect 
  scid $activecid
  tb.refresh
}

alias server.newconnect {
  server -m $1 $2 $3
  scid $activecid
  tb.refresh
}
