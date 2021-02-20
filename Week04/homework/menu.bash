#!/bin/bash

# Storyline: Menu for admin, VPN, and Security functions

function invalid_opt() {
	echo ""
	echo "Invalid option"
	echo ""
	sleep 2

}	
function menu() {

	# clears the screen
	clear
	
	echo "[1] Admin Menu"
	echo "[2] Security Menu"
	echo "[3] Block List Menu"
	echo "[4] Exit"
	read -p "Please enter a choice above: " choice

	case "$choice" in
	
		1) admin_menu
		;;

		2) security_menu
		;;

		3) block_menu
		;;
		4) exit 0 	
		;;
		*)
			invalid_opt
			
			# Call the main menu
			menu
		;;

	esac

}

function admin_menu() {

	clear
	echo "[L]ist Running Processes"
	echo "[N]etwork Sockets"
	echo "[V]PN Menu"
	echo "[4] Exit"
	read -p "Please enter a choice above: " choice
	
	case "$choice" in

		L) ps -ef |less
			
		;;

		N) netstat -an --inet |less
		;;

		V) vpn_menu
		;;

		4) exit 0
		;;
		
		*)
			invalid_opt

			admin_menu
		;;

	esac

admin_menu
} 
																														function vpn_menu() {
	clear
	echo "[A]dd a peer"
	echo "[D]elete a peer"
	echo "[B]ack to admin menu"
	echo "[M]ain menu"
	echo "[E]xit"
	read -p "Please select an option: " choice

	case "$choice" in

		A) bash peer.bash  
		;;
		D) 
			read -p "Which VPN user do you want to delete?: " user
			bash manage-users.bash -d -u $user 
			rm "$user-wg0.conf"
			echo "VPN User file and configuration successfully removed"
		;;
		B) admin_menu
		;;
		M) menu
		;;
		E) exit 0
		;;
		*)
			invalid_opt
			vpn
		;;
		
		esac



}
function security_menu() {

	clear
	echo "Security Menu"
	echo ""
	echo "[1] Check currently logged in users"
	echo "[2] Check last 10 logged in users"
	echo "[3] Check users and their UID's"
	echo "[4] Main menu"
	echo "[5] Exit"
	read -p "Please select an option: " choice

	case "$choice" in

		1) ps au |less
		;;
		2) last |less
		;;
		3) cut -d: -f1,3 /etc/passwd |less
		;;
		4) menu
		;;
		5) exit 0
		;;
		*)
			invalid_opt
			security_menu

		;;

	esac




security_menu
}
function block_menu() {
	clear
	echo "[C]isco blocklist generator"
	echo "[D]omain URL blocklist generator"
	echo "[N]etscreen blocklist generator"
	echo "[W]indows blocklist generator"
	echo "[M]ain menu"
	echo "[E]xit"
	read -p "Please select an option: " choice

	case "$choice" in

		C) targeted_cisco
		;;
		D)
		;;
		N)
		;;
		W)
		;;
		M) menu
		;;
		E) exit 0
		;;


	esac

block_menu
}

function targeted_cisco() {

if [[ -f /tmp/targetedthreats.csv ]]
then
	echo "The targeted threats file is already downloaded."
	echo -n "Do you want to download again?"
	read to_overwrite

	if [[ "${to_overwrite}" == "n" || "${to_overwrite}" == "" ]]
	then
		echo "Okay, will use existing targeted threats file. I'm going to sort by domains into badDomains.txt."
		egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0/[0-9]{1,2}' /tmp/targetedthreats.csv | sort -u | tee badDomains.txt
		echo "Creating cisco ruleset for domain's in badDomains.txt..."
		for eachDomain in $(cat badDomains.txt)
		do
			echo "match protocol http host ${eachDomain}" | tee -a badDomains.cisco
			echo "Cisco Ruleset created at badDomains.cisco"
			cat badDomains.cisco
			break
		done
	elif [[ "${to_overwrite}" == "y" ]]
	then
		echo "Downloading emerging rules file to /tmp/targetedthreats.csv and sorting into BadDomains.txt"
		wget https://raw.githubusercontent.com/botherder/targetedthreats/master/targetedthreats.csv -P /tmp/targetedthreats.csv
		egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0/[0-9]{1,2}' /tmp/targetedthreats.csv | sort -u | tee badDomains.txt
		for eachDomain in $(cat badDomains.txt)
		do
			echo "match protocol http host ${eachDomain}" | tee -a badDomains.cisco
			echo "Cisco Ruleset created at badDomains.cisco"
			cat badDomains.cisco
			break
		done
	else
		echo "Invalid Value"
		exit 0
	fi
fi


}
# Call the main function
menu
















