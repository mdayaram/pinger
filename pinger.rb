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
  res = clnt.get_content("https://api.heroku.com/apps", {}, extheader)
  if res.status.successful?
    parsed = json.parse(res.body)
    s = []
    parsed.each do |p|
      s << "#{p["name"]}.herokuapp.com"
    end
  end
end

loop do
  sites.each do |s|
    res = HTTPClient.get("http://#{s}")
    puts "* Pinged #{s} .......... #{res.status_code}"
  end
  puts "Done, sleeping for #{sleep_time}s...."
  sleep sleep_time
  puts "Waking up!"
end
