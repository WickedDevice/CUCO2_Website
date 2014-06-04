class SessionsController < ApplicationController
	skip_after_action :verify_authorized

	def create
		session[:current_user_id] = 1
		redirect_to(:back, flash: {success: "Successfully logged in."})
	end

	def destroy
		session[:current_user_id] = nil

		redirect_to(:back)
	end
end
