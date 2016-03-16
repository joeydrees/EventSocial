class SearchEventsController < ApplicationController

	def index
		@user = User.find(current_user.id)
		@events = Event.all.reverse
	end
	
end