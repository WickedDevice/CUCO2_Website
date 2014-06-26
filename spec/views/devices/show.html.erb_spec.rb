require 'rails_helper'

RSpec.describe "devices/show", :type => :view do
  before(:each) do
    @device = assign(:device, Device.create!({name: "Test device", "user_id" => 1, "encryption_key" => "secret"}))
  end

  it "renders attributes in <p>" do
  	view.stub(:policy_scope) {|arg| arg} #Rspec doesn't include Pundit properly...

    render
  end
end
