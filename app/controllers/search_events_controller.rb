class SearchEventsController < ApplicationController

	def index
		@user = User.find(current_user.id)
		@events = Event.where(user_id: @user.id)
	end
	
end