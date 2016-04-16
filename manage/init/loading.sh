ttl="Server Manager 2016"

for ((i=0; i<=100; i+=10)); do
	
	echo $i
	sleep .1
	
done |$(whiptail --backtitle "$back_title" --title "$ttl" --gauge "Initializing." 6 60 0 1>&2 3>&1 2>&3) 

for ((i=0; i<=100; i+=10)); do
	
	echo $i
	sleep .1
	
done |$(whiptail --backtitle "$back_title" --title "$ttl" --gauge "Waking up hamster.." 6 60 0 1>&2 3>&1 2>&3) 



for ((i=0; i<=100; i+=10)); do
	
	echo $i
	sleep .1
	
done |$(whiptail --backtitle "$back_title" --title "$ttl" --gauge "Feeding it caffeine..." 6 60 0 1>&2 3>&1 2>&3) 

exit 0
