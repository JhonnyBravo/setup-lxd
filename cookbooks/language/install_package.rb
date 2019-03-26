# language-pack-ja, manpages-ja, manpages-ja-dev のインストール
%w(language-pack-ja manpages-ja manpages-ja-dev).each do |pkg|
  package pkg do
    action :install
  end
end
