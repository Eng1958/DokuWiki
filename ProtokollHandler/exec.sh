#!/bin/bash
#-----------------------------------------------------
# Execution-Script als Protokoll-Handler
#
# 21.11.2015	v0.1	Rudimentaeres Script als Test
# 22.11.2015	v0.2	Output in Logfile
# 24.11.2015	v0.3 	zenity-Messages and run application
#-----------------------------------------------------
CMD=${0##*/} 
logfile=/tmp/$CMD.log 
exec > $logfile 

date
file=$1
echo $file

extension=$(echo $file | cut -d . -f 2)
filename=$(echo $file | cut -d : -f 2)

echo "Extension: "$extension
echo "Filename: "$filename

# Filename auf exist pruefen
# Pruefen, ob extension vorhanden ist 

if [ -e "$filename" ] 
then
	zenity --info --text=$filename
else
	zenity --error --text="$filename doesn't exist"
	exit
fi

case $extension in
	mp3)
		echo $extension
		clementine --verbose $filename &
;;
	pdf)
		clementine --verbose $filename &
;;
	mscz)
		musescore $filename & ;;
   *)  
       print "Wrong name...";;
esac

