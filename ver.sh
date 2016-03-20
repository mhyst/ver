#!/bin/bash
function trim {
    echo $*
}

DIR="/home/julio/NAS/Download/transmission/completed/"
cd $DIR
PARM="$(trim "$1 $2 $3 $4 $5 $6 $7 $8 $9")"
echo "Buscando: >$PARM<"

FILE=`find * -type f | grep -i "$PARM"`
echo "$FILE"
SIZE=${#FILE}
echo $SIZE
if [[ $SIZE == 0 ]]; then
	echo "No hay coincidencias"
else
	echo "¿Quiere ver esta?"
	echo "${FILE}"
	echo "(S/N)"
	read RES
	if [ $RES == "S" ] || [ $RES == "s" ]; then
		vlc "$FILE"
	fi
fi
