require 'spec_helper'

describe SensorDatum do
  User.create()
  
  time = "2014-05-16 18:15:12".to_time
  data = [
	 {ppm:  634,device_id: 1, experiment_id: 1},
	 {ppm:  634,device_id: 1, experiment_id: 1},
	 {ppm:  633,device_id: 1, experiment_id: 1},
	 {ppm:  634,device_id: 1, experiment_id: 1},
	 {ppm:  703,device_id: 1, experiment_id: 1},
	 {ppm:  1018,device_id: 1, experiment_id: 1},
	 {ppm:  1286,device_id: 1, experiment_id: 1},
	 {ppm:  1495,device_id: 1, experiment_id: 1},
	 {ppm:  1608,device_id: 1, experiment_id: 1},
	 {ppm:  1674,device_id: 1, experiment_id: 1},
	 {ppm:  1690,device_id: 1, experiment_id: 1},
	 {ppm:  1683,device_id: 1, experiment_id: 1},
	 {ppm:  1661,device_id: 1, experiment_id: 1},
	 {ppm:  1599,device_id: 1, experiment_id: 1},
	 {ppm:  1531,device_id: 1, experiment_id: 1},
	 {ppm:  1449,device_id: 1, experiment_id: 1},
	 {ppm:  1375,device_id: 1, experiment_id: 1},
	 {ppm:  1312,device_id: 1, experiment_id: 1},
	 {ppm:  1237,device_id: 1, experiment_id: 1},
	 {ppm:  1184,device_id: 1, experiment_id: 1},
	 {ppm:  1125,device_id: 1, experiment_id: 1},
	 {ppm:  1070,device_id: 1, experiment_id: 1},
	 {ppm:  1023,device_id: 1, experiment_id: 1},
	 {ppm:  979,device_id: 1, experiment_id: 1},
	 {ppm:  933,device_id: 1, experiment_id: 1},
	 {ppm:  905,device_id: 1, experiment_id: 1},
	 {ppm:  868,device_id: 1, experiment_id: 1},
	 {ppm:  840,device_id: 1, experiment_id: 1},
	 {ppm:  817,device_id: 1, experiment_id: 1},
	 {ppm:  775,device_id: 1, experiment_id: 1},
	 {ppm:  759,device_id: 1, experiment_id: 1},
	 {ppm:  741,device_id: 1, experiment_id: 1},
	 {ppm:  736,device_id: 1, experiment_id: 1},
	 {ppm:  718,device_id: 1, experiment_id: 1},
	 {ppm:  706,device_id: 1, experiment_id: 1},
	 {ppm:  697,device_id: 1, experiment_id: 1},
	 {ppm:  686,device_id: 1, experiment_id: 1}
	]
	data.each do |datum|
		time += 1
		datum[:created_at] = time
		SensorDatum.create(datum)
	end
end
