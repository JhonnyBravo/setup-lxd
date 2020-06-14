# set_mysql_cnf.rb
# ~/Templates/mysql/mysql.cnf.erb -> /etc/mysql/mysql.cnf

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
SRC="/home/#{USER_NAME}/Templates/mysql/"
DST="/etc/mysql/"

template "#{DST}mysql.cnf" do
  action :create
  mode "644"
  source "#{SRC}mysql.cnf.erb"
end
