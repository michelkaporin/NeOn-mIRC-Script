;###################################################################################################################
;###############################################CSTATS##############################################################
;###################################################################################################################


alias cstats {
  if ($left($active,1) != $chr(35)) { echo -a Эту функцию можно использовать только на канале | /halt } | else var %c.chan $active
  var %c.i 1 
  var %c.all $nick($1,0)
  var %c.normal 0 
  var %c.voice 0 
  var %c.op 0 
  var %c.halfop 0 
  var %c.admin 0 
  var %c.founder 0
  while (%c.i <= $nick(%c.chan,0)) {
    if (~ isin $nick(%c.chan,%c.i).pnick) { inc %c.founder | goto next }
    if (& isin $nick(%c.chan,%c.i).pnick) { inc %c.admin | goto next }
    if (@ isin $nick(%c.chan,%c.i).pnick) { inc %c.op | goto next }
    if (% isin $nick(%c.chan,%c.i).pnick) { inc %c.halfop | goto next }
    if (+ isin $nick(%c.chan,%c.i).pnick) { inc %c.voice | goto next }
    if ($nick(%c.chan,%c.i) isreg $1) { inc %c.normal | goto next }
    :next
    inc %c.i
  }
  echo -a 4•••••••••••••••••••••••••••
  echo -a 4• 12Статистика Канала10 %c.chan $+ : %c.all
  echo -a 4•                             
  echo -a 4• 7Всего людей:10 $nick(#,0)
  echo -a 4• 7Фаундеров 13[+q/~]:10 %c.founder 
  echo -a 4• 7Админов 13[+a/&]:10 %c.admin 
  echo -a 4• 7Опов 13[+o/@]:10 %c.op 
  echo -a 4• 7ПолуОпов 13[+h/%]:10 %c.halfop 
  echo -a 4• 7Войсов 13[+v/+]:10 %c.voice 
  echo -a 4• 7Нормальных:10 $nick(#,0,r)                   
  echo -a 4•••••••••••••••••••••••••••

}
