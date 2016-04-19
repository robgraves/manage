#! /bin/bash
ttl="Add Instructor"

username=$(whiptail --backtitle "$back_title" --title "$ttl" --inputbox "Username" $inp_dim "" 3>&1 1>&2 2>&3)
[[ -z "$username" ]] && exit 1
password=$(whiptail --backtitle "$back_title" --title "$ttl" --inputbox "Password" $inp_dim "" 3>&1 1>&2 2>&3)
[[ -z "$password" ]] && exit 1

crypt=`mkpasswd "$password"`
sudo useradd -m -g admin "$username" -p "$crypt" -s "/usr/sbin/nologin" 1>/dev/null
if [ "$?" -ne 0 ]; then
	
	error=""
	search=`cat /etc/passwd|grep "$username"|cut -d ':' -f 1`
	[[ "$search" == "$username" ]] && error="User ${username} already exists."
	
	whiptail --backtitle "$back_title" --title "$ttl" --msgbox "\nFailed to add user!\n" $msg_dim
	
	[[ -n "$error" ]] &&
	whiptail --backtitle "$back_title" --title "$ttl" --msgbox "\n${error}\n" $msg_dim
	
	exit 1 

else 
	sudo chown $username:admin /home/$username 1>/dev/null
	(echo "$password"; echo "$password")|sudo smbpasswd -a "$username" 1>/dev/null
	if [ "$?" -ne 0 ]; then
		sudo deluser --remove-home "$username" 
		whiptail --backtitle "$back_title" --title "$ttl" --msgbox "\nFailed to add user!\n" $msg_dim
		exit 1
	fi
	sudo touch /var/log/samba/log.${username} 1>/dev/null	
	whiptail --backtitle "$back_title" --title "$ttl" --msgbox "\nUser successfully added!\n" $msg_dim

fi

exit 0
