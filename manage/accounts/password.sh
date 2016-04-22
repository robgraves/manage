#! /bin/bash
ttl="Reset Student Password"

students=`cat /etc/passwd|sed -n '/^.*:.*:.*:1006.*$/p'|cut -d ':' -f 1`
if [ -z "$students" ]; then

whiptail --msgbox --backtitle "$back_title"  --title "$ttl" "There are currently no student accounts in the system!" $msg_dim
exit 1

fi

username=$(whiptail --backtitle "$back_title" --title "$ttl" --inputbox "Enter username: " $inp_dim "" 3>&1 1>&2 2>&3)
[[ -z "$username" ]] && exit 1
username=`echo "$username"|tr '[:upper:]' '[:lower:]'`

password=$(whiptail --backtitle "$back_title" --title "$ttl" --inputbox "Enter new password: " $inp_dim "" 3>&1 1>&2 2>&3)
[[ -z "$password" ]] && exit 1

crypt=`mkpasswd "$password"`

sudo usermod -p "$crypt" "$username" 1>/dev/null
(echo "$password"; echo "$password")|sudo smbpasswd -a "$username" 1>/dev/null

whiptail --backtitle "$back_title" --title "$ttl" --msgbox "\nPassword changed successfully!\n" $msg_dim

exit 0
