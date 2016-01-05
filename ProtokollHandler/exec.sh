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
# 05.01.2016	v.06	delete unused lines/code
#
# Description: This script is called from a so called protocoll-handler
# inside a web-browser like firefox. The script ist called with an argument
# "exec:<filename>" where filename can be the name of a directory or the
# name of a local file. The local file is opened with the default application
# a directoy is opened with the default filemanager.
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
	# call default filemanager with directory as argument
	echo "$filename is a directory"
	exec xdg-open $filename
fi

# check if filename exists
echo "Filename: "$filename

if [ -e "$filename" ] 
then
	echo ""
else
	zenity --error --title="Execute" --width=800 --height=1 --text="$filename doesn't exist"
	exit
fi

exec xdg-open $filename
