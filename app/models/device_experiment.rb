class DeviceExperiment < ActiveRecord::Base
	belongs_to :experiment
	belongs_to :device
end
