#!/bin/bash
#-----------------------------------------------------
# Execution-Script als Protokoll-Handler
#
# 21.11.2015	v0.1	Rudimentaeres Script als Test
# 22.11.2015	v0.2	Output in Logfile
#-----------------------------------------------------

logfile=/tmp/exec.log 
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
zenity --error --text "$filename"

desktopFile=$(grep $extension /usr/share/applications/defaults.list | cut -d = -f 2 | uniq | cut -d . -f 1)
echo $desktopFile

$desktopFile $filename &

