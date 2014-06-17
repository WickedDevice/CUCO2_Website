module ApplicationHelper

	#A modified Vignere cipher that uses all printable ascii characters
	class Vignere

		def self.printable(ascii)
			(ascii - 32) % (127-32) + 32
		end
=begin
		#Equivalent, and closer to how the device implements the method (modulo isn't as nice in C/C++)
		def printable(x)
			if(x < 32)
				return (x + 127-32);
			elsif(x > 127)
				return (x - (127-32));
			else
				return x.chr;
			end
		end
=end
		def self.decode cipher, key
			plaintext = ""
		
			for i in 0..cipher.length-1
				ascii_char = (cipher[i].ord - key[i%key.length].ord) + 32
				ascii_char = printable ascii_char
				plaintext << ascii_char.chr
			end
			return plaintext
		end

		def self.encode plaintext, key
			cipher = ""
			for i in 0..plaintext.length-1
				ascii_char = (plaintext[i].ord + key[i%key.length].ord) - 32
				ascii_char = printable ascii_char
				cipher << ascii_char
			end
			return cipher
		end
	end

end
