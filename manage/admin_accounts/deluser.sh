#! /bin/bash
ttl="Delete Instructor"

students=`cat /etc/passwd|sed -n '/^.*:.*:.*:1007.*$/p'|cut -d ':' -f 1`
if [ -z "$students" ]; then

whiptail --msgbox --backtitle "$back_title"  --title "$ttl" "There are currently no instructor accounts in the system!" $msg_dim
exit 1

fi

username=$(whiptail --backtitle "$back_title" --title "$ttl" --inputbox "Username" $inp_dim "" 3>&1 1>&2 2>&3)
[[ -z "$username" ]] && exit 1

whiptail --backtitle "$back_title" --title "$ttl" --yesno  "\n$USER, are you sure you want to delete ${username}?\n" $yn_dim
[[ "$?" -eq 1 ]] && exit 1

if [ -n "`cat /etc/passwd|grep "$username"|sed -n '/^.*:.*:.*:1007.*$/p'`" ]; then
	
	sudo smbpasswd -x "$username" 1>/dev/null 
	sudo deluser --remove-home "$username" 1>/dev/null
	errno="$?"
else
	errno=6;
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
