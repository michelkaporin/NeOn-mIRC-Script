on *:LOAD: {
  /copy -o files\backup\Backup-mirc.ini mirc.ini
  /copy -o files\backup\Backup-remote.ini script\remote.ini
/unload -rs recover.mrc
}