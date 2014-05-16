require 'spec_helper'

describe "experiments/new" do
  before(:each) do
    assign(:experiment, stub_model(Experiment,
      :name => "MyString",
      :location => "MyString"
    ).as_new_record)
  end

  it "renders new experiment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", experiments_path, "post" do
      assert_select "input#experiment_name[name=?]", "experiment[name]"
      assert_select "input#experiment_location[name=?]", "experiment[location]"
    end
  end
end
