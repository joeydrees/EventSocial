class EventsController < ApplicationController

	before_filter :authenticate_user!

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
		if @event.update(event_params)
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
	      params.require(:event).permit(:name, :hashtag, :event_pic, :event_date, :event_time, :description).parse_time_select! :event_time
	    end
	
end