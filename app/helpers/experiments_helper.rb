module ExperimentsHelper


	def self.chart_data experiment, options = {}
		#Options can have a :max_points field,
		# => which fetches the most recent :max_points pieces of data

		hash = {}
		experiment.sensor_data.order("created_at DESC").limit(options[:max_points]).each do |datum|

	  		if hash[datum.created_at].nil?
				hash[datum.created_at] = [ datum ]
			else
				hash[datum.created_at] << datum
			end
		end
		return hash.sort
	end

	def chart_data experiment, options
		ExperimentsHelper.chart_data experiment, options
	end

end
