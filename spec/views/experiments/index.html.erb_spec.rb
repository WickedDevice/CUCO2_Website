require 'spec_helper'

describe "experiments/index" do
  before(:each) do
    assign(:experiments,  Kaminari.paginate_array([
      stub_model(Experiment,
        :name => "Name",
        :location => "Location"
      ),
      stub_model(Experiment,
        :name => "Name",
        :location => "Location"
      )
    ]).page(1))
  end

  it "renders a list of experiments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
