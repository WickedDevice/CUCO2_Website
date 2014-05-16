require 'spec_helper'

describe "sensor_data/new" do
  before(:each) do
    assign(:sensor_datum, stub_model(SensorDatum,
      :ppm => 1
    ).as_new_record)
  end

  it "renders new sensor_datum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sensor_data_path, "post" do
      assert_select "input#sensor_datum_ppm[name=?]", "sensor_datum[ppm]"
    end
  end
end
