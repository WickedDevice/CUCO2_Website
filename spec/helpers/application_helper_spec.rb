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
		subject(:cipher) { ApplicationHelper::Vignere }
		let(:plaintext) { " \"()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{}" }
		let(:key) { "post_modern_octopus" }
		let(:example_encrypted) { "olsuapsikyvhyn)|~-,**/1t,/|~52{5*<8:@?==BD0?B8:HE7H=OKMSRPPUWCRUKM[XJ[Pb^`fecchjVeh^`nl" }

		it "encrypts and decrypts strings" do
			encrypted = cipher.encode "hello world\"", key
			
			expect(cipher.decode(encrypted, key)).to eq("hello world\"")
		end

		it "works on the complete alphabet" do
			key = 'q'
			# pipe, tilde, !"#$%&', and non-printable characters aren't allowed.
			encrypted = cipher.encode plaintext, key

			expect(cipher.decode(encrypted, key)).to eq(plaintext)
		end

		it "decodes an old string made with the firmware properly" do

			decrypted = cipher.decode example_encrypted, key

			expect(decrypted).to eq(plaintext)
		end

		it "encodes an old string made with the firmware properly" do

			expect(cipher.encode(plaintext, key)).to eq(example_encrypted)

		end
	end
end
