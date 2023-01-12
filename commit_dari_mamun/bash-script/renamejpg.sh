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