#!/bin/bash

ls > tmp

if ! grep -Fxq nouvelles tmp
then 
	mkdir nouvelles
fi

ls -1 -A --sort=time nouvelles/ > tmp

while test $# -ge 0
do
	case "$1" in
		-liste) while read line
			do
				case $line in
					.temoin) break;;
				esac
			echo "$line"
			done < tmp 
			break;;

		-lire) while read line
			do
				case $line in
					.temoin) break;;
				esac
				echo "$line"
				echo "Contenu de $line :"
				echo "-----"
				cat nouvelles/$line
				echo "-----"
			done < tmp 
			break;;

		-toutlu) touch .temoin;; 
		-purge) while read line
			do
				if test nouvelles/.temoin -nt nouvelles/$line
				then 
					rm nouvelles/$line
				fi
			done < tmp 
			break;;


		*) echo "Mauvais argument: Attendu -liste -lire -toutlu -purge" > /dev/stderr
			exit 1;;
	esac
	shift
done

rm -f tmp

