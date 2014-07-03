class SessionsController < ApplicationController
	force_ssl unless Rails.env.development? || Rails.env.test?
	skip_after_action :verify_authorized
	skip_before_action :logged_out_redirect

	def create #login
		user = User.find_by(name: params[:session][:name])
		if user && user.authenticate(params[:session][:password])
			session[:current_user_id] = user.id
			redirect_to current_user
		else
			flash.now[:error] = 'Invalid username/password combination'
			render 'new'
		end
		#redirect_to(:back, flash: {success: "Successfully logged in."})
	end

	def destroy #logout
		session[:current_user_id] = nil
		redirect_to(:back)
	end
end
