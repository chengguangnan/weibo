require "net/telnet"

firefox = Net::Telnet::new("Host" => "localhost", "Port" => 32000, "Prompt" => /\n/)

159.downto(1) do |i|
  puts firefox.cmd("document.location = 'http://weibo.com/comment/outbox?page=#{i}'")
  sleep 3

  (1..30).each do
    result = firefox.cmd(%Q|document.querySelector('a[action-type="delComment"]').click();|)

    if result =~ /error/
      break
    end
    sleep 0.5
    firefox.cmd(%Q|document.querySelector('a[action-type="ok"]').click();|)
    sleep 1
  end
end
