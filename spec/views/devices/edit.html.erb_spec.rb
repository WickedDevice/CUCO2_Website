require 'rails_helper'

RSpec.describe "devices/edit", :type => :view do
  
  before(:each) do
  	view.stub(:current_user) {User.find(1)}
    @device = assign(:device, Device.create!({name: "Test device", "user_id" => 1, "encryption_key" => "secret"}))
  end

  it "renders the edit device form" do
    render

    assert_select "form[action=?][method=?]", device_path(@device), "post" do
    end
  end
end
