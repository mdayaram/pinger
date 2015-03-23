require 'rubygems'
require 'httpclient'
require 'syslog'
require 'json'

sleep_time = 55 * 60  # 55 minutes

def sites
  extheader = {
    "Accept" => "application/vnd.heroku+json; version=3",
    "Authorization" => "Bearer #{ENV["AUTH_TOKEN"]}"
  }

  clnt = HTTPClient.new
  clnt.ssl_config.ssl_version = :TLSv1
  res = clnt.get("https://api.heroku.com/apps", {}, extheader)
  s = []
  if HTTP::Status.successful? res.status
    parsed = JSON.parse(res.body)
    parsed.each do |p|
      s << "#{p["name"]}.herokuapp.com"
    end
  else
    puts "ERROR STATUS: #{res.status}"
    puts "ERROR BODY:\n"
    puts res.body
  end
  s
end

loop do
  sites.each do |s|
    res = HTTPClient.get("http://#{s}")
    puts "* Pinged #{s} ........ #{res.status_code}"
  end
  puts "Done, sleeping for #{sleep_time}s...."
  sleep sleep_time
  puts "Waking up!"
end
