class SensorDatum < ActiveRecord::Base
	validates :ppm, numericality: { only_integer: true }
	belongs_to :device
	belongs_to :experiment

	@device_address = nil
	attr_accessor :device_address

	def user_id
		if !device.nil? and !device.user_id.nil?
			return device.user_id
		elsif !experiment.nil? and !experiment.user_id.nil?
			return experiment.user_id.nil?
		end
	end

	def resolve_device_id
		if !@device_address.nil? && device_id.nil?
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
			csv << ["CO2 data as of #{Time.zone.now.to_s(:custom_csv)}"]
			csv << ["ppm","Time measured", "Experiment","Experiment location", "Sensor location", "Sensor name"]
			all.each do |datum|
				device_experiment = DeviceExperiment.find_by(experiment_id: datum.experiment_id, device_id: datum.device_id)
				device_location = device_experiment.nil? ? "Unknown": device_experiment.location

				experiment = datum.experiment
				experiment_location = experiment.nil? ? "Unknown" : experiment.location
				experiment_name = experiment.nil? ? "No experiment" : experiment.name

				csv << [datum.ppm, datum.created_at.in_time_zone.to_s(:custom_csv) , experiment_name, experiment_location, device_location, datum.device.name]
			end
		end
	end

	def self.batch_create(params)
		if params.nil? || params["ppm"].nil?
			return false
		end

		success = true

		device = Device.find_by address: params["device_address"]
		
		#Offline sensor mode
		# => Still expects the user to have set up the experiment ahead of time.
		if params["experiment_id"] == -1 and device.in_experiment?
			experiment_id = device.experiment_id
		else
			experiment_id = params["experiment_id"]
		end

		device.checkin experiment_id
		
		params["ppm"].each do |time, ppm|
			sensor_datum = SensorDatum.new()
			sensor_datum.experiment_id = experiment_id
			sensor_datum.device = device

			sensor_datum.ppm = ppm
			sensor_datum.created_at = Time.at(time.to_i);

			success &= sensor_datum.save
		end

		return success
	end
end
