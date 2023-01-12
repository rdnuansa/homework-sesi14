# Bash Script | [Repo](https://github.com/mamunsyuhada/sd-assignments/edit/master/bash-script/README.md)

### Count File in a Directory
#### code
```sh
#!/bin/bash
# repo : https://github.com/mamunsyuhada/sd-assignments/blob/master/bash-script/countfiles.sh

RESULT=""
CURRENT_PATH="`pwd`"
countFiles() {
  # https://stackoverflow.com/questions/18062778/how-to-hide-command-output-in-bash
  cd $1 &> /dev/null
  if [[ "$?" == "1" ]]; then
    echo "Usage: ./countfiles.sh <directory path> ....<directory path>"
    exit 1
  fi
  # https://devconnected.com/how-to-count-files-in-directory-on-linux/
  # -v = not match, "/" indicates a directory
  RESULT+="$1 : `ls -p . | grep -v / | wc -l`"
  RESULT+="\n"
  # back to first CURRENT_PATH
  cd $CURRENT_PATH &> /dev/null
}
for arg in "$@"
do
  countFiles "$arg"
done
printf "$RESULT\r"
```

#### result
```sh
> # ./countfiles.sh <directorytarget> ....<directorytarget>
❯ bash countfiles.sh example/ ./ tmp/ img/
example/ : 7
./ : 12
tmp/ : 2
img/ : 7
```

### Rename JPG Files with This Day Prefix

#### code
```sh
#!/bin/bash
# repo : https://github.com/mamunsyuhada/sd-assignments/blob/master/bash-script/renamejpg.sh
THIS_DAY=`date +%Y%m%d`
for IMAGE in `ls *.jpg`
do
  # is jpg file generated in thisday ? 
  if [[ ${IMAGE:0:8} == THIS_DAY ]]; then
    continue
  fi
  RESULT=$THIS_DAY
  RESULT+="-$IMAGE"
  mv $IMAGE $RESULT
  printf "$IMAGE\t--->\t$RESULT\n\r"
done
```
#### result
```sh
❯ ll | grep -v .sh |grep .jpg
-rw-r--r-- 1 praktis-mamun 197121  66K Dec 17 03:29 backend.jpg
-rw-r--r-- 1 praktis-mamun 197121  20K Dec 17 03:27 interview.jpg
-rw-r--r-- 1 praktis-mamun 197121 101K Dec 17 03:26 lang.jpg
-rw-r--r-- 1 praktis-mamun 197121  50K Dec 17 03:28 meme.jpg
-rw-r--r-- 1 praktis-mamun 197121 224K Dec 17 03:29 memedev.jpg
-rw-r--r-- 1 praktis-mamun 197121  57K Dec 17 03:28 proggamer.jpg
-rw-r--r-- 1 praktis-mamun 197121  46K Dec 17 03:26 programmer.jpg
❯ bash renamejpg.sh
backend.jpg     --->    20221217-backend.jpg
interview.jpg   --->    20221217-interview.jpg
lang.jpg        --->    20221217-lang.jpg
meme.jpg        --->    20221217-meme.jpg
memedev.jpg     --->    20221217-memedev.jpg
proggamer.jpg   --->    20221217-proggamer.jpg
programmer.jpg  --->    20221217-programmer.jpg
❯ ll | grep -v .sh |grep .jpg
-rw-r--r-- 1 praktis-mamun 197121  66K Dec 17 03:29 20221217-backend.jpg
-rw-r--r-- 1 praktis-mamun 197121  20K Dec 17 03:27 20221217-interview.jpg
-rw-r--r-- 1 praktis-mamun 197121 101K Dec 17 03:26 20221217-lang.jpg
-rw-r--r-- 1 praktis-mamun 197121  50K Dec 17 03:28 20221217-meme.jpg
-rw-r--r-- 1 praktis-mamun 197121 224K Dec 17 03:29 20221217-memedev.jpg
-rw-r--r-- 1 praktis-mamun 197121  57K Dec 17 03:28 20221217-proggamer.jpg
-rw-r--r-- 1 praktis-mamun 197121  46K Dec 17 03:26 20221217-programmer.jpg
```

### Start Stop Forever Server
#### code
```sh
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
```
#### result
```sh
❯ bash forever.sh start
foreverserver (3969) is started
❯ bash forever.sh start
foreverserver (3969) is starting
❯ ls tmp
foreverserver  foreverserver.lock
❯ bash forever.sh stop
foreverserver (3969) is stoped
❯ bash forever.sh stop
foreverserver was stoped
❯ bash forever.sh stop
foreverserver was stoped
```
