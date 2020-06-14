# set_main_cf.rb
# ~/Templates/postfix/main.cf.erb -> /etc/postfix/main.cf

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
SRC="/home/#{USER_NAME}/Templates/postfix/"
DST="/etc/postfix/"

template "#{DST}main.cf" do
  action :create
  mode "644"
  source "#{SRC}main.cf.erb"
end
