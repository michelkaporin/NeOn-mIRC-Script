on *:LOAD: {
load -a imgmirc.ini
set %imgmirc_config 253
/im_config
}

on *:START: if ( %imgmirc_config & 1 == 1 ) im_preload


