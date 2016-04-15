/r1 {
  set %rainbow $1-
  %rainbow = $replace(%rainbow,a,1a)
  %rainbow = $replace(%rainbow,b,3b)
  %rainbow = $replace(%rainbow,c,4c)
  %rainbow = $replace(%rainbow,d,6d)
  %rainbow = $replace(%rainbow,e,12e)
  %rainbow = $replace(%rainbow,f,13f)
  %rainbow = $replace(%rainbow,g,14g)
  %rainbow = $replace(%rainbow,h,15h)
  %rainbow = $replace(%rainbow,i,1i)
  %rainbow = $replace(%rainbow,j,3j)
  %rainbow = $replace(%rainbow,k,4k)
  %rainbow = $replace(%rainbow,l,6l)
  %rainbow = $replace(%rainbow,m,12m)
  %rainbow = $replace(%rainbow,n,13n)
  %rainbow = $replace(%rainbow,o,14o)
  %rainbow = $replace(%rainbow,p,1p)
  %rainbow = $replace(%rainbow,q,3q)
  %rainbow = $replace(%rainbow,r,4r)
  %rainbow = $replace(%rainbow,s,6s)
  %rainbow = $replace(%rainbow,t,12t)
  %rainbow = $replace(%rainbow,u,13u)
  %rainbow = $replace(%rainbow,v,14v)
  %rainbow = $replace(%rainbow,w,15w)
  %rainbow = $replace(%rainbow,x,1x)
  %rainbow = $replace(%rainbow,y,3y)
  %rainbow = $replace(%rainbow,z,4z)
  say %rainbow
  unset %rainbow
}
/r2 {
  %rainbow = $1-
  set %rainbow $replace(%rainbow,a,4a)
  set %rainbow $replace(%rainbow,b,3B)
  set %rainbow $replace(%rainbow,c,6C) 
  set %rainbow $replace(%rainbow,d,7D) 
  set %rainbow $replace(%rainbow,e,4e) 
  set %rainbow $replace(%rainbow,f,12F) 
  set %rainbow $replace(%rainbow,g,13G) 
  set %rainbow $replace(%rainbow,h,6H) 
  set %rainbow $replace(%rainbow,i,4i) 
  set %rainbow $replace(%rainbow,j,J) 
  set %rainbow $replace(%rainbow,k,3K) 
  set %rainbow $replace(%rainbow,l,L) 
  set %rainbow $replace(%rainbow,m,4M) 
  set %rainbow $replace(%rainbow,n,6N)
  set %rainbow $replace(%rainbow,o,4o) 
  set %rainbow $replace(%rainbow,p,12P) 
  set %rainbow $replace(%rainbow,q,Q) 
  set %rainbow $replace(%rainbow,r,13R) 
  set %rainbow $replace(%rainbow,s,7S) 
  set %rainbow $replace(%rainbow,t,T) 
  set %rainbow $replace(%rainbow,u,4u) 
  set %rainbow $replace(%rainbow,v,V) 
  set %rainbow $replace(%rainbow,w,12W) 
  set %rainbow $replace(%rainbow,x,7X) 
  set %rainbow $replace(%rainbow,y,Y) 
  set %rainbow $replace(%rainbow,z,6z) 
  set %rainbow $replace(%rainbow,?,12¿15?) 
  say %rainbow
  unset %rainbow
}
/rb {
  set %rainbow1 $replace($1-,$chr(32), ) | set %rainbow1 $left(%rainbow1,200) | set %rainbow2 $chr(3) $+ 4,1 | set %rainbow3 1 | set %rainbow4 1
  :loop
  set %rainbow2 %rainbow2 $+ $chr(3) $+ $gettok(4&7&8&9&11&13,%rainbow4,38) $+ $mid(%rainbow1,%rainbow3,1) 
  inc %rainbow3
  if ( $mid(%rainbow1,%rainbow3,1) !=  ) { inc %rainbow4 }
  if ( %rainbow4 > 6 ) { set %rainbow4 1 }
  if ( $mid(%rainbow1,%rainbow3,1) != $null ) { goto loop }
  say %rainbow2
  unset %rainbow1 %rainbow2 %rainbow3 %rainbow4
}
/ascii {
  set %ascii $1-
  %ascii = $replace(%ascii,a,å)
  %ascii = $replace(%ascii,b,ß)
  %ascii = $replace(%ascii,c,©)
  %ascii = $replace(%ascii,d,Ð)
  %ascii = $replace(%ascii,e,ê)
  %ascii = $replace(%ascii,f,f)
  %ascii = $replace(%ascii,g,g)
  %ascii = $replace(%ascii,h,h)
  %ascii = $replace(%ascii,i,ï)
  %ascii = $replace(%ascii,j,j)
  %ascii = $replace(%ascii,k,K)
  %ascii = $replace(%ascii,l,£)
  %ascii = $replace(%ascii,m,m)
  %ascii = $replace(%ascii,n,ñ)
  %ascii = $replace(%ascii,o,ð)
  %ascii = $replace(%ascii,p,þ)
  %ascii = $replace(%ascii,q,q)
  %ascii = $replace(%ascii,r,®)
  %ascii = $replace(%ascii,s,§)
  %ascii = $replace(%ascii,t,t)
  %ascii = $replace(%ascii,u,ü)
  %ascii = $replace(%ascii,v,v)
  %ascii = $replace(%ascii,w,W)
  %ascii = $replace(%ascii,x,×)
  %ascii = $replace(%ascii,y,¥)
  %ascii = $replace(%ascii,z,z)
  %ascii = $replace(%ascii,?,¿)
  %ascii = $replace(%ascii,!,¡)
  say %ascii
  unset %ascii
}
/asciic {
  %ascii = $1-
  %ascii = $replace(%ascii,1,¹)
  %ascii = $replace(%ascii,2,²)
  %ascii = $replace(%ascii,3,³)
  %ascii = $replace(%ascii,1/4,¼)
  %ascii = $replace(%ascii,1/2,½)
  %ascii = $replace(%ascii,3/4,¾)
  %ascii = $replace(%ascii,AE,Æ)
  %ascii = $replace(%ascii,A,Å)
  %ascii = $replace(%ascii,B,ß)
  %ascii = $replace(%ascii,C,Ç)
  %ascii = $replace(%ascii,D,Ð)
  %ascii = $replace(%ascii,E,Ê)
  %ascii = $replace(%ascii,I,Î)
  %ascii = $replace(%ascii,L,£)
  %ascii = $replace(%ascii,N,Ñ)
  %ascii = $replace(%ascii,O,Ô)
  %ascii = $replace(%ascii,R,®)
  %ascii = $replace(%ascii,S,§)
  %ascii = $replace(%ascii,U,Û)
  %ascii = $replace(%ascii,Y,¥) { 
    set %ascii1 %ascii
    unset %ascii
    set %ascii 
    set %asciicnumber 1 
    set %asciiccolor 2
    :continue
    if $mid(%ascii1,%asciicnumber,1) != $null {
      ;set %kaaaa7  $+ %asciicolor $+ $mid(%ascii1,%asciinumber,1) $+ 1
      ;set %ascii %ascii [ $+ [ %kaaaa7 ] ]
      set %ascii %ascii $+  $+ %asciiccolor $+ $mid(%ascii1,%asciicnumber,1) $+ 
      inc %asciicnumber
      If ( %asciiccolor == 15 ) set %asciiccolor 1
      inc %asciiccolor
      goto continue
    }
    say %ascii
    unset %ascii 
    unset %ascii1 
    unset %asciiccolor
    unset %asciicnumber
  }
} 
/brick1 { set %bricknum 1 | unset %brickmsg  | set %brickmsg  | set %brickcolor p
  :start
  if ( %brickcolor == p ) { set %bricknum2 4 | set %bricknum3 1 | set %brickcolor y | goto add }
  if ( %brickcolor == y ) { set %bricknum2 1 | set %bricknum3 4 | set %brickcolor p | goto add }
  :add
  if $mid($1-,%bricknum,1) != $null {
    set %brickmsg %brickmsg $+  $+ %bricknum2 $+ , $+ %bricknum3 $+ $mid($1-,%bricknum,1) $+ 
    inc %bricknum 
  goto start  }
  say %brickmsg
  unset %brick*
}
/brick2 { set %bricknum 1 | unset %brickmsg  | set %brickmsg  | set %brickcolor p
  :start
  if ( %brickcolor == p ) { set %bricknum2 5 | set %bricknum3 15 | set %brickcolor y | goto add }
  if ( %brickcolor == y ) { set %bricknum2 15 | set %bricknum3 5 | set %brickcolor p | goto add }
  :add
  if $mid($1-,%bricknum,1) != $null {
    %brickmsg = %brickmsg $+   $+ %bricknum2 $+ , $+  %bricknum3 $+ $mid($1-,%bricknum,1) $+     
    inc %bricknum 
  goto start  }
  say %brickmsg
  unset %brick*
}
/brick3 { set %bricknum 1 | unset %brickmsg  | set %brickmsg  | set %brickcolor p
  :start
  if ( %brickcolor == p ) { set %bricknum2 12 | set %bricknum3 11 | set %brickcolor y | goto add }
  if ( %brickcolor == y ) { set %bricknum2 11 | set %bricknum3 12 | set %brickcolor p | goto add }
  :add
  if $mid($1-,%bricknum,1) != $null {
    %brickmsg = %brickmsg $+   $+ %bricknum2 $+ , $+  %bricknum3 $+ $mid($1-,%bricknum,1) $+     
    inc %bricknum 
  goto start  }
  say %brickmsg
  unset %brick*
}
/brick4 { set %bricknum 1 | unset %brickmsg  | set %brickmsg  | set %brickcolor p
  :start
  if ( %brickcolor == p ) { set %bricknum2 2 | set %bricknum3 14 | set %brickcolor y | goto add }
  if ( %brickcolor == y ) { set %bricknum2 14 | set %bricknum3 2 | set %brickcolor p | goto add }
  :add
  if $mid($1-,%bricknum,1) != $null {
    %brickmsg = %brickmsg $+   $+ %bricknum2 $+ , $+  %bricknum3 $+ $mid($1-,%bricknum,1) $+     
    inc %bricknum 
  goto start  }
  say %brickmsg
  unset %brick*
}
/vowels {
  %vowels = $1-
  %vowels = $remove(%vowels,a)
  %vowels = $remove(%vowels,e)
  %vowels = $remove(%vowels,i)
  %vowels = $remove(%vowels,o)
  %vowels = $remove(%vowels,u)
  me hugs $1 so tight that the vowels fall out of their nick 2{{{ %vowels }}}
  me watches as %vowels picks up their vowels and puts them back in their nick 2{{{ $1 }}}
  unset %vowels
}
mamaobaba {
  if ( %autojoin = ON ) && ( %channelsjoin != $null ) {
    echo -a 12Auto Join is on, joining the following channels . . .  
    set %temp.count 0
    if ( %channelsjoin != $null ) { 
      set %temp.real $count(%channelsjoin,$chr(44)) + 1
      :ok
      inc %temp.count
      echo -a %temp.count $+ .4  $gettok(%channelsjoin,%temp.count,44)
      join $gettok(%channelsjoin,%temp.count,44)      
      if ( %temp.count => %temp.real ) { halt }
      if ( %temp.count < %temp.real ) { goto ok }
    }
  }
}
massinvite {
  set %chan $$?="Êàíàë? (eg: #i-neon.lv )"
  set %massppl 1
  :loop
  if ($nick(#,%massppl) == chanserv) { inc %massppl | goto loop | halt }
  if ($nick(#,%massppl) == $me) { inc %massppl | goto loop | halt }
  else { .invite $nick(#,%massppl) %chan }
  inc %massppl
  if ($nick(#,%massppl) == $null) { unset %chan | unset %massppl }
  else { goto loop }
}
/ebox {
  if ($editbox($active) == $1 $+ :) { /editbox -c }
  else { /editbox $1 : }
}
/ebox2 {
  query $1
}

/hop { /part # Ïåðåçaõîæó. | .timer 1 1 /join # }
