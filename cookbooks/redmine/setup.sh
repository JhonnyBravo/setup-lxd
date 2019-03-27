#!/bin/bash

script_name=$(basename "$0")

package="apache2 libapache2-mod-passenger mysql-server mysql-client redmine redmine-mysql"

myhost=''
trusthost=''
container=''

i_flag=0
u_flag=0
n_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} [-i] [-u] [-n] [-h]

DESCRIPTION
  Redmine をインストール / アンインストールします。

OPTIONS
  -i  Redmine をインストールします。
  -u  Redmine をアンインストールします。
  -n  ホストマシンから lxd コンテナへのポート転送を設定します。
  -h  ヘルプを表示します。
_EOT_
exit 1
}

while getopts "iunh" option
do
  case $option in
    i)
      i_flag=1
      ;;
    u)
      u_flag=1
      ;;
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

if [ $i_flag -eq 1 ]; then
  apt-get install ${package}
elif [ $u_flag -eq 1 ]; then
  apt-get purge ${package}
elif [ $n_flag -eq 1 ]; then
  iptables -A INPUT -p tcp --syn -m state --state NEW -s $trusthost -d $myhost --dport 8000 -j ACCEPT
  iptables -t nat -A PREROUTING -d $myhost -p tcp -m tcp --dport 8000 -j DNAT --to-destination ${container}:8000
fi
