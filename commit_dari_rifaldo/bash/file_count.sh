#!/bin/sh

for x in $@
do
	echo -n "$x :"
	 ls -l $x | wc -l 
done
