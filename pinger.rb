require 'rubygems'
require 'httpclient'
require 'syslog'

sleep_time = 55 * 60  # 55 minutes

sites = [
  "http://noj.cc",
  "http://i.hazasite.com",
  "http://organs.hazasite.com",
  "http://steroids.hazasite.com",
  ]

def puts(message)
  Syslog.open($0, Syslog::LOG_PID | Syslog::LOG_CONS) do |s| 
    s.info message
  end
end

Process.fork() {

  Process.setsid
  raise 'Second fork failed' if (pid = Process.fork()) == -1
  exit unless pid.nil?

  File.umask 0000
  STDIN.reopen '/dev/null'
  STDOUT.reopen '/dev/null', 'a'
  STDERR.reopen '/dev/null', 'a'

  loop do
    sites.each do |s|
      puts "* Pinging #{s} .........."
      res = HTTPClient.get(s)
      puts "+++ #{res.status_code}"
    end
    puts "Done, sleeping for #{sleep_time}s...."
    sleep sleep_time
    puts "Waking up!"
  end
}
