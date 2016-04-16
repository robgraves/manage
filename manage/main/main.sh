## Main Menu ##

echo $(whiptail --backtitle "$back_title" --title "Main Menu" --menu "Welcome, $USER" $menu_dim "A" "Student Accounts" "I" "Instructor Accounts" "R" "Restart Services" "B" "Reboot Server" "?" "Info" "C" "Credits" "Q" "Quit" --notags --nocancel --ok-button " Select " 3>&1 1>&2 2>&3)

# Open a file descriptor(3) that points to stdout(1): 3>&1
# Now have stdout(1) point to stderr(2): 1>&2
# Whiptail will now write to screen output stderr(2)
# Finally, stderr(2) points to file descriptor(3) which points to stdout(1)
# Now the output of whiptail can be sent to a variable "foobar"
