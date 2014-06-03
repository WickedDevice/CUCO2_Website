class User < ActiveRecord::Base
	has_many :devices
	has_many :experiments
	def user_id
		id
	end
end
