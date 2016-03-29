class TweetsController < ApplicationController

	before_filter :authenticate_user!

	def index
		@user = current_user
		@events = Event.where(user_id: @user.id)
		@subscriptions = @user.subscriptions

		@event = Event.find(params[:event_id])
		@hashtag = Event.find(params[:event_id]).hashtag

		@search = Tweet.search(@hashtag, 10)
		@search.collect do |tweet|
			Tweet.get_tweet(tweet, @event)
		end

    	@tweets = Tweet.where(event_id: @event.id).reverse

    	@tweetsArray ||= Array.new 
    	@tweets.each do |tweet|
  			@tweetsArray.push("<blockquote class=\"twitter-tweet\" data-lang=\"en\">
  							   <p lang=\"en\" dir=\"ltr\"><p>#{tweet.text}</p>&mdash; #{tweet.name} (@#{tweet.username}) 
  							   <a href=\"https://twitter.com/#{tweet.username}/status/#{tweet.id_str}\"></a>
  							   </blockquote>".html_safe)
        end
	end
end