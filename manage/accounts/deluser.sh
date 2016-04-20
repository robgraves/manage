#! /bin/bash
ttl="Delete Student"

students=`cat /etc/passwd|sed -n '/^.*:.*:.*:1006.*$/p'|cut -d ':' -f 1`
if [ -z "$students" ]; then

whiptail --msgbox --backtitle "$back_title"  --title "$ttl" "There are currently no student accounts in the system!" $msg_dim
exit 1

fi

username=$(whiptail --backtitle "$back_title" --title "$ttl" --inputbox "Username" $inp_dim "" 3>&1 1>&2 2>&3)
[[ -z "$username" ]] && exit 1
username=`echo "$username"|tr '[:upper:]' '[:lower:]'`

whiptail --backtitle "$back_title" --title "$ttl" --yesno  "\n$USER, are you sure you want to delete ${username}?\nThis will permenantly delete all of ${username}'s data" $yn_dim
[[ "$?" -eq 1 ]] && exit 1

if [ -n `groups $username|egrep "admin|sudo"` ]; then
	
	sudo smbpasswd -x "$username" 1>/dev/null 
	sudo deluser --remove-home "$username" 1>/dev/null
	errno="$?"
else
	errno=0;
fi

if [ "$errno" -ne 0 ]; then

	error=`man deluser|grep "RETURN VALUE" -A 19|grep $errno|tr -s ' '|sed 's/...//'`
	whiptail --backtitle "$back_title" --title "$ttl" --msgbox "\nFailed to delete user!\n" $msg_dim
	
	[[ -n "$error" ]] &&
	whiptail --backtitle "$back_title" --title "$ttl" --msgbox "\n${error}\n" $msg_dim
	
	exit 1

else
	sudo rm -f /var/log/samba/log.${username} 1>/dev/null
	whiptail --backtitle "$back_title" --title "$ttl" --msgbox "\nUser deleted successfully!\n" $msg_dim
fi

exit 0
