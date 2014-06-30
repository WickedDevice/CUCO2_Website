class PagesController < ApplicationController
  force_ssl unless Rails.env.development?
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
  skip_before_action :logged_out_redirect #Causes infinite loop if not disabled
  def index
  end

  def faq
  end

  def buy
  end
end
