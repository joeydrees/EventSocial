class TweetsController < ApplicationController

	before_filter :authenticate_user!

	def index
		@user = current_user
		@events = Event.where(user_id: @user.id)
		@subscriptions = @user.subscriptions

		@event = Event.find(params[:event_id])
		@hashtag = Event.find(params[:event_id]).hashtag

		if @event.tweets_approved == true
			@search = Tweet.search(@hashtag, 10)
			@search.collect do |tweet|
				Tweet.get_tweet(tweet, @event)
			end
		end

    	@tweets = Tweet.where(event_id: @event.id, hashtag: @event.hashtag, approved: true).order("tweet_created_at DESC")
	end

	def destroy
		@event = Event.find(params[:event_id])
		@tweets = Tweet.where(event_id: @event.id)
		@tweet = Tweet.find(params[:id])
	    if @tweet.destroy
		    flash.now[:notice] = 'Tweet was sucessfully deleted.'
	        redirect_to event_tweets_path
		else
			flash[:alert] = 'There was an error deleting your tweet.'
	    	redirect_to event_tweets_path
	    end
	end

	private

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def tweet_params
	      params.require(:tweet).permit(:approved)
	    end
end