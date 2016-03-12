class EventsController < ApplicationController

	def index
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
		@event = Event.find(params[:id])
	end

	def subscribers
		@title = "Subscribers"
	    @event  = Event.find(params[:id])
	    @subscribers = @event.susbscribers
	end

	private
	    # Use callbacks to share common setup or constraints between actions.
	    def set_comment
	      @event = Event.find(params[:id])
	    end

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def event_params
	      params.require(:event).permit(:name, :event_date, :event_time, :description)
	    end
	
end