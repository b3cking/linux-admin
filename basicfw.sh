#!/bin/bash
#
# Flush all current rules from iptables
#
iptables -F
#
# Allow SSH connections on tcp port 37777 
#
iptables -A INPUT -p tcp --dport 37777 -j ACCEPT

#Apache input
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

#Postfix relay
iptables -A INPUT -p tcp --dport 25 -j ACCEPT

#
# Set default policies for INPUT, FORWARD and OUTPUT chains
#
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
#
# Set access for localhost
#
iptables -A INPUT -i lo -j ACCEPT
#
# Accept packets belonging to established and related connections
#
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#
# Save settings
#
/sbin/service iptables save
#
# List rules
#
iptables -L -v
