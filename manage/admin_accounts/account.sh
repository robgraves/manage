## Account Menu ##

echo $(whiptail --backtitle "$back_title" --title "Instructor Accounts" --menu "" $menu_dim "A" "Add Instructor" "D" "Remove Instructor" "W" "Remove All Instructors" "P" "Reset Instructor Password" "V" "Instructor listing" "L" "Instructor last log-in" "X" "Instructor disk usage" "Q" "Quit" --notags --ok-button " Select " --cancel-button " Back " 3>&1 1>&2 2>&3)

# Open a file descriptor(3) that points to stdout(1): 3>&1
# Now have stdout(1) point to stderr(2): 1>&2
# Whiptail will now write to screen output stderr(2)
# Finally, stderr(2) points to file descriptor(3) which points to stdout(1)
# Now the output of whiptail can be sent to a variable "foobar"
