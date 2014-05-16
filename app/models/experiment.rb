class Experiment < ActiveRecord::Base
	has_many :sensor_data
	has_many :devices
end
