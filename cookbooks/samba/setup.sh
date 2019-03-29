#!/bin/bash

script_name=$(basename "$0")

myhost=''
trusthost=''
container=''

nmbd_trusthost="${myhost:0:11}255"
nmbd_container="${container:0:11}255"

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} [-h]

DESCRIPTION
  ホストマシンから lxd コンテナへのポート転送を設定します。

OPTIONS
  -h  ヘルプを表示します。
_EOT_
exit 1
}

while getopts "h" option
do
  case $option in
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

# Microsoft-DS SMB file sharing
iptables -A INPUT -p tcp --syn -m state --state NEW -s $trusthost -d $myhost --dport 445 -j ACCEPT
iptables -t nat -A PREROUTING -d $myhost -p tcp -m tcp --dport 445 -j DNAT --to-destination ${container}:445

# NetBIOS Session Service
iptables -A INPUT -p tcp --syn -m state --state NEW -s $trusthost -d $myhost --dport 139 -j ACCEPT
iptables -t nat -A PREROUTING -d $myhost -p tcp -m tcp --dport 139 -j DNAT --to-destination ${container}:139

# NetBIOS Name Service
iptables -A INPUT -p udp -d $nmbd_trusthost --sport 137 --dport 137 -j ACCEPT
iptables -t nat -A PREROUTING -d $nmbd_trusthost -p udp --sport 137 --dport 137 -j DNAT --to-destination ${nmbd_container}:137

# NetBIOS Datagram Service
iptables -A INPUT -p udp -d $nmbd_trusthost --sport 138 --dport 138 -j ACCEPT
iptables -t nat -A PREROUTING -d $nmbd_trusthost -p udp --sport 138 --dport 138 -j DNAT --to-destination ${nmbd_container}:138
