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