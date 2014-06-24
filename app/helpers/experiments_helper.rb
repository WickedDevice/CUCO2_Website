module ExperimentsHelper


	def chart_data experiment
		hash = {}
		max_points = 500 #is this a good limit?
		experiment.sensor_data.order("created_at DESC").limit(max_points).each do |datum|

	  		if hash[datum.created_at].nil?
				hash[datum.created_at] = [ datum ]
			else
				hash[datum.created_at] << datum
			end
		end
		return hash.sort
	end

end
