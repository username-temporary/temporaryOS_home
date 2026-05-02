#!/bin/bash
systemctl status openvpn-client@VPN.service |grep running >/dev/null
result=$?
#the reason this works is that if openvpn-VPN is running it will have running the name
#meaning that grep will have an exit code of 0, if it's not running running will not be in the output
#and thus grep will have an exit code of 1

if [ $result == 1 ] 
then
  echo '{"text":" vpn","class":"inactive"}'#vpn in off 
else 
  echo '{"text":" vpn","class":"active"}'#vpn is on 
fi  
