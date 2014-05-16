class SensorDatum < ActiveRecord::Base
	belongs_to :device
	belongs_to :experiment

	attr_accessor :device_address
end
