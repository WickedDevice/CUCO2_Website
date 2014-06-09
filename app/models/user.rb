class User < ActiveRecord::Base
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	has_many :devices
	has_many :experiments
	has_secure_password
	def user_id
		id
	end
end
