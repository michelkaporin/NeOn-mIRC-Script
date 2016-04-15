;############### NeOn Spam Blocker ###################################
;################################ NeOn mIRC Script ##################
;#############################################################

alias -l _fiws {
  tokenize 32 $1- | if ($2 == $null) {
    set %_find.str $$?="String To Search?" 
    set %_find.str * $+ %_find.str $+ *
    set %_find.str $replace(%_find.str,$chr(32),*)
    :sort
    if (** isin %_find.str) { set %_find.str $replace(%_find.str,**,*) | goto sort }
  } | %i = 1
  :1 
  %tmp1 = $fline($1,%_find.str,%i)
  if (%tmp1 == $null) { 
    %tmp1 = $fline($1,%_find.str,1)
    if (%tmp1 == $null) || (%tmp1 > $sline($1,1).ln) { spam.error | did -a spam.error 1 Cannot Find the String | goto end }
    sline $1 %tmp1 | goto end
  }
  if (%tmp1 <= $sline($1,1).ln) { inc %i 1 | goto 1 }
  sline $1 %tmp1
  :end | unset %tmp* %i 
}
alias qabout { $iif(!$dialog(about),dialog -m about about) }
alias -l mdx { return script\qblock\dll\mdx.dll }
alias -l views { return script\qblock\dll\views.mdx }
alias -l bars { return script\qblock\dll\bars.mdx }
alias -l ddll { return script\qblock\dll\dialog.mdx }
alias -l spam.error { $iif(!$dialog(spam.error),dialog -m spam.error spam.error) } 
alias -l baca.file { if ($isfile($+(",$scriptdirsettings.ini,"))) return $readini $+(",$scriptdirsettings.ini,") $1 $2- }
alias -l tulis.file { writeini $+(",$scriptdirsettings.ini,") $$1- }
alias blocker { if (!$dialog(kesanspam)) dialog -m kesanspam kesanspam }

on *:unload:{ unset %spamver %qblock.date %Jumlah-Spam %qblock.date }

menu @*.Spam {
  -
  find:_fiws $active
  find next:_fiws $active %_find.str
  -
  select all:slt.all $active 1
  copy: {
    clipboard $sline($active,1) $+ $crlf | %;.i = 2
    :0 
    %;.tmp = $sline($active,%;.i)
    if (%;.tmp) { clipboard -a %;.tmp $+ $crlf | inc %;.i | goto 0 }
    unset %;.*
  }
  -
  Окно
  .clear:clear $active
  .-
  .minimize:window -n $active
  .close:window -c $active
}

dialog kesanspam {
  title "Фильтр сообщений"
  size -1 -1 185 138
  option dbu
  icon script\Qblock\icons\qblock.ico, 0
  icon 83, 100 5 57 75, " script\qblock\icons\qblock.ico ", 0
  box "Список слов", 6, 5 5 90 128
  list 1, 10 15 80 87, sort size
  edit "", 2, 10 105 80 10
  list 3, 3 117 96 20
  button "ОК", 4, 155 122 25 12, flat ok
  check "Вкл. фильтр в привате", 5, 100 25 80 10
  check "Вкл. фильтр на канале", 18, 100 35 90 10
  edit %chan_spam, 30, 100 45 80 10, autohs
  check "Показывать спам в статусе", 25, 100 55 90 10
  check "Сохранять спам в окно", 26, 100 65 90 10
  text "На канале", 20, 98 76 50 10
  check "Кик", 21, 100 85 30 10
  check "Бан", 22, 140 85 30 10
  text "В привате", 23, 98 96 50 10
  check "Игнор на", 24, 100 105 35 10
  edit " ", 31, 135 105 12 10, autohs
  text "Секунд", 32, 149 106 20 10
}

