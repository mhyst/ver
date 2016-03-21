#!/bin/bash
VERSION=0.1.2

#Check if there is at least one argument
[[ -n "$1" ]] || {
	echo "ver $VERSION - Copyleft (GPL v3) Julio Serrano 2016"
	echo "Modo de empleo: ver <título>"
	echo
	echo " Ejemplos:"
	echo
	echo "   Para reproducir archivos que contengan 'xyz'"
	echo "   \$> ver xyz"
	echo
	echo "   Para ver un episodio de Better call Saul"
	echo "   \$> ver better call saul"
	echo
	echo " Puede introducir un máximo de nueve palabras."
	echo " El script no tiene en cuenta mayúsculas y minúsculas"
	echo

	exit 0
}

#You must chage the path to your own db
SQLITE="sqlite /home/julio/bin/sver/verdb"

function trim {
    echo $*
}

SQLITE="sqlite /home/julio/bin/sver/verdb"

function getFile {
	filename="$1"

	id=`$SQLITE "select id from file where filename = \"$filename\""`
	echo $id
}

function insertFile {
	filename="$1"

	$SQLITE "insert into file  (filename) values (\"$filename\")"

	echo $(getFile "$filename")
}

function getVisto {
	id=$1

	visto=`$SQLITE "select veces from visto where id=$id"`
	echo $visto
}

function insertVisto {
	id=$1

	$SQLITE "insert into visto values ($id, 1)"
}

function addVisto {
	id=$1

	$SQLITE "update visto set veces=veces+1 where id=$id"
	echo "$(getVisto "$id")"
}

#Basedir: You need to change this to your needs
DIR="/home/julio/NAS/Download/transmission/completed/"
cd $DIR

#Get args into PARH variable
PARM="$(trim "$1 $2 $3 $4 $5 $6 $7 $8 $9")"

echo "Buscando: >$PARM<"
echo

#Find files that match with your args
find * -type f | grep -i "$PARM" | sort > /tmp/films.txt
FILE=$(</tmp/films.txt)
SIZE=${#FILE}

#If there were no results
if [[ $SIZE == 0 ]]; then
	echo "No hay coincidencias"
else
	#Read films.txt into array IN
	readarray IN < /tmp/films.txt
	#We no longer need films.txt
	rm /tmp/films.txt

	#If there was just a result
	#there's no need for menu
	if [[ ${#IN[*]} == 1 ]]; then

		FILM="$FILE"

	else

		#As there were several results, we show a menu with all of them
		for index in ${!IN[*]}
		do
		    printf "$index: ${IN[$index]}"
		done
		
		echo
		echo "Introduzca el número:"
		read REPLY
		echo

		#We see if the user entered a number such as we need
		if [ "$REPLY" -ge 0 -a "$REPLY" -le ${#IN[*]} ]; then

			echo "Usted ha elegido: ${IN[REPLY]}"
			FILM="${IN[REPLY]}"

		else
			
			#We give advice to the user and exit
			echo "Tiene que introducir un número entre 0 y (${#IN[*]}-1)"
			exit 1

		fi
	fi

	#echo "¿Quiere ver esta?"
	#echo
	#echo "$FILM"
	#echo
	#echo "(S/N)"
	#read RES
	#if [ $RES == "S" ] || [ $RES == "s" ]; then
		#echo "$FILM" | hexdump -c
		#Remove \n chars from the string to avoid vlc errors
		FILM2=`echo $FILM | sed s/u000A//g`
		#echo "$FILM2" | hexdump -c

		#Look if the file is already in the db
		ID=$(getFile "$FILM2")
		#echo $ID

		if [[ ${#ID} == 0 ]]; then

			echo "Es la primera vez que va a ver este archivo"
			#It is not, let's insert it
			ID=$(insertFile "$FILM2")
			#echo $ID
			$(insertVisto "$ID")
			#echo "Has visto este archivo $VECES veces"

		else
			
			#The file is already in the db, so we update visto
			VECES=$(addVisto "$ID")
			echo "Has visto este archivo $VECES veces"
		fi
		#Call vlc to play the selected file
		vlc -f --no-repeat "${FILM2}"
	#fi
fi