#!/bin/bash
function trim {
    echo $*
}

PLAYER="vlc"
DIR="/home/julio/NAS/Download/transmission/completed/"
cd $DIR
PARM="$(trim "$1 $2 $3 $4 $5 $6 $7 $8 $9")"
echo "Buscando: >$PARM<"
echo
find * -type f | grep -i "$PARM" | sort > /home/julio/bin/sver/films.txt
FILE=$(</home/julio/bin/sver/films.txt)
#echo "$FILE"
SIZE=${#FILE}
#echo $SIZE
if [[ $SIZE == 0 ]]; then
	echo "No hay coincidencias"
else
	readarray IN < /home/julio/bin/sver/films.txt
	rm /home/julio/bin/sver/films.txt

	#echo ${#IN[*]}
	if [[ ${#IN[*]} == 1 ]]; then
		FILM="$FILE"
	else
		#IFS=\n
		for index in ${!IN[*]}
		do
		    printf "$index: ${IN[$index]}"
		done
		unset IFS
		echo
		echo "Introduzca el número:"
		read REPLY
		if [ "$REPLY" -ge 1 -a "$REPLY" -le ${#IN[*]} ]; then
			echo
			echo "Usted ha elegido: ${IN[REPLY]}"
			FILM="${IN[REPLY]}"
		else
			echo
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
		FILM2=`echo $FILM | sed s/u000A//g`
		#echo "$FILM2" | hexdump -c

		vlc -f --no-repeat "${FILM2}"
	#fi
fi
