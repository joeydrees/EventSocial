class ManageEventsController < ApplicationController

	def index
		@user = current_user
		@events = Event.where(user_id: @user.id)
		@event = Event.find(params[:event_id])
		@hashtag = Event.find(params[:event_id]).hashtag

		if @event.tweets_approved == false
			@search = Tweet.search(@hashtag, 10)
			@search.collect do |tweet|
				Tweet.get_tweet(tweet, @event)
			end
		end

		@tweets = Tweet.where(event_id: @event.id, hashtag: @event.hashtag, approved: false).order("tweet_created_at DESC")

		@comments = Comment.where(event_id: @event.id)
	end

	def update
	    @tweet = Tweet.find(params[:id])
	    if @tweet.update_attribute(:approved, "true")
	    	flash[:notice] = "Tweet was successfully approved."
	      	redirect_to event_manage_events_path
	    else
	      	flash[:alert] = "There was an error approving the tweet."
	      	redirect_to event_manage_events_path
	    end
  	end

	def destroy
		@event = Event.find(params[:event_id])
		@tweets = Tweet.where(event_id: @event.id)
		@tweet = Tweet.find(params[:id])
	    if @tweet.destroy
		    flash.now[:notice] = 'Tweet was sucessfully deleted.'
	        redirect_to event_manage_events_path
		else
			flash[:alert] = 'There was an error deleting your tweet.'
	    	redirect_to event_manage_events_path
	    end
	    if @event.destroy
	    	flash.now[:notice] = 'Event was sucessfully deleted.'
	        redirect_to event_manage_events_path
		else
			flash[:alert] = 'There was an error deleting your event.'
	    	redirect_to event_manage_events_path
	    end
	end
	
end