#!/bin/bash
#-----------------------------------------------------
# Execution-Script als Protokoll-Handler
#
# 21.11.2015	v0.1	Rudimentaeres Script als Test
#-----------------------------------------------------
file=file:///home/dieter/Musik/Musik-Wiki/Lehrbuecher/JameyAbersold/Volume06-All-Bird/02-NowsTheTime-BilliesBounce/02-NowsTheTime-BilliesBounce.mp3 
file=file:///home/dieter/Musik/Musik-Wiki/Lehrbuecher/JameyAbersold/Volume06-All-Bird/02-NowsTheTime-BilliesBounce/02-NowsTheTime-BilliesBounce.pdf 

file=$1

extension=$(echo $file | cut -d . -f 2)
filename=$(echo $file | cut -d : -f 2)

echo "Extension: "$extension
echo "Filename: "$filename



desktopFile=$(grep $extension /usr/share/applications/defaults.list | cut -d = -f 2 | uniq | cut -d . -f 1)
echo $desktopFile

###grep Exec /usr/share/applications/$desktopFile

sleep 2
$desktopFile $filename &


case $extension in
mp3)
	echo "Running MP3"
;;
pdf)
	echo "Running PDF"
;;
esac
