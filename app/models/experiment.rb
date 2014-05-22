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
end
