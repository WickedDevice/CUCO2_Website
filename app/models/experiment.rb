class Experiment < ActiveRecord::Base
	has_many :sensor_data
	has_many :devices

	def active?
		if (self.start <= Time.now)
			if (self.end.nil?) or (Time.now <= self.end)
				return true
			end
		end
		return false
	end
end
