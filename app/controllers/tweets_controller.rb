class TweetsController < ApplicationController

	before_filter :authenticate_user!

	def index
		@search = Tweet.search("EventSocial2016", 10)

		@search.collect do |tweet|
			Tweet.get_tweet(tweet)
		end

    	@tweets = Tweet.all.reverse

    	@tweetsArray ||= Array.new 
    	@tweets.each do |tweet|
  			@tweetsArray.push("<blockquote class=\"twitter-tweet\" data-lang=\"en\">
  							   <p lang=\"en\" dir=\"ltr\"><p>#{tweet.text}</p>&mdash; #{tweet.name} (@#{tweet.username}) 
  							   <a href=\"https://twitter.com/#{tweet.username}/status/#{tweet.id_str}\"></a>
  							   </blockquote>".html_safe)
        end
	end
	
end