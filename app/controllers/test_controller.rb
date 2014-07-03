class TestController < ApplicationController
  force_ssl unless Rails.env.development? || Rails.env.test?
  #Probably can delete this controller
  def test
  end

end
