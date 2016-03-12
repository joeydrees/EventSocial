class UsersController < ApplicationController

	def subscriptions
		@title = "Subscriptions"
		@event  = Event.find(params[:id])
	    @subscriptions = @event.susbscriptions
	end

end