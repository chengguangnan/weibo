require "net/telnet"
require "json"

firefox = Net::Telnet::new("Host" => "localhost", "Port" => 32000, "Prompt" => /\n/)


URL = "http://weibo.com/p/YOUR_SINA_WEIBO_ID/"

# how many pages you have
1.upto(100) do |i|
  warn i
  firefox.cmd(%Q|document.location = '#{URL}myfollow?t=1&cfs=&Pl_Official_RelationMyfollow__111_page=#{i}'|)
  sleep 30
  result = firefox.cmd(%Q|urls = []; followed = document.querySelectorAll('a[usercard]'); for (var i = 0; i < followed.length; i++) { urls.push(followed[i].href) }; urls;|)
  links = JSON[result]["result"]
  links.each {|link| puts link }
end
