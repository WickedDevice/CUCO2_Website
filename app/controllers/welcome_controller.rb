class WelcomeController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
  skip_before_action :logged_out_redirect #Causes infinite loop if not disabled
  def index
  end
end
