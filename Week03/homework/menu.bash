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
	echo "[3] Exit"
	read -p "Please enter a choice above: " choice

	case "$choice" in
	
		1) admin_menu
		;;

		2) security_menu
		;;

		3) exit 0
		;;

		*)
			invalaid_opt
			
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
			bash manage-users.bash -d -u $user |less
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
# Call the main function
menu
















