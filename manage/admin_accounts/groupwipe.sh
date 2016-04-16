#!/bin/bash

students=`cat /etc/passwd | grep 1006 | cut -d ":" -f1`
for s in $students; do sudo deluser --remove-home $s; done

exit 0
