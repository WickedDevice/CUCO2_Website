require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ExperimentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ApplicationHelper do
	pending "All tests are very basic and incomplete."
	
	describe "Vignere cipher" do
		it "encrypts and decrypts strings" do
			key = "post-modern octopus"
			cipher = ApplicationHelper::Vignere.encode "hello world", key
			
			expect(ApplicationHelper::Vignere.decode(cipher, key)).to eq("hello world")
		end
	end
end
