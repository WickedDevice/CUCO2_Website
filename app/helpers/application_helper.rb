module ApplicationHelper

	#A modified Vignere cipher for JSON to JSON string encryption
	# => !#$%&|~ can't be used in either the plaintext or password
	# => 	(|~ are swapped with ' ' and ", which are very important to be able to encrypt, and the others are removed so that \ and other illegal JSON characters can be swapped)
	class Vignere
		START_AT = 40 #first character allowed in plaintext that isn't a hardcoded exception (" or ' ')

		def self.decode cipher, key
			plaintext = ""
		
			for i in 0..cipher.length-1
				ascii_char = (json_unsafe(cipher[i]).ord - key[i%key.length].ord) + START_AT
				ascii_char = printable ascii_char
				plaintext << make_readable(ascii_char)
			end
			return plaintext
		end

		def self.encode plaintext, key
			cipher = ""
			for i in 0..plaintext.length-1
				ascii_char = (make_encryptable(plaintext[i]) + key[i%key.length].ord) - START_AT
				ascii_char = json_safe(printable ascii_char)
				cipher << ascii_char
			end
			return cipher
		end

		private

		def self.printable(ascii)
			
			x = (ascii - START_AT) % (127-START_AT) + START_AT
			
		end

		#Equivalent, and closer to how the device implements the method (modulo isn't as nice in C/C++)
=begin
		def printable(x)
			if(x < START_AT)
				return (x + 127-START_AT);
			elsif(x > 127)
				return (x - (127-START_AT));
			else
				return x.chr;
			end
		end
=end

		def self.make_encryptable char
			if    char.chr == ' '; return '~'.ord 
			elsif char.chr == '"'; return '|'.ord
			else				   return char.ord
			end
		end
		
		def self.make_readable char
			if 	  char.chr == '~'; return ' '
			elsif char.chr == '|'; return '"'
			else				   return char.chr
			end
		end
		
		def self.json_safe char
			if 	  char.chr == '\\'; return '!' 
			elsif char.chr == '"';  return '#'
			else 				    return char
			end
		end
		def self.json_unsafe char
			if 	  char.chr == '!'; return '\\' 
			elsif char.chr == '#';  return '"'
			else 				    return char
			end
		end
	end

end
