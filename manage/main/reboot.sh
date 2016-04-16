ttl="Reboot Server"

whiptail --backtitle "$back_title" --title "$ttl" --yesno "$USER, are you sure you want to reboot the server?\n\nYou and other users will temporarily lose connection to this server." $yn_dim
[[ "$?" == 1 ]] && exit 1;

for ((i=0; i<=100; i+=5)); do
	
	echo $i
	sleep .1
	
done |$(whiptail --backtitle "$back_title" --title "$ttl" --gauge "Deinitializing..." $bar_dim 1>&2 3>&1 2>&3) 

(sleep 5; sudo reboot) &

exit 0
