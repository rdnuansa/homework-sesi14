#!/bin/bash
# repo : https://github.com/mamunsyuhada/sd-assignments/blob/master/bash-script/forever.sh
OnRed='\033[41m' OnGreen='\033[42m' OnWhite='\033[47m' OnYellow='\033[43m' ColorOff='\033[0m'
LOCKFILE=tmp/foreverserver.lock
case "$1" in
  start)
    if [[ !(-f $LOCKFILE) ]]; then
      tmp/foreverserver &
      touch $LOCKFILE
      PID="`cat /tmp/foreverserver.pid`"
      echo -e "${OnGreen}foreverserver ($PID) is started${ColorOff}"
    else
      PID="`cat /tmp/foreverserver.pid`"
      echo -e "${OnWhite}foreverserver ($PID) is starting${ColorOff}"
    fi
    ;;
  stop)
    if [[ -f $LOCKFILE ]]; then
      PID="`cat /tmp/foreverserver.pid`"
      kill $PID
      rm -rf $LOCKFILE
      echo -e "${OnRed}foreverserver ($PID) is stoped${ColorOff}"
    else
      echo -e "${OnWhite}foreverserver was stoped${ColorOff}"
    fi
    ;;
  *)
    echo -e "${OnYellow}Usage: $0 {start|stop}${ColorOff}"
    exit 1
    ;;
esac