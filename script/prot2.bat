on 1:DEOP:#:if ($opnick == $me) && ($nick != $me) { .cs op $chan $me }
on *:kick:#:{
  if ($knick == $me) && ($nick == ChanServ) {
    .splay $mircdirsounds\alarm.wav
    .msg chanserv akick # del $me
    .msg chanserv unban #
    .join # 
  }
  if ($knick == $me) {
    .splay $mircdirsounds\alarm.wav
    .msg chanserv unban #
    .msg chanserv deop # $nick
    .cs kick $chan $nick $read kick.txt
    .join #
    .mode # -o+b $$1 $address($$1,2)
  }
}
on *:input:*:if (/* !iswm $1) && (*: !iswm $1) && ( %russ == Включен ) { .set %slova off | x $1- | halt }
