#!/bin/bash

script_name=$(basename "$0")

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} [-h]

DESCRIPTION
  ロケールとタイムゾーンを設定します。

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

update-locale LANG=ja_JP.UTF8
dpkg-reconfigure tzdata
