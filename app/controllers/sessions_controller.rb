class SessionsController < ApplicationController
	skip_after_action :verify_authorized

	def create
		user = User.find_by(name: params[:session][:name])
		if user && user.authenticate(params[:session][:password])
			session[:current_user_id] = user.id
			redirect_to root_path
		else
			flash.now[:error] = 'Invalid username/password combination'
			render 'new'
		end
		#redirect_to(:back, flash: {success: "Successfully logged in."})
	end

	def destroy
		session[:current_user_id] = nil
		redirect_to(:back)
	end
end
