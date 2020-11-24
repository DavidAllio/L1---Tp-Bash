#!/bin/bash

echo -n "Nom fichier entrée: "
read nom1
echo -n "Nom fichier sortie: "
read nom2

if ! test -r "$nom1"
then
	echo "Erreur Lecture fichier" > /dev/stderr
	exit 1
fi

if ! >| "$nom2"
then 
	echo "Erreur Creation fichier" > /dev/stderr
	exit 1
fi

echo -n "Entrer a: "
read a
echo -n "Entrer b: "
read b

expr $b + 1 >| tmp
read b < tmp

expr $b - $a >|tmp
read c < tmp

rm -f tmp

echo "a: $a b: $b c: $c" 

if test "$a" -gt "$b"
then
	echo "Erreur Creation fichier" > /dev/stderr
	exit 1
elif test "$a" -lt 0
then 
	echo "Erreur Creation fichier" > /dev/stderr
	exit 1
fi

head -$b $nom1 | tail -$c > $nom2

