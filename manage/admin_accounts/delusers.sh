#! /bin/bash
ttl="Remove All Instructors"

students=`cat /etc/passwd|sed -n '/^.*:.*:.*:1007.*$/p'|cut -d ':' -f 1`
if [ -z "$students" ]; then

whiptail --msgbox --backtitle "$back_title"  --title "$ttl" "There are currently no Instructor accounts in the system!" $msg_dim
exit 1

fi

for user in $students; do
student_array+=( " ${user}" "" ON)
done

whip_students=$(whiptail --backtitle "$back_title"  --title "$ttl" --checklist "The following users have been selected for removal.\n\n      ---Navigation Instructions---\n[Sace Bar]    Set/unset user for removal\nArrow-keys    Navigates between users\n[TAB]         navigates to [Ok]/[Cancel]\n[ENTER]       selects [Ok]/[Cancel]" $chk_dim "${student_array[@]}" 3>&1 1>&2 2>&3)
[[ "$?" -eq 1 ]] && exit 1

students=`echo "${whip_students}"|tr -d '"'|tr -s ' '|tr ' ' '\n'|sed '1d'`

$(whiptail --backtitle "$back_title" --title "$ttl" --yesno  "\n$USER, are you sure you want to delete these users?\n" $yn_dim 3>&1 1>&2 2>&3)
[[ "$?" -eq 1 ]] && exit 1


for username in $students; do

	sudo smbpasswd -x "$username" 1>/dev/null 
	sudo deluser --remove-home "$username" 1>/dev/null
	sudo rm -f /var/log/samba/log.${username} 1>/dev/null
	errno="$?"
done
	
	#whiptail --backtitle "$back_title" --title "$ttl" --msgbox "\nFailed to delete user!\n" $msg_dim
	#whiptail --backtitle "$back_title" --title "$ttl" --msgbox "\nUser deleted successfully!\n" $msg_dim

exit 0
