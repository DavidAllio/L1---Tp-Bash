#!/bin/bash

if test $# -eq 0 
then 
	echo "Manque argument" > /dev/stderr
	exit 1
fi

>|tmp
while test $# -gt 0
do
	echo -n "$1 (O/N) ? "
	read reponse
	case $reponse in
		O) echo "$1" >> tmp ;;
	esac
	shift
done

cat tmp

rm -f tmp
