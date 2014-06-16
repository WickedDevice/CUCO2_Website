class User < ActiveRecord::Base
	validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[A-Za-z0-9_]+\Z/ }
	has_many :devices
	has_many :experiments
	has_secure_password

	def user_id
		id
	end

	def admin?
		admin || false
	end
end
