#!/bin/bash

debug=false
optim=false
warni=false
option=false
action=false

afficher_usage () {
	echo -e " -h|--help \n --touch|--clean fichier.c \n [option ...] --c fichier.c ... \n Options : --debug|--optim|--warni "
}

modifier_date_fichiers () {
	local i
	shift
	for i ; do
		if test -e "$i" ; then
			touch "$i"
			echo "fichier: $i date changée"
		else 
			echo "fichier: $i n'existe pas"
		fi
	done
}

obtenir_nom_executable () {
	echo "${ $1%.c }"
}

nettoyer_fichiers () {
	local i nom
	shift
	for i ; do
		if test -e "$i" ; then
			nom = $(obtenir_nom_executable "$i")
			if rm "$nom"; then
				echo"executable: $nom supprimé"
			else
				echo"executable: $nom absent"
			fi
		else 
			echo "fichier: $i n'existe pas"
		fi
	done
}

compiler_fichiers () {
	local i
	shift
	for i ; do
		if test -e "$i" ; then
			nom = $(obtenir_nom_executable "$i")
			gcc $i -o $nom
		else 
			echo "fichier: $i n'existe pas"
		fi
	done
}

if ! test "$#" -gt 0 ; then
	afficher_usage > /dev/stderr
	exit 1
fi

while test "$#" -gt 0 ; do
	case "$1" in
		--debug)debug=true; option=true; shift;;
		--optim)optim=true; option=true; shift;;
		--warni)warni=true; option=true; shift;;
		-h|--help) if ! "$option"
				then 
					action=hlp
				else 
					afficher_usage > /dev/stderr
					exit 1  
			   fi;;
		--touch) if [ ! "$option" ] || [ "$action" = "false" ] ; then 
					action=tch
					fichier= "$2"
					shift
				else 
					afficher_usage > /dev/stderr
					exit 1  
			 fi;;
		--clean)  if [ ! "$option" ] || [ "$action" = "false" ] ; then 
					action=clean
					fichier="$2"
					shift
				else 
					afficher_usage > /dev/stderr
					exit 1  
			   fi;;
		--cc) if [ ! "$option" ] || [ "$action" = "false" ] ; then 
					action=cc
					fichier="$2"
					shift
				else 
					afficher_usage > /dev/stderr
					exit 1
		      fi;;
		*) if "$action" = false ; then
			break			
		   else
			fichier += "$2"
	           fi;;

	esac
done
if "$option" ; then
		if ! [ "$action" == "cc" ] ; then
			afficher_usage > /dev/stderr
			exit 1
		fi
fi

case "$action" in
	hlp)	afficher_usage
		exit 0;;
	tch) modifier_date_fichiers "$fichier" ; break;;
	clean) nettoyer_fichiers "$fichier"; break;;
	cc);;
	false)afficher_usage > /dev/stderr
              exit 1;;
esac


echo "$option $debug $optim $warni $action"
