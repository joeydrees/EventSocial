class EventsController < ApplicationController

	before_action :authenticate_user!

	def index
		@user = current_user
		@events = Event.where(user_id: @user.id)
		@subscriptions = @user.subscriptions
	end

	def new
		@event = Event.new
	end

	def edit
		@event = Event.find(params[:id])
		@time = @event.event_time.split(" ")[1]
	end

	def destroy
		@event = Event.find(params[:id])
		@tweets = Tweet.where(event_id: @event.id)
		@comments = Comment.where(event_id: @event.id)
		if @event.destroy && @tweets.delete_all && @comments.delete_all
			flash[:notice] = "Event was successfully deleted."
			redirect_to events_path
		else
			flash[:alert] = "There was an error deleting the event."
			redirect_to events_path
		end
	end

	def delete_event_pic
		@event = Event.find(params[:id])
		@event.event_pic.destroy
		@event.save
		redirect_to edit_event_path(@event)
	end

	def create
		@event = Event.new(event_params)
		@event.user_id = current_user.id
	    if @event.save
	    	flash[:notice] = "Event was successfully created."
	    	redirect_to events_path
	    else
	   		flash[:alert] = "There was an error creating your event."
	    	redirect_to new_event_path
	    end
	end

	def update
		@event = Event.find(params[:id])
		if @event.update_attributes(event_params)
			flash[:notice] = "Event was successfully updated."
			redirect_to event_path(@event)
		else
			flash[:alert] = "There was an error updating your event."
	    	redirect_to event_path(@event)
		end
	end

	def show
		@user = current_user
		@event = Event.find(params[:id])
		@event_date = @event.event_date
		@event_time = @event.event_time
		@year = @event.getYear(@event_date)
		@month = @event.getMonth(@event_date)
		@day = @event.getDay(@event_date)
		@hour = @event.getHour(@event_time)
		@minute = @event.getMinute(@event_time)
	end

	def subscribe
		@event = Event.find(params[:id])
		@user = current_user
		@user.subscribe(@event)
		redirect_to events_path
	end

	def unsubscribe
		@event = Event.find(params[:id])
		@user = User.find(current_user.id)
		@user.unsubscribe(@event)
		redirect_to events_path
	end

	def subscribers
		@title = "Subscribers"
	    @event  = Event.find(params[:id])
	    @subscribers = @event.susbscribers
	end

	def subscriptions
		@title = "Subscriptions"
		@user = current_user
	    @subscriptions = @user.susbscriptions
	end

	private
	    # Never trust parameters from the scary internet, only allow the white list through.
	    def event_params
	      params.require(:event).permit(:name, :hashtag, :event_pic, :location, :event_date, :event_time, :description, :tweets_approved, :comments_approved).parse_time_select! :event_time
	    end
	
end