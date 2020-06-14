# get_logwatch_conf.rb
# /etc/logwatch/conf/logwatch.conf -> ~/Templates/logwatch/logwatch.conf.erb

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
DST="/home/#{USER_NAME}/Templates/logwatch/"
SRC="/etc/logwatch/conf/"

directory DST do
  action :create
  owner USER_NAME
  group USER_NAME
end

template "#{DST}logwatch.conf.erb" do
  action :create
  mode "644"
  owner USER_NAME
  group USER_NAME
  source "#{SRC}logwatch.conf"
end
