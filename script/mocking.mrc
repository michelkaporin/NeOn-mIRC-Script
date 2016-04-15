on 1:text:*:*: {
  if ($nick == %mocking.user) { notice $nick $1- }
}
on 1:action:*:*: { 
  if ($nick == %mocking.user) { notice $nick $1- }
}
on 1:notice:*:*: { 
  if ($nick == %mocking.user) { notice $nick $1- }
}

alias mocking.user {
  if (%mocking.user != $null) { mocking.error Невозможно повторять $1- за %mocking.user , т.к. он уже повторяются. }
  else {
    set %mocking.user $1-
    echo %skins.prefix 10Повторяю все слова за 4 $1-
  }
}

alias mocking.error { if ($left($active,1) == @) { echo -s $chr(35) --ERROR-- $1- } | else { echo -a $chr(35) --ERROR-- $1- } }
