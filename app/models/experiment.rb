class Experiment < ActiveRecord::Base
	has_many :sensor_data
	has_many :devices
	accepts_nested_attributes_for :devices

	def active?
		if (self.start <= Time.now)
			if (self.end.nil?) or (Time.now <= self.end)
				return true
			end
		end
		return false
	end


	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |experiment|
				csv << experiment.attributes.values_at(*column_names)
			end
		end
	end

	def to_csv
		CSV.generate do |csv|
			csv << ["Experiment #{self.name} at #{self.location}"]
			csv << ["Start:", self.start.to_s, "End:", self.end.to_s]
			csv << [""]
			csv << SensorDatum.column_names
			self.sensor_data.each do |datum|
				csv << datum.attributes.values_at(*SensorDatum.column_names)
			end
		end
	end

	def add_devices(device_hash)
		#Expects a hash in the format of:
		#{device id (as string)  => ["true"/"false"], ...}
		puts "Add_devices called with " + device_hash.to_s

		device_hash = {} if device_hash == nil

		return_value = true
		Device.all.each do |device|
			in_experiment = device_hash[device.id][0] unless device_hash[device.id] == nil
			if active? && in_experiment == 'true'
				device.experiment = self
				return_value &= device.save
			elsif device.experiment_id == self.id # and in_experiment == false
			#remove device from experiment
				puts "removing device"
				device.experiment = nil
				return_value &= device.save
			else
				puts "doing nothing"
			end
		end
		return_value
	end

end
