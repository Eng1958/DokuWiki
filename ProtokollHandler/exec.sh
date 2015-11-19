#!/bin/bash
protocol=$(echo $1 | cut -d : -f 1)
address=$(echo $1 | cut -d / -f 3)
user=$(echo $address | grep @ | cut -d @ -f 1)
port=$(echo $address | grep : | cut -d : -f 2)
host=$(echo $address | cut -d @ -f 2 | cut -d : -f 1)

date >> /tmp/tmp.log
echo "Hello World" >> /tmp/tmp.log
echo $1 >> /tmp/tmp.log
echo $protocol >> /tmp/tmp.log

echo $1
sleep 2
clementine $1 &

## rosegarden &

return


case $protocol in
ssh)
connectstring=$(echo "$([ -z $user ] || echo "$user@")$host$([ -z $port ] || echo "-p $port")")
gnome-terminal --window -e "$protocol $connectstring"
;;
telnet)
connectstring=$(echo "$host $([ -z $port ] || echo "$port")$([ -z $user ] || echo "-l $user")")
gnome-terminal --window -e "$protocol $connectstring"
;;
rdesktop)
connectstring=$(echo "$([ -z $user ] || echo "-u $user ")$host$([ -z $port ] || echo ":$port")")
rdesktop -g 1280x960 $connectstring
;;
vnc)
connectstring=$(echo "$host$([ -z $port ] || echo":$port")")
vncviewer $connectstring
;;
esac
