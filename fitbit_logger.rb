require "fitgem"

consumer_key = ENV['FITBIT_CONSUMER_KEY']
consumer_secret = ENV['FITBIT_CONSUMER_SECRET']
access_token = ENV['FITBIT_ACCESS_TOKEN']
secret = ENV['FITBIT_SECRET']
user_id = ENV['FITBIT_USER_ID']

oauth = {:consumer_key => consumer_key,
         :consumer_secret => consumer_secret,
         :token => access_token,
         :secret => secret,
         :user_id => user_id,
         :ssl => true}

client = Fitgem::Client.new(oauth)

date = ARGV[0]
result = client.activities_on_date(date)
result["date"] = date
puts result.to_json
