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
		let(:plaintext) { " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~" }
		let(:key) { "post_modern_octopus" }
		let(:example_encrypted) { "ppuwcrukm{xj{p#~!'&$$)+v&)~!/,}/$624:977<>*9<24B?1B7IEGMLJJOQ=LOEGURDUJ\\XZ`_]]bdP_bXZheWh]okmsr" }

		it "encrypts and decrypts strings" do
			encrypted = cipher.encrypt "hello world\"", key
			
			expect(cipher.decrypt(encrypted, key)).to eq("hello world\"")
		end

		it "works on the complete alphabet with a single letter key" do	
			key = "";
			len = plaintext.length;
			encrypted = "";
			output = "";
			success = true;
			#Use ever character as the key
			for c in ' '..'~'
				key[0] = c;
				encrypted = cipher.encrypt(plaintext,key);
				output = cipher.decrypt(encrypted,key);
			
				#print(key + ": ")
				#printf("%s\n%s\n", input, output);
				#printf("%s\n", encrypted);
				
				#Check for successful decryption
				for i in 0..len-1
					if(plaintext[i] != output[i]) 
						success = false;
						printf("Key:%c %d:%d ", key[0], input[i].ord, output[i].ord);
					end
				end
			end
			expect(success).to eq(true)
		end

		it "decodes an old string made with the firmware properly" do

			decrypted = cipher.decrypt example_encrypted, key

			expect(decrypted).to eq(plaintext)
		end

		it "encodes an old string made with the firmware properly" do

			expect(cipher.encrypt(plaintext, key)).to eq(example_encrypted)

		end
	end
end
