require 'spec_helper'

describe "sensor_data/edit" do
  before(:each) do
    @sensor_datum = assign(:sensor_datum, stub_model(SensorDatum,
      :ppm => 1
    ))
  end

  it "renders the edit sensor_datum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sensor_datum_path(@sensor_datum), "post" do
      assert_select "input#sensor_datum_ppm[name=?]", "sensor_datum[ppm]"
    end
  end
end
