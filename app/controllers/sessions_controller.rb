class SessionsController < ApplicationController
  skip_after_action :verify_authorized

  # "Create" a session, aka "log the user in" 
  def create

  	#Currently a dummy login system
  	params[:id] = params[:id].nil? ? 1 : params[:id]
  	  user = User.find(params[:id])
    #if user = User.authenticate(params[:username, params[:password])
      # Save the user ID in the session so it can be used in subsequent requests
      session[:current_user_id] = user.id
      redirect_to root_url
    #end
  end

  # "Delete" a session, aka "log the user out" 
  def destroy
    # Remove the user id from the session
    session[:current_user_id] = nil
    redirect_to root_url
  end


end
