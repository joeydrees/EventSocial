class EventsController < ApplicationController

	def index
		@user = User.find(current_user.id)
		@events = Event.where(user_id: @user.id)

	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		@event.user_id = current_user.id
	    if @event.save
	      flash[:notice] = "Event was successfully created."
	      redirect_to events_path
	    else
	      flash[:error] = "There was an error creating your event."
	      redirect_to new_event_path
	    end
	end

	def show
		@user = User.find(params[:id])
		@event = Event.find(params[:id])
	end

	def subscribe
		@event = Event.find(params[:id])
		@user = User.find(current_user.id)
		@user.subscribe(@event)
		redirect_to event_path
	end

	def unsubscribe
		@event = Event.find(params[:id])
		@user = User.find(current_user.id)
		@user.unsubscribe(@event)
		redirect_to event_path
	end

	def subscribers
		@title = "Subscribers"
	    @event  = Event.find(params[:id])
	    @subscribers = @event.susbscribers
	end

	def subscriptions
		@title = "Subscriptions"
		@event  = Event.find(params[:id])
	    @subscriptions = @event.susbscriptions
	end

	private
	    # Never trust parameters from the scary internet, only allow the white list through.
	    def event_params
	      params.require(:event).permit(:name, :event_date, :event_time, :description)
	    end
	
end