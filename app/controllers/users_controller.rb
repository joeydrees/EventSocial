class UsersController < ApplicationController

	before_action :authenticate_user!

	def index
		@users = User.includes(:profile)
	end

	def show
		@user = User.find(params[:id])
		@events = Event.where(user_id: @user.id)
	end

end