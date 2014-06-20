module DevicesHelper

	def first_contact_string(device)
		string = Time.now.to_i.to_s + " "

		if @device.nil?
        	string << "<p>Device not found</p>"
		elsif @device.in_experiment?
			string << "In_experiment: "
			string << device.experiment_id.to_s + " "
			string << "CO2_cutoff: "
			string << device.experiment.co2_cutoff.to_s + " "
		else
			string << "Device is not in an experiment. "
		end
		return string
	end

end

