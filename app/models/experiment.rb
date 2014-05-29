class Experiment < ActiveRecord::Base
	has_many :sensor_data
	#has_many :devices #Don't want to use direct connection
	has_many :device_experiments

	has_many :devices, :through => :device_experiments
	accepts_nested_attributes_for :devices

	def active?
		if self.start.nil?
			return false
		end

		if (self.start <= Time.now)
			if (self.end.nil?) or (Time.now <= self.end)
				return true
			end
		end
		return false
	end


	def request_only_devices device_ids
		device_ids = [] if device_ids.nil?

		self.device_experiments.each do |device_experiment|
			if device_ids.include? device_experiment.device_id
				device_ids -= [device_experiment.device_id]
			else
				#device_experiment.destroy
				Device.find(device_experiment.device_id).check_in(self.id)
			end
		end
		new_devices = []
		device_ids.each do |id|
			new_devices << Device.find(id)
		end

		self.devices << new_devices
	end

	def checkout_devices
		puts 'checking out devices'
		self.devices.each do |device|
			device.checkout rescue return false
		end
		return true
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

	#This is slightly less ugly than the other way to do this
	alias_method :super_update, :update
	private :super_update
	def update(params)
		if active? && params[:devices]
			if not checkout_devices
				return false
			end
		end
		super_update(params)
	end

end
