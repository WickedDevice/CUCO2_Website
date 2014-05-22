class SensorDatum < ActiveRecord::Base
	belongs_to :device
	belongs_to :experiment

	attr_accessor :device_address


	def resolve_device_id
		if @device_address != nil && device_id.nil?
			self.device = Device.find_by address: @device_address
		end
	end

	def resolve_experiment_id
		if device and device.in_experiment?
			puts "Can resolve experiment id"
			self.experiment = self.device.experiment
		end
	end

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |datum|
				csv << datum.attributes.values_at(*column_names)
			end
		end
	end

end
