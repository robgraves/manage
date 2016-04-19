ttl="Student Disk Usage"

students=`cat /etc/passwd|sed -n '/^.*:.*:.*:1006.*$/p'|cut -d ':' -f 1`
if [ -z "$students" ]; then

whiptail --msgbox --backtitle "$back_title"  --title "$ttl" "There are currently no student accounts in the system!" $msg_dim
exit 1

fi

output=$(du -sh `echo "$students"|sed 's/^\(.*\)$/\/home\/\1/g'|tr "\n" " "`|sort -r|sed 's/^\(.*\)\s*\/home\/\(.*\)/\1\2/g')
view="Listing by disk usage"

whiptail --backtitle "$back_title"  --title "$ttl" --msgbox "${view},\n\n${output} " $chk_dim --yes-button " Toggle View " --no-button " Back " --scrolltext



exit 0
