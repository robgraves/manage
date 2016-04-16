#!/bin/bash

#NOTE: This script isn't complete, justa placeholder for if implementing an elevate privileges script
# This script may be unnecessary if we end up using the addadmin.sh script in this directory instead for one stepadding of adminstrative level user.

##main command needed 
sudo usermod -a -G admin $username
