require 'rubygems'
require 'httpclient'
require 'syslog'

require './consts'

sleep_time = 55 * 60  # 55 minutes

sites = [
  "http://nojcc.herokuapp.com",
  "http://ihazasite.herokuapp.com",
  "http://wiseley-organs.herokuapp.com",
  "http://wiseley-steroids.herokuapp.com",
  "http://headerecho.herokuapp.com",
  "http://phoenix-tech.herokuapp.com",
]

loop do
  if File.exists? DEATH_FILE
    puts "Found death file, killing myself..."
    File.delete DEATH_FILE
    exit 0
  end

  sites.each do |s|
    res = HTTPClient.get(s)
    puts "* Pinged #{s} .......... #{res.status_code}"
  end
  puts "Done, sleeping for #{sleep_time}s...."
  sleep sleep_time
  puts "Waking up!"
end
