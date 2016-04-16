## Account Menu ##

echo $(whiptail --backtitle "$back_title" --title "Account Menu" --menu "" $menu_dim "A" "Add A User" "D" "Remove A User" "W" "Remove All Users" "V" "View Users" "X" "Disk Usage" "Q" "Quit" --notags --ok-button " Select " --cancel-button " Back " 3>&1 1>&2 2>&3)

# Open a file descriptor(3) that points to stdout(1): 3>&1
# Now have stdout(1) point to stderr(2): 1>&2
# Whiptail will now write to screen output stderr(2)
# Finally, stderr(2) points to file descriptor(3) which points to stdout(1)
# Now the output of whiptail can be sent to a variable "foobar"
