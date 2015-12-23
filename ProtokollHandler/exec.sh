#!/bin/bash
#vim: tabstop=4
#----------------------------------------------------------------------------
# Execution-Script als Protokoll-Handler
#
# 21.11.2015	v0.1	Rudimentaeres Script als Test
# 22.11.2015	v0.2	Output in Logfile
# 24.11.2015	v0.3 	zenity-Messages and run application
#
# ToDo:	
#	1. Verzeichnis feststellen und mit nautilus <Verzeichnis> aufrufen		
#
#----------------------------------------------------------------------------
CMD=${0##*/} 
logfile=/tmp/$CMD.log 
exec > $logfile 

date
file=$1
argument=$1
echo "argument:" $argument

#remove "exec:" form argument
filename=$(echo $file | cut -d : -f 2)

# check if argument is a directory
if [ -d $filename ] 
then
	# call nautilus with directory as argument
	echo "$filename is a directory"
	nautilus --new-window $filename &
	sleep 1
	echo "$filename is a directory"
else

	extension=$(echo $file | cut -d . -f 2)
	extension="${extension,,}"	# lower case

	echo "Extension: "$extension
	echo "Filename: "$filename

		# Filename auf exist pruefen
		# Pruefen, ob extension vorhanden ist 

		if [ -e "$filename" ] 
		then
			zenity --info --title="Execute" --width=800 --height=1 --text=$filename --timeout=3
		else
			zenity --error --title="Execute" --width=800 --height=1 --text="$filename doesn't exist"
			exit
		fi

		application=$(grep -i $extension exec.cfg | cut -d : -f 2)
		echo "Application: $application"

		case $extension in
			mp3)
				echo $extension
				clementine --verbose $filename & ;;
			pdf)
				clementine --verbose $filename & ;;
			mscz)
		# Musescore 		
		musescore $filename & ;;
			mg4 | sgu)	
				# Biab-Files; open with Wine
				echo $extension
				wine "c:\\bb\\bbw.exe" $filename & ;;
			*)  print "Wrong extension"
				zenity --error --title="Execute" --width=800 --height=1 --text="$filename Unknown extension ($extension)";;

		esac
fi

