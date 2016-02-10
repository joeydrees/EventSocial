class Users::SessionsController < Devise::RegistrationsController
  protected
    def after_sign_in_path_for(resource)
    	request.env['omniauth.origin'] || tweets_path(resource)
  	end


end