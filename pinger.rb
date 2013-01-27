require 'rubygems'
require 'httpclient'
require 'syslog'

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
    sites.each do |s|
      puts "* Pinging #{s} .........."
      res = HTTPClient.get(s)
      puts "+++ #{res.status_code}"
    end
    puts "Done, sleeping for #{sleep_time}s...."
    sleep sleep_time
    puts "Waking up!"
  end
