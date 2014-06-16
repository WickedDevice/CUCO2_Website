class DeviceExperiment < ActiveRecord::Base
	belongs_to :experiment
	belongs_to :device

	def user_id
		if device && experiment && (device.user_id == experiment.user_id)
			return device.user_id
		elsif device && experiment
			return nil
		end

		return device.user_id if device
		return experiment.user_id if experiment
		return nil
	end

	def user
		User.find(user_id)
	end
end
