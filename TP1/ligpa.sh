#!/bin/bash

echo -n "Entrer nom du fichier:"
read nom
if ! test -r "$nom"
then
	echo "Erreur lecture fichier" > /dev/stderr
	exit 1
fi

parite=impaire

while read ligne
do
	if test $parite = paire
	then 
		echo "$ligne"
		parite=impaire
	else
		parite=paire
	fi
done < "$nom"
