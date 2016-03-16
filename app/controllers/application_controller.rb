class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_event

  protected
	  def get_event
	  	@user = current_user

	  	if !@user.blank?
	  		@events = Event.where(user_id: @user.id)
	  		@subscriptions = @user.subscriptions
	  		if !@events.blank? 
	  			@user_event = @events.first
	  		elsif !@subscriptions.blank?
	  			@user_event = @subscriptions.first
	  		end
	  	end

	  end

end
