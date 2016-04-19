ttl="Instructor listing"

instructors=`cat /etc/passwd|sed -n '/^.*:.*:.*:1007.*$/p'|cut -d ':' -f 1`
if [ -z "$instructors" ]; then

whiptail --msgbox --backtitle "$back_title"  --title "$ttl" "There are currently no instructor accounts in the system!" $msg_dim
exit 1

fi

output=`echo "$instructors"|sort`
view="Listing by username"

#if [ "$flag" -eq 1 ]; then 
#	output=$(du -sh `echo "$students"|sed 's/^\(.*\)$/\/home\/\1/g'|tr "\n" " "`|sort -r)
#	view="Listing by disk usage"
#fi

whiptail --backtitle "$back_title"  --title "$ttl" --msgbox "${view},\n\n${output} " $chk_dim --yes-button " Toggle View " --no-button " Back " --scrolltext



exit 0
