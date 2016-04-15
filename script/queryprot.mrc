menu menubar {
  Протект привата
  .$iif(%privatprot == 1,Выключить): {
    %privatprot = 0
    echo Скрипт "Протект Привата" выключен
  }
  .$iif(%privatprot != 1,Включить): {
    %privatprot = 1
    echo Скрипт "Протект Привата" включен
  }
  .Сменить пароль: %privatprotpass = $$?="Введите новый пароль:"
}

menu nicklist {
  $iif($trustman == $true, Недоверять): {
    %i =  $readini(scripts\querypass.ini, trust, n)
    %n = %i
    while (%i > 0) {
      %trustman = $readini(scripts\querypass.ini, trust, n $+ %i )
      if ($1 == %trustman) {
        writeini scripts\querypass.ini trust  n $+ %i $readini(scripts\querypass.ini, trust, n $+ %n)
        break
      }
      dec %i
    }
    writeini scripts\querypass.ini trust  n $calc(%n - 1)
    remini scripts\querypass.ini trust  n $+ %n
  } 
  $iif($trustman == $false, Доверять): {
    %n =  $readini(scripts\querypass.ini, trust, n)
    writeini scripts\querypass.ini trust  n $+ $calc(%n + 1) $1
    writeini scripts\querypass.ini trust  n $calc(%n + 1) 
  }
}

on 1:CONNECT: {
  if (%privatprot == 1) {
    %n =  $readini(scripts\querypass.ini, timetrust, n)
    while (%n > 0) {
      remini scripts\querypass.ini timetrust  n $+ %n
      echo 2 2 crear
      dec %n
    }
    writeini scripts\querypass.ini timetrust  n 0
  }
}

on ^1:TEXT:*:?: {
  if (%privatprot == 1) {
    %n = 0
    if ($window($nick) == $nick) { %n = 1 }
    if ($1- == %privatprotpass) && ($trustman == $false) && ($timetrustman == $false) { 
      writeini scripts\querypass.ini timetrust  n $+ $calc($readini(scripts\querypass.ini, timetrust, n) + 1) $nick
      writeini scripts\querypass.ini timetrust  n $calc($readini(scripts\querypass.ini, timetrust, n) + 1)
      .msg $nick NetWork Script сообщает: пароль принят. Можете печатать сообщение
      if (%n == 0) { close -m $nick }
      halt
    }
    if ($trustman == $false) && ($timetrustman == $false) { 
      .msg $nick Script сообщает: чтобы написать мне, вам нужно ввести пароль
      if (%n == 0) { close -m $nick }
      halt
    } 
  }
}

on 1:INPUT:?: {
  if (%privatprot == 1) && ($trustman == $false) && ($timetrustman == $false) { 
    writeini scripts\querypass.ini timetrust  n $+ $calc($readini(scripts\querypass.ini, timetrust, n) + 1) $active
    writeini scripts\querypass.ini timetrust  n $calc($readini(scripts\querypass.ini, timetrust, n) + 1)
  }
}

alias trustman {
  %n =  $readini(scripts\querypass.ini, trust, n)
  while (%n > 0) {
    %trustman = $readini(scripts\querypass.ini, trust, n $+ %n )
    if ($nick == %trustman) || (($snick(#,1) == %trustman) && ($menu == nicklist)) {
      return $true
    }
    dec %n
  }
  return $false
}

alias timetrustman {
  %n =  $readini(scripts\querypass.ini, timetrust, n)
  while (%n > 0) {
    %trustman = $readini(scripts\querypass.ini, timetrust, n $+ %n )
    if ($nick == %trustman) {
      return $true
    }
    dec %n
  }
  return $false
}