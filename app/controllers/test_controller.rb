class TestController < ApplicationController
  force_ssl unless Rails.env.development?
  def test
  end

end
