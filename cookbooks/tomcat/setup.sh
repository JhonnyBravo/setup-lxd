#!/bin/bash

script_name=$(basename "$0")

myhost=''
trusthost=''
container=''

n_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} [-n] [-h]

DESCRIPTION
  ホストマシンから lxd コンテナへのポート転送を設定します。

OPTIONS
  -n  ホストマシンから lxd コンテナへのポート転送を設定します。
  -h  ヘルプを表示します。
_EOT_
exit 1
}

while getopts "nh" option
do
  case $option in
    n)
      n_flag=1
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

if [ $n_flag -eq 1 ]; then
  iptables -A INPUT -p tcp --syn -m state --state NEW -s $trusthost -d $myhost --dport 8080 -j ACCEPT
  iptables -t nat -A PREROUTING -d $myhost -p tcp -m tcp --dport 8080 -j DNAT --to-destination ${container}:8080
fi
