#!bin/bash/
rename_file() {
		current_date=`date +%Y%m%d`
		listfile=`ls $1/*.jpg`
		for w in $listfile; do
			myfile=`basename $w`
			newpath="$1/$current_date=$myfile"
			mv $w $newpath
		done
}

echo "insert direktori target : "
read dittarget

ls $dittarget
if [ $? -ne 0 ]; then
	echo "direktori not available"
	exit 1
fi

rename_file $dittarget