on *:dialog:kesanspam:edit:*:{
  if ($did == 31) tulis.file priv ignore $did(31)
  if ($did == 30) tulis.file chan chan_spam $did(30)
}
on *:dialog:kesanspam:init:*:{
  loadbuf 0 -o kesanspam 1 $+(",$scriptdirspamwords.txt,") 
  did -ra $dname 30 $baca.file(chan,chan_spam)
  did -ra $dname 31 $baca.file(priv,ignore)
  $iif($group(#kesanspam) == on,did -c $dname 5)
  $iif($group(#kesanspam2) == on,did -c $dname 18)
  $iif($baca.file(kick,s) == on,did -c $dname 21)
  $iif($baca.file(ban,s) == on,did -c $dname 22)
  $iif($baca.file(priv,s) == on,did -c $dname 24)
  $iif($baca.file(status,s) == on,did -c $dname 25)
  $iif($baca.file(window,s) == on,did -c $dname 26)
  if ($did(kesanspam , 24).state = 1) { did -e kesanspam 31 }
  elseif ($did(kesanspam , 24).state = 0) { did -b kesanspam 31 }
  if ($did(kesanspam , 18).state = 1) { did -e kesanspam 30 }
  elseif ($did(kesanspam , 18).state = 0) { did -b kesanspam 30 }
  dll $mdx SetMircVersion $version
  dll $mdx MarkDialog $dname
  dll $mdx SetFont $dname 3 + 13 100 Tahoma
  dll $mdx SetControlMDX $dname 3 toolbar arrows nodivider list  noresize flat > $bars
  dll $mdx SetBorderStyle 3
  did -i $dname 3 1 bmpsize 18 18
  did -i $dname 3 1 setimage +nh icon small script\Qblock\icons\ad1.ico
  did -i $dname 3 1 setimage +nh icon small script\Qblock\icons\del.ico
  did -a $dname 3 -
  did -a $dname 3 +b 1 Добавить $+ $chr(9) $+ Добавить слово в фильтр
  did -a $dname 3 -
  did -a $dname 3 +b 2 Удалить $+ $chr(9) $+ Удалить слово из фильтра
  did -a $dname 3 -
}

on *:dialog:kesanspam:sclick:33:{
  echo -a ••• Всего было найдено4 %Jumlah-Spam спама с4 %qblock.date
}

on *:dialog:kesanspam:sclick:3:{
  if ($did(3).sel == 3)  { 
    if  (!$read($+(",$scriptdirspamwords.txt,"),w,$did(2))) {
      did -r $dname 1 
      write $+(",$scriptdirspamwords.txt,") $did(2) 
      did -r $dname 2 
      loadbuf 0 -o kesanspam 1 $+(",$scriptdirspamwords.txt,") 
    }
    else { spam.error }
  }
  if ($did(3).sel == 5)  { write -ds" $+ $did(1).seltext $+ " $+(",$scriptdirspamwords.txt,") | did -r $dname 1 | loadbuf 0 -o kesanspam 1 $+(",$scriptdirspamwords.txt,") }
}

on *:dialog:kesanspam:sclick:5,10,18,21,22,24,25,26,30:{
  /set -n %chan_spam $did(30).text
  if ($did == 5) { if ($did(5).state == 0) { .disable #kesanspam } | if ($did(5).state == 1) { .enable #kesanspam } }
  if ($did == 10) { url -n http://neon-ms.info }
  if ($did == 18) { if ($did(18).state == 0) { .disable #kesanspam2 | did -b kesanspam 30 } | if ($did(18).state == 1) { .enable #kesanspam2 | did -e kesanspam 30 } }

  if ($did == 21) { $iif($baca.file(kick,s) == on,tulis.file kick s off,tulis.file kick s on) }
  if ($did == 22) { $iif($baca.file(ban,s) == on,tulis.file ban s off,tulis.file ban s on) }
  if ($did == 24) { 
    $iif($baca.file(priv,s) == on,tulis.file priv s off,tulis.file priv s on) 
    if ( $did(kesanspam , 24).state = 1 ) { did -e kesanspam 31 }
    elseif ( $did(kesanspam , 24).state = 0 ) { did -b kesanspam 31 }
  }
  if ($did == 25) { $iif($baca.file(status,s) == on,tulis.file status s off,tulis.file status s on) }
  if ($did == 26) { $iif($baca.file(window,s) == on,tulis.file window s off,tulis.file window s on) }
}

#kesanspam on
on *:TEXT:*:?:{
  var %i = 1
  while (%i <= $lines($+(",$scriptdirspamwords.txt,"))) {
    if ($read($+(",$scriptdirspamwords.txt,"),%i) isin $strip($1-)) { 
      inc %Jumlah-Spam 1
      if ($baca.file(priv,s) == on) { .ignore -pu [ $+ [ $baca.file(priv,ignore) ] ] $nick | echo -a 12[ $+ Игнор $+ ] $timestamp $+ < $+ $nick $+ > Добавлен в игнор за спам\мат }  
      if ($baca.file(status,s) == on) { echo $timestamp $+ < $+ PRIVATE $+ >< $+ $nick $+ > $1- }
      if ($baca.file(window,s) == on) {
        if ($window(@Msg.Spam) == $null) {
          window -l @Msg.Spam | .titlebar @Msg.Spam -- Правый клик для Опций
        }
        aline -c15 @Msg.Spam 1 $timestamp $+ < $+ $nick $+ > $1- 
      }
      close -m $nick
      halt 
    }
    inc %i 1
  }
}
#kesanspam end

#kesanspam2 off
on ^*:TEXT:*:%chan_spam:{
  var %i = 1
  while (%i <= $lines($+(",$scriptdirspamwords.txt,"))) {
    if ($read($+(",$scriptdirspamwords.txt,"),%i) isin $strip($1-)) { 
      inc %Jumlah-Spam 1
      if (($nick !isop #) && ($nick !isvoice #)) { echo 4[ $+ $chan $+ ] $+ $timestamp $+ < $+ $nick $+ > $1- }
      if (($nick !isop #) && ($nick !isvoice #)) { .notice $nick Смотри что ты пишешь на канале, дурень: 15 $+ $read(script\Qblock\spamwords.txt,%i) 14 $+ is 4BLOCKED! 1(Spam Blocker %spamver at www.hirc.org) }
      if (($baca.file(ban,s) == on) && ($me isop $chan) &&  ($nick !isop #) && ($nick !isvoice #))  { .ban $chan $nick }
      if (($baca.file(kick,s) == on) && ($me isop $chan) &&  ($nick !isop #) && ($nick !isvoice #))  { .kick # $nick Не говори 1 $+ $read(script\Qblock\spamwords.txt,%i) на $chan }
      if ($baca.file(status,s) == on) { echo $timestamp $+ < $+ $chan $+ >< $+ $nick $+ > $1- }
      if ($baca.file(window,s) == on) {
        if ($window(@Chan.Spam) == $null) {
          window -l @Chan.Spam | .titlebar @Chan.Spam -- Правый клик для опций
          ;200 200 630 200 Arial 12
        }
        aline -c15 @Chan.Spam 1 $timestamp $+ < $+ $chan $+ >< $+ $nick $+ > $1- 
      }
      haltdef  
      halt 
    }
    inc %i 1
  }
}
#kesanspam2 end

dialog spam.error {
  title "Ошибка"
  size -1 -1 187 75
  icon script\Qblock\icons\qblock.ico 
  icon 4, 8 8 57 75, " script\qblock\icons\error.ico "
  text "Слово уже существует", 1, 39 15 141 25, center
  box "", 2, 10 80 170 8
  button "ОК", 3, 63 47 65 20, ok
}
