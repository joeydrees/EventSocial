# Put Twitter OAuth credentials here

if Rails.env.developement?
	$twitter = Twitter::REST::Client.new do |config|
	  config.consumer_key = ENV["DEV_TWITTER_CONSUMER_KEY"]
	  config.consumer_secret = ENV["DEV_TWITTER_CONSUMER_SECRET"]
	  config.access_token = ENV["DEV_TWITTER_ACCESS_TOKEN"]
	  config.access_token_secret = ENV["DEV_TWITTER_ACCESS_TOKEN_SECRET"]
	end
elsif Rails.env.production?
	$twitter = Twitter::REST::Client.new do |config|
	  config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
	  config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
	  config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
	  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
	end
end