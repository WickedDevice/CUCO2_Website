class SensorDatum < ActiveRecord::Base
	belongs_to :device
	belongs_to :experiment

	attr_accessor :device_address

	def user_id
		if !device.nil? and !device.user_id.nil?
			return device.user_id
		elsif !experiment.nil? and !experiment.user_id.nil?
			return experiment.user_id.nil?
		end
	end

	def resolve_device_id
		if @device_address != nil && device_id.nil?
			self.device = Device.find_by address: @device_address
		end
	end

	def resolve_experiment_id
		if device and device.in_experiment?
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

	def self.batch_create(params)
		if params.nil? || params[:ppm].nil?
			return false
		end

		success = true

		device = Device.find_by address: params[:device_address]
		
		device.checkin params[:experiment_id]
		
		params[:ppm].each do |time, ppm|
			sensor_datum = SensorDatum.new()
			sensor_datum.experiment_id = params[:experiment_id]
			sensor_datum.device = device

			sensor_datum.ppm = ppm
			sensor_datum.created_at = Time.at(time.to_i);

			success &= sensor_datum.save
		end

		return success
	end
end
