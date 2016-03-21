#!/bin/bash
function trim {
    echo $*
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

		#Call vlc to play the selected file
		vlc -f --no-repeat "${FILM2}"
	#fi
fi