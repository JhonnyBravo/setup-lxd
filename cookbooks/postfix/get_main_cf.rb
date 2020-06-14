# get_main_cf.rb
# /etc/postfix/main.cf -> ~/Templates/postfix/main.cf.erb

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
DST="/home/#{USER_NAME}/Templates/postfix/"
SRC="/etc/postfix/"

directory DST do
  action :create
  owner USER_NAME
  group USER_NAME
end

template "#{DST}main.cf.erb" do
  action :create
  mode "644"
  owner USER_NAME
  group USER_NAME
  source "#{SRC}main.cf"
end
