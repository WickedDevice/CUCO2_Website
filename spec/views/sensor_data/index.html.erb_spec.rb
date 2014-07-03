require 'spec_helper'

describe "sensor_data/index" do
  before(:each) do
    assign(:sensor_data,  Kaminari.paginate_array([
      stub_model(SensorDatum,
        ppm: 1,
        created_at: Time.now
      ),
      stub_model(SensorDatum,
        ppm: 1,
        created_at: Time.now
      )
    ]).page(1))
  end

  it "renders a list of sensor_data" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
