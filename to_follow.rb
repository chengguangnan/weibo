require "net/telnet"
require "json"

firefox = Net::Telnet::new("Host" => "localhost", "Port" => 32000, "Prompt" => /\n/)

STDIN.each do |line|
  puts line
  firefox.cmd(%Q|document.location = '#{line.strip}'|)
  sleep 10
  puts firefox.cmd(%Q|document.querySelector('.PCD_header a[action-type="follow"]').click()|)
  sleep 10
end
