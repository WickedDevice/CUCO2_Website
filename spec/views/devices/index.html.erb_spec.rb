require 'rails_helper'

RSpec.describe "devices/index", :type => :view do
  
  before(:each) do
  	view.stub(:current_user) {User.find(1)}
    assign(:devices, [
      Device.create!({name: "Test device", "user_id" => 1, "encryption_key" => "secret"}),
      Device.create!(name: "Not blank name", "encryption_key" => "not blank", address: "Unique address")
    ])
  end

  it "renders a list of devices" do
    render
  end
end
