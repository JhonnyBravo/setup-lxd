# get_mysql_cnf.rb
# /etc/mysql/mysql.cnf -> ~/Templates/mysql/mysql.cnf.erb

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
DST="/home/#{USER_NAME}/Templates/mysql/"
SRC="/etc/mysql/"

directory DST do
  action :create
  owner USER_NAME
  group USER_NAME
end

template "#{DST}mysql.cnf.erb" do
  action :create
  mode "644"
  owner USER_NAME
  group USER_NAME
  source "#{SRC}mysql.cnf"
end
