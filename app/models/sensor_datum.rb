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
		if(device.experiment_id == params[:experiment_id])
			# This is probably bad practice...
			device.experiment_id = nil
			success &= device.save
		end
		
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
