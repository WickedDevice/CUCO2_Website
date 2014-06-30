class ApplicationController < ActionController::Base
  include Pundit
  include SessionsHelper
  
  before_action :logged_out_redirect
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def logged_out_redirect
    redirect_to(root_path) if current_user.nil?
  end

  def user_not_authorized
  	flash[:error] = "You are not authorized to perform this action."
  	redirect_to(request.referrer || root_path)
  end

  private
  def current_user

    @current_user = nil if session[:current_user_id].nil?
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end

  helper_method :current_user
end
