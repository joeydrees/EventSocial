class ManageEventsController < ApplicationController

	def index
		@user = current_user
		@events = Event.where(user_id: @user.id)
		@event = Event.find(params[:event_id])
		@hashtag = Event.find(params[:event_id]).hashtag
		@tweets = Tweet.where(event_id: @event.id, hashtag: @event.hashtag).order("tweet_created_at DESC")
		@comments = Comment.where(event_id: @event.id)
	end
	
end