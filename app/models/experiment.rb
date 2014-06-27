class Experiment < ActiveRecord::Base
	validates :name, presence: true

	has_many :sensor_data
	#has_many :devices #Don't want to use direct connection
	has_many :device_experiments, dependent: :destroy

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
		return if device_ids.nil?

		device_ids = device_ids.map { |e| e.to_i}

		self.device_experiments.each do |device_experiment|
			if device_ids.include? device_experiment.device_id
				device_ids -= [device_experiment.device_id]
			else
				#device_experiment.destroy
				Device.find(device_experiment.device_id).checkin(self.id)
			end
		end
		
		request_additional_devices device_ids
	end

	def request_additional_devices device_ids
		return if device_ids.nil?
		device_ids = device_ids.map { |e| e.to_i}

		new_devices = []
		device_ids.each do |id|
			device = Device.find(id)
			new_devices << device
		end

		self.devices << new_devices
	end

	def checkout_devices
		puts "checking out #{devices.count} devices"
		success = true
		self.devices.each do |device|
			device.checkout(self.id) rescue success = false
		end
		return success
	end

	def checkin_devices
		self.devices.each do |device|
			device.checkin(self.id) rescue return false
		end
		return true
	end

	def self.to_csv
		csv = ""
		all.each do |experiment|
			csv << experiment.to_csv << "\n\n"
		end
		csv
	end

	def to_csv
		CSV.generate do |csv|

			#setting up headings
			csv << ["Experiment:",self.name, "Location:", self.location]
			csv << ["Start:", self.start.nil? ? "Not started" : self.start.in_time_zone.to_s(:custom_csv),
					"End:",   self.end.nil?   ? "Not ended" : self.end.in_time_zone.to_s(:custom_csv)]
			csv << [""]
			csv << ["Parts per million of CO2"]

			chart_data = ExperimentsHelper.chart_data(self, max_points: nil)

			#Column names
			des = device_experiments.sort_by {|x| x.device_id}
			csv << ["Time"] + des.map {|x| x.location == "" ? x.device.name : x.location}

			chart_data.each do |time, values|
				row = [time.in_time_zone.to_formatted_s(:custom_csv)]
				
				values.sort_by! {|x| x.device_id}
				device_experiments.each do |de|
					if !values[0].nil? && values[0].device_id == de.device_id
						row << values.shift.ppm
					else
						row << nil
					end
				end

				csv << row
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
