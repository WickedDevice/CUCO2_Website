require 'spec_helper'
# A dumb test to assure me that testing works
describe "Welcomes" do
  subject { page }

  describe "Index" do
  	before { visit 'welcome/index' }

  	it { should have_content('WickedDevice') }
  end
end
