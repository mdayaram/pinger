require 'rubygems'
require 'httpclient'
require 'syslog'

require './consts'

sleep_time = 55 * 60  # 55 minutes

sites = File.open(File.join(File.expand_path(File.dirname(__FILE__)), "sites.dat")).read.split

loop do
  if File.exists? DEATH_FILE
    puts "Found death file, killing myself..."
    File.delete DEATH_FILE
    exit 0
  end

  sites.each do |s|
    res = HTTPClient.get("http://#{s}")
    puts "* Pinged #{s} .......... #{res.status_code}"
  end
  puts "Done, sleeping for #{sleep_time}s...."
  sleep sleep_time
  puts "Waking up!"
end
