# set_logwatch_conf.rb
# ~/Templates/logwatch/logwatch.conf.erb -> /etc/logwatch/conf/logwatch.conf

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
SRC="/home/#{USER_NAME}/Templates/logwatch/"
DST="/etc/logwatch/conf/"

template "#{DST}logwatch.conf" do
  action :create
  mode "644"
  source "#{SRC}logwatch.conf.erb"
end
