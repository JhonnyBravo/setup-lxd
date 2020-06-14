# get_sasl_passwd.rb
# /etc/postfix/sasl_passwd -> ~/Templates/postfix/sasl_passwd.erb

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

template "#{DST}sasl_passwd.erb" do
  action :create
  mode "644"
  owner USER_NAME
  group USER_NAME
  source "#{SRC}sasl_passwd"
end
