# set_sasl_passwd.rb
# ~/Templates/postfix/sasl_passwd.erb -> /etc/postfix/sasl_passwd

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
SRC="/home/#{USER_NAME}/Templates/postfix/"
DST="/etc/postfix/"

template "#{DST}sasl_passwd" do
  action :create
  mode "644"
  source "#{SRC}sasl_passwd.erb"
end
