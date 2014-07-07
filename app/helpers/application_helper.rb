module ApplicationHelper

	#A Vignere cipher using all printable ascii characters (' '..'~')
	class Vignere
		def self.encrypt(plaintext,  key)
			return "No encryption key" if key.nil?
			encrypted = ""
			textLength = plaintext.nil? ? 0 : plaintext.length;
			keyLength =  key.length;
			for i in 0..textLength-1
				encrypted[i] = (plaintext[i].ord + key[i % keyLength].ord - 32).chr;
				if encrypted[i].ord >= 127
					encrypted[i] = (encrypted[i].ord - (127-32)).chr;
				end
			end
			return encrypted;
		end

		def self.decrypt(encrypted,  key) 
			plaintext = "";
			textLength = encrypted.nil? ? 0 : encrypted.length;	
			keyLength =  key.length;
			for i in 0..textLength-1
				ascii = encrypted[i].ord - (key[i % keyLength].ord - 32);
				if ascii < 32 || ascii >= 127
					ascii = ascii + (127-32);
				end
				plaintext << ascii.chr;
			end
			return plaintext;
		end
	end
end
