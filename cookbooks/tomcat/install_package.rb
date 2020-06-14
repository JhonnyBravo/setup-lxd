# openjdk-11-jdk, tomcat9 のインストール
%w(openjdk-11-jdk tomcat9).each do |pkg|
  package pkg do
    action :install
  end
end
