#!/bin/bash

# Storyline: Script to parse IPs and domain and create rulesets for IPtables and Cisco

function invalid_opt() {
	clear
	echo "Invalid Operation"
	sleep 2
	menu
}

function menu() {
	# clears the screen
	clear

	echo "[1] Emerging Threats Ruleset for Iptables"
	echo "[2] Targeted Threats Ruleset for Cisco"
	echo "[3] Exit"
	read -p "Please select an option: " choice

	case "$choice" in

		1) emerging_threats
		;;
		2) targeted_threats
		;;
		3) exit 0
		;;
		*)
			invalid_opt
		;;

	esac

}


function emerging_threats() {

if [[ -f /tmp/emerging-drop.rules ]]
then
	echo "The emerging rules files is already downloaded."
	echo -n "Do you want to download again? [y|n]"
	read to_overwrite

	if [[ "${to_overwrite}" == "n" || "${to_overwrite}" == "" ]]
	then
		echo "Okay, will use existing emerging rules file. I'm going to sort the information into badIPs.txt. "
		egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0/[0-9]{1,2}' /tmp/emerging-drop.rules | sort -u | tee badIPs.txt
		echo "Creating iptables ruleset for IP's in badIPs.txt..."
		for eachIP in $(cat badIPs.txt)
		do
			echo "iptables -A INPUT -s ${eachIP} -j DROP" | tee -a badIPS.iptables
			echo "Ruleset created @ badIPS.iptables"
			cat badIPS.iptables |less
			break
		done
	elif [[ "${to_overwrite}" == "y" ]]
	then
		echo "Downloading emerging rules file to /tmp/emerging-drop.rules and sorting into BadIPs.txt"
		egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0/[0-9]{1,2}' /tmp/emerging-drop.rules | sort -u | tee badIPs.txt
		for eachIP in $(cat badIPs.txt)
		do
			echo "iptables -A INPUT -s ${eachIP} -j DROP" | tee -a badIPS.iptables
			echo "Ruleset created @ badIPS.iptables"
			cat badIPS.iptables |less
			break
		done
	else
		echo "Invalid Value"
		exit 1
	fi
fi
menu
}

function targeted_threats() {
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
		exit 1
	fi
#elif
#then
#	echo "Couldn't locate existing targetedthreats.csv file. Will download now..."
#	wget https://raw.githubusercontent.com/botherder/targetedthreats/master/targetedthreats.csv
#	sleep 2
#	echo "Okay, will use existing targeted threats file. I'm going to sort by domains into badDomains.txt."
#	egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0/[0-9]{1,2}' /tmp/targetedthreats.csv | sort -u | tee badDomains.txt
#	echo "Creating cisco ruleset for domain's in badDomains.txt..."
#	for eachDomain in $(cat badDomains.txt)
#	do
#		echo "match protocol http host ${eachDomain}" | tee -a badDomains.cisco
#		echo "Cisco Ruleset created at badDomains.cisco"
#		cat badDomains.cisco
#		break
#	done
fi

menu
}



menu
