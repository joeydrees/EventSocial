class TweetsController < ApplicationController

	before_filter :authenticate_user!

	def index
		@search = $twitter.search("#EventSocial2016 -filter:retweets", lang: "en").take(10)

		@search.collect do |s|
			if !Tweet.find_by_id_str(s.id).present?
    			Tweet.create do |t|
    		  		t.name =  s.user.name
    				t.username = s.user.screen_name
    				t.text = s.text
    				t.id_str = s.id
    			end
    		end
    	end

    	@tweets = Tweet.all.reverse

    	@tweetsArray ||= Array.new 
    	@tweets.each do |tweet|
  			@tweetsArray.push("<blockquote class=\"twitter-tweet\" data-lang=\"en\"><p lang=\"en\" dir=\"ltr\"><p>#{tweet.text}</p>&mdash; #{tweet.name} (@#{tweet.username}) <a href=\"https://twitter.com/#{tweet.username}/status/#{tweet.id_str}\"></a></blockquote>".html_safe)
        end
	end
	
end