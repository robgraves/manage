ttl="View Instructor Log"

students=`cat /etc/passwd|sed -n '/^.*:.*:.*:1007.*$/p'|cut -d ':' -f 1`
if [ -z "$students" ]; then

whiptail --msgbox --backtitle "$back_title"  --title "$ttl" "There are currently no instructor accounts in the system!" $msg_dim
exit 1

fi
fmt_st=`echo "$students"|tr '\n' '|'|sed 's/.$//'`
output=$(sudo ls -l --time=ctime /var/log/samba/|egrep "${students}"|sed 's/^.* . .* .*\s*. \(.* .* .*\) log\.\(.*\)/\1    \2/g'|sort -r)
view="Listing by last log-in"

whiptail --backtitle "$back_title"  --title "$ttl" --msgbox "${view},\n\n${output} " $chk_dim --scrolltext



exit 0
