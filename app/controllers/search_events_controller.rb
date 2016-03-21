class SearchEventsController < ApplicationController

	before_action :authenticate_user!

	def index
		@user = current_user
		@events = Event.all.reverse
	end
	
end