;########################################### Away Scaner ####################################################################  
;###################  NeOn mIRC Script #####################  ###################
;###################################################################################################################

alias scanaway { .dialog -m scanaway scanaway }

dialog scanaway {
  title "NeOn mIRC Away Сканер"
  size -1 -1 280 200
  combo 1, 5 5 160 100, drop, edit, size
  list 2, 5 30 162 102, size
  button "Сканировать", 3, 5 170 162 21, flat
  edit "", 5, 5 140 162 23, disabled, multi, return, autohs
  button "Закрыть", 4, 183 130 85 18, flat, ok
  box "Что делать...", 6, 175 5 100 95
  button "Предупредить", 7, 183 25 85 18, flat
  button "Кик/Бан", 8, 183 50 85 18, flat
  button "Кик", 9, 183 75 85 18, flat
  button "Настройки", 10, 183 105 85 18, flat
}
alias warns { .dialog -m warn warn }
dialog warn {
  size -1 -1 320 170
  title ".: Предупредить/Кикнуть/Забанить :."
  button "ОК", 1, 255 140 53 18, flat, ok
  radio "Предупредить", 2, 10 10 100 18
  edit "", 3, 10 30 300 18, autohs
  radio "Кикнуть", 4, 10 50 80 18
  edit "", 5, 10 70 300 18, autohs
  radio "Кик/Бан", 6, 10 90 80 18
  edit "", 7, 10 110 300 18, autohs
}
on *:dialog:scanaway:*:*: {
  if ($devent == init) { .awaychans | .did -f scanaway 3 | .did -c scanaway 1 1 | .set %scan.chan $did(1) }
  if ($devent == sclick) { 
    if ($did == 10) { .warns }
    if ($did == 1) { .set %scan.chan $did(1).text }
    if ($did == 3) { .did -r scanaway 2,5 | .enable #scanaway | .who %scan.chan * }
    if ($did == 7) { .notice $did(2).seltext %away.warn }
    if ($did == 9) { .raw kick %scan.chan $did(2).seltext %away.kick }
    if ($did == 8) { .raw mode %scan.chan +b $did(2).seltext 2 | .kick %scan.chan $did(2).seltext %away.kb }
  }
}
alias awaychans {
  var %num.chans = 1
  while (%num.chans <= $comchan($me,0)) {
    .did -a scanaway 1 $comchan($me,%num.chans)
    inc %num.chans
  }
  if ($comchan($me,0) == 0) { .did -r scanaway 1,2,5 | .did -a scanaway 5 Захожу на канал... }
}

#scanaway off
raw 352:* { 
  did -a scanaway 5 Сканирую... 
  if (G isin $7) { 
    did -a scanaway 2 $6
    inc %scan.aways 
  } 
}
raw 315:* { 
  if (%scan.aways == $null) { 
    .did -r scanaway 5 
    .did -a scanaway 5 Не найдено Away's. 
    set %awaysfound None 
  } 
  .disable #scanaway 
  unset %scan.aways 
  if (%awaysfound == None) { 
    .did -r scanaway 5 
    .did -a scanaway 5 Не найдено Away's 
  } 
  if (%awaysfound != None) { 
    .did -r scanaway 5 
    .did -a scanaway 5 Скан закончен...
  } 
  unset %awaysfound 
  halt 
}

#scanaway end

on *:dialog:warn:*:*: {
  if ($devent == init) { .did -m $dname 3,5,7 | .did -a $dname 3 %away.warn | .did -a $dname 5 %away.kick | .did -a $dname 7 %away.kb }
  if ($devent == sclick) {
    if ($did == 2) { .did -n $dname 3 | .did -m $dname 5,7 | .did -f $dname 3 }
    if ($did == 4) { .did -n $dname 5 | .did -m $dname 3,7 | .did -f $dname 5 }
    if ($did == 6) { .did -n $dname 7 | .did -m $dname 3,5 | .did -f $dname 7 }
  }
  if ($devent == edit) {
    if ($did == 3) { .set %away.warn $did(3) }
    if ($did == 5) { .set %away.kick $did(5) }
    if ($did == 7) { .set %away.kb $did(7) }
  }
}
