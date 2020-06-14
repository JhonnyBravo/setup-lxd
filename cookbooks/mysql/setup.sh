#!/bin/bash

script_name=$(basename "$0")

package="mysql-server mysql-client"

i_flag=0
u_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} [-i] [-u] [-h]

DESCRIPTION
  MySQL をインストール / アンインストールします。

OPTIONS
  -i  MySQL をインストールします。
  -u  MySQL をアンインストールします。
  -h  ヘルプを表示します。
_EOT_
exit 1
}

while getopts "iuh" option
do
  case $option in
    i)
      i_flag=1
      ;;
    u)
      u_flag=1
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
  mysql_secure_installation
elif [ $u_flag -eq 1 ]; then
  apt-get purge ${package}
fi
