class SearchEventsController < ApplicationController

	def index
		@user = current_user
		@events = Event.all.reverse
	end
	
end