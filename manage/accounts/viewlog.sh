ttl="View Student Log"

students=`cat /etc/passwd|sed -n '/^.*:.*:.*:1006.*$/p'|cut -d ':' -f 1`
if [ -z "$students" ]; then

whiptail --msgbox --backtitle "$back_title"  --title "$ttl" "There are currently no student accounts in the system!" $msg_dim
exit 1

fi
fmt_st=`echo "$students"|tr '\n' '|'|sed 's/.$//'`
output=$(sudo ls -l --full-time /var/log/samba/|egrep "${fmt_st}"|sed 's/^.*\s.\s.*\s.*\s\s\s.*\s\(.*\)\s\(.*\)\..*\s.*\s.*\.\(.*\)/\1 \2    \3/g'|sort -r)
view="Listing by last log-in"

for user in $students; do
if [ -z `sudo ls /var/log/samba/|grep "log.$user"` ]; then
output="${output}\nno log-in    ${user}"
fi
done

whiptail --backtitle "$back_title"  --title "$ttl" --msgbox "${view},\n\n${output} " $chk_dim --scrolltext



exit 0
