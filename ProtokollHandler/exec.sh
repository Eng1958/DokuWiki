#!/bin/bash
# vim: tabstop=4
#----------------------------------------------------------------------------
# Execution-Script als Protokoll-Handler
#
# Author:	Dieter Engemann	dieter@engemann.me
#
# 21.11.2015	v0.1	Rudimentaeres Script als Test
# 22.11.2015	v0.2	Output in Logfile
# 24.11.2015	v0.3 	zenity-Messages and run application
# 02.01.2016	v0.4 	run default application with xdg-open
# 04.01.2016	v.05	comment unused lines/code
#
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
	# call nautilus with directory as argument; repplace
	# shell with exec command
	echo "$filename is a directory"
	### exec nautilus --new-window $filename
	exec xdg-open $filename
	## exit
fi

# check filename and extension 
extension=$(echo $file | cut -d . -f 2)
extension="${extension,,}"	# lower case

echo "Extension: "$extension
echo "Filename: "$filename

# Filename auf exist pruefen
# Pruefen, ob extension vorhanden ist 

if [ -e "$filename" ] 
then
	## zenity --info --title="Execute" --width=800 --height=1 --text=$filename --timeout=3
	echo ""
else
	zenity --error --title="Execute" --width=800 --height=1 --text="$filename doesn't exist"
	exit
fi

exec xdg-open $filename

##application=$(grep -i $extension exec.cfg | cut -d : -f 2)
##echo "Application: $application"

##case $extension in
##	mp3)
##			echo $extension
##			exec clementine --verbose $filename ;;
##	pdf)
##		exec evince $filename;;
##	mscz)
##			# Musescore 		
##			musescore $filename & ;;
##	mg4 | sgu)	
##				# Biab-Files; open with Wine
##				echo $extension
##				wine "c:\\bb\\bbw.exe" $filename & ;;
##	*)  print "Wrong extension"
##		zenity --error --title="Execute" --width=800 --height=1 --text="$filename Wrong or undefined extension ($extension)";;
##esac
