#! /bin/bash

# Globals
export back_title="Server Manager 2016"
export menu_dim="25 30 10"
export msg_dim="8 80"
export inp_dim="10 60"
export yn_dim="10 60"
export chk_dim="25 45 10"
export bar_dim="6 60 0"
export view_dim="25 45"
export full_path="/home/$USER/src/devel/manage/"	##Tyler and new Matt path
#export full_path="/home/$USER/devel/manage/"		##Matt's version of path
#export full_path="/home/$USER/manage/"     		##Barb version of path

#sudo chgrp -R admin /home/* 1>/dev/null
function manage(){

	#initialize

option="Go!"
while [ "$option" != "Q" ]; do
	
	main
	if	[ "$option" == "A" ]; then
		while true
		do
					accounts
			if [ "$option" == "A" ]; then
						adduser

			elif [ "$option" == "D" ]; then
						deluser		
			
			elif [ "$option" == "W" ]; then
						delusers

			elif [ "$option" == "V" ]; then
						viewusers	
			
			elif [ "$option" == "X" ]; then
						diskusage	
			
			elif [ "$option" == "L" ]; then
						viewlog	

			fi	
			
			[[ -z "$option" ]] && break
			[[ "$option" == "Q" ]] && exit 1
		done

	elif	[ "$option" == "I" ]; then
		while true
		do
					admin_accounts
			if [ "$option" == "A" ]; then
						admin_adduser

			elif [ "$option" == "D" ]; then
						admin_deluser		
			
			elif [ "$option" == "W" ]; then
						admin_delusers

			elif [ "$option" == "V" ]; then
						admin_viewusers	
			
			elif [ "$option" == "X" ]; then
						admin_diskusage	

			elif [ "$option" == "L" ]; then
						admin_viewlog	

			fi	
			
			[[ -z "$option" ]] && break
			[[ "$option" == "Q" ]] && exit 1
		done

	elif	[ "$option" == "S" ]; then
		while true
		do
			
					system	
			if	[ "$option" == "R" ]; then
					smb_restart
	
			elif	[ "$option" == "B" ]; then
					reboot
					[[ "$?" -eq 0 ]] && break	
			fi	
			
			[[ -z "$option" ]] && break
			[[ "$option" == "Q" ]] && exit 1
		done

	elif	[ "$option" == "?" ]; then
					info
	fi
done

return 0

}

## Main Menu

function main(){
eval option=`bash "${full_path}main/main.sh"`
}

## Initializing
function initialize(){
	bash "${full_path}init/loading.sh"
}

## Student Accounts

function accounts(){
eval option=`bash "${full_path}accounts/account.sh"`
}

function adduser(){
bash "${full_path}accounts/adduser.sh"
}

function addadmin(){
bash "${full_path}accounts/addadmin.sh"
}

function deluser(){
bash "${full_path}accounts/deluser.sh"
}

function delusers(){
bash "${full_path}accounts/delusers.sh"
}

function viewusers(){
bash "${full_path}accounts/viewusers.sh"
}

function diskusage(){
bash "${full_path}accounts/diskusage.sh"
}

function viewlog(){
bash "${full_path}accounts/viewlog.sh"
}

## Instructor Accounts

function admin_accounts(){
eval option=`bash "${full_path}admin_accounts/account.sh"`
}

function admin_adduser(){
bash "${full_path}admin_accounts/adduser.sh"
}

function admin_addadmin(){
bash "${full_path}admin_accounts/addadmin.sh"
}

function admin_deluser(){
bash "${full_path}admin_accounts/deluser.sh"
}

function admin_delusers(){
bash "${full_path}admin_accounts/delusers.sh"
}

function admin_viewusers(){
bash "${full_path}admin_accounts/viewusers.sh"
}

function admin_diskusage(){
bash "${full_path}admin_accounts/diskusage.sh"
}

function admin_viewlog(){
bash "${full_path}admin_accounts/viewlog.sh"
}

## System Menu

function system(){
eval option=`bash "${full_path}system/system.sh"`
}

function smb_restart(){
bash "${full_path}system/sambarestart.sh"
}

function reboot(){
bash "${full_path}system/reboot.sh"
return $?
}

function info(){
bash "${full_path}main/info.sh"
}

# RUN!
manage
