#!/bin/bash


# Storyline: Create peer VPN configuration file


if [[ $1 == "" ]]
then

	# What is peer's name
	echo -n "What is the peer's name? "
	read the_client
       	
else

	the_client="$1"

fi


# Filename variable
pFile="${the_client}-wg0.conf"

echo "${pFile}"

# Check if the peer file exists
if [[ -f "${pFile}" ]]
then

	# Prompt if we need to overwrite the file
	echo "The file ${pFile} exists."
	echo -n "Do you want to overwrite it? [y|n] "
	read to_overwrite

	if [[ "${to_overwrite}" == "n" || "${to_overwrite}" == "" ]]
	then
		echo "Exit..."
		exit 0

	elif [[ "${to_overwrite}" == "y" ]]
	then

		echo "Creating the wireguard configuration file..."

	# If the admin doesn't specify a y or N then error.

	else
		echo "Invalid value"
		exit 1

	fi
fi

# Generate private key
p="$(wg genkey)"


# Generate a public key
clientPub="$(echo ${p} | wg pubkey)"


# Generate a prehared key
pre="$(wg genpsk)"


# Endpoint
end="$(head -1 wg0.conf | awk ' { print $3 } ')"


# Server Public Key
pub="$(head -1 wg0.conf | awk ' { print $4 } ')"



# DNS Servers
dns="$(head -1 wg0.conf | awk ' { print $5 } ')"


# MTU
mtu="$(head -1 wg0.conf | awk ' { print $6 } ')"



# KeepAlive

keep="$(head -1 wg0.conf | awk ' { print $7 } ')"

# ListenPort
lport="$(shuf -n1 -i 40000-50000)"

# Default routes for VPN
routes="$(head -1 wg0.conf | awk ' { print $8 } ')"

# Generate the IP address 
tempIP=$(grep AllowedIPs wg0.conf | sort -u | tail -1 | cut -d\. -f4 | cut -d\/ -f1)
ip=$(expr ${tempIP} + 1)

# Create the client configuration file

echo "[Interface]
Address = 10.254.132.${ip}/24
DNS = ${dns}
ListenPort = ${lport}
MTU = ${mtu}
PrivateKey = ${p}


[Peer]
AllowedIPs = ${routes}
PersistentKeepalive = ${keep}
PresharedKey = ${pre}
PublicKey = ${pub}
Endpoint = ${end}
" > ${pFile}

# Add our peer onfiguration to the server config
echo "

# ${the_client} begin
[Peer]
Publickey = ${clientPub}
PresharedKey = ${pre}
AllowedIPs = 10.254.132.${ip}/24
# ${the_client} end" | tee -a wg0.conf












