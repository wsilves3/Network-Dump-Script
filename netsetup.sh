# netsetup.sh
# 11/06/2021
# Wendy Silvestre
# !/bin/bash

## files ##
DNSCLIENT="/etc/resolv.conf"
 
## An Output file to write Network Congiguraion ##
NETSETUPFILE="network_setup.$(date +'%m-%d-%y').txt"
 
# Function to write a title for every command 
title(){
	echo "-------------------------------------------------------------------------------------" >> $NETSETUPFILE
	echo "$@" >> $NETSETUPFILE
	echo "-------------------------------------------------------------------------------------" >> $NETSETUPFILE
}

net_info(){

	# Create Network_Setup File
	touch NETSETUPFILE

	# Title for report
	title "NETWORK CONFIGURATION REPORT"

	# Reporting Host Name & Report Date
	echo "* Hostname: $(hostname)" >>$NETSETUPFILE
	echo "* Date: $(date)" >>$NETSETUPFILE
 
	# Reporting Network Interfaces Information : Using ip address command
	title "Network Interfaces"
	ip address >> $NETSETUPFILE
 
	# Reporting Routing Table : Using ip route command
	title "Routing Table"
	ip route >> $NETSETUPFILE
 
	# Reporting DNS Configuration: Display /etc/resolv.conf file
	title "DNS Client $DNSCLIENT Configuration"
	[ -f $DNSCLIENT ] && cat $DNSCLIENT || echo "Error $DNSCLIENT file not found."
	[ -f $DNSCLIENT ] && cat $DNSCLIENT >> $NETSETUPFILE || echo "Error $DNSCLIENT file not found." >> $NETSETUPFILE
 
	# Reporting Ports and Connection Status
	title "Ports & Connections Status"
	netstat -a -n >> $NETSETUPFILE

	# Displaying report 
  	cat $NETSETUPFILE | more
	echo "Network Configuration File was created: $NETSETUPFILE"
}
 
net_info
