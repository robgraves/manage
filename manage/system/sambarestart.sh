#!/bin/bash
ttl="Restart Services"

whiptail --backtitle "$back_title" --title "$ttl" --yesno "$USER, restart samba services?\n\nUsers authenticated through samba will lose connection." $yn_dim
[[ "$?" == 1 ]] && exit 1

sudo /etc/init.d/samba restart 1>/dev/null &

for ((i=0; i<=100; i+=5)); do
	
	echo $i
	sleep .1
	
done |$(whiptail --backtitle "$back_title" --title "$ttl" --gauge "Please wait, samba services restarting..." 6 60 0 1>&2 3>&1 2>&3) 
