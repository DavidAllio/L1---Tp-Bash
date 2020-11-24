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

echo "a: $a b: $b" 

if test "$a" -gt "$b"
then
        echo "Erreur" > /dev/stderr
        exit 1
elif test "$a" -lt 0
then 
        echo "Erreur" > /dev/stderr
        exit 1
fi

expr $b + 1 >| tmp
read b < tmp

expr $a - 1 >| tmp
read a < tmp

expr $b - $a >|tmp
read c < tmp

rm -f tmp

head -$a $nom1 > $nom2

head -$b $nom1 | tail -$c | sort -r >> $nom2

tail -n +$b $nom1 >> $nom2
