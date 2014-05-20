# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
time = "2014-05-16 18:15:12".to_time
Device.create(id: 1, name: "First Device", address: "Fake mac address", notes: "Dummy", created_at: time, updated_at: "2014-05-16 18:20:18".to_time, experiment_id: 10)
Device.create(id: 2, name: "Named", address: "42", notes: "Created for sensor_datum testing", created_at: "2014-05-16 20:01:03".to_time, updated_at: "2014-05-16 20:01:03".to_time, experiment_id: nil)

Experiment.create(id: 10, name: "First experiment", location: "Somewhere", start: time, :end => nil)

data = [
 {ppm:  634,device_id: 1, experiment_id: 10},
 {ppm:  634,device_id: 1, experiment_id: 10},
 {ppm:  633,device_id: 1, experiment_id: 10},
 {ppm:  634,device_id: 1, experiment_id: 10},
 {ppm:  703,device_id: 1, experiment_id: 10},
 {ppm:  1018,device_id: 1, experiment_id: 10},
 {ppm:  1286,device_id: 1, experiment_id: 10},
 {ppm:  1495,device_id: 1, experiment_id: 10},
 {ppm:  1608,device_id: 1, experiment_id: 10},
 {ppm:  1674,device_id: 1, experiment_id: 10},
 {ppm:  1690,device_id: 1, experiment_id: 10},
 {ppm:  1683,device_id: 1, experiment_id: 10},
 {ppm:  1661,device_id: 1, experiment_id: 10},
 {ppm:  1599,device_id: 1, experiment_id: 10},
 {ppm:  1531,device_id: 1, experiment_id: 10},
 {ppm:  1449,device_id: 1, experiment_id: 10},
 {ppm:  1375,device_id: 1, experiment_id: 10},
 {ppm:  1312,device_id: 1, experiment_id: 10},
 {ppm:  1237,device_id: 1, experiment_id: 10},
 {ppm:  1184,device_id: 1, experiment_id: 10},
 {ppm:  1125,device_id: 1, experiment_id: 10},
 {ppm:  1070,device_id: 1, experiment_id: 10},
 {ppm:  1023,device_id: 1, experiment_id: 10},
 {ppm:  979,device_id: 1, experiment_id: 10},
 {ppm:  933,device_id: 1, experiment_id: 10},
 {ppm:  905,device_id: 1, experiment_id: 10},
 {ppm:  868,device_id: 1, experiment_id: 10},
 {ppm:  840,device_id: 1, experiment_id: 10},
 {ppm:  817,device_id: 1, experiment_id: 10},
 {ppm:  775,device_id: 1, experiment_id: 10},
 {ppm:  759,device_id: 1, experiment_id: 10},
 {ppm:  741,device_id: 1, experiment_id: 10},
 {ppm:  736,device_id: 1, experiment_id: 10},
 {ppm:  718,device_id: 1, experiment_id: 10},
 {ppm:  706,device_id: 1, experiment_id: 10},
 {ppm:  697,device_id: 1, experiment_id: 10},
 {ppm:  686,device_id: 1, experiment_id: 10}
]
data.each do |datum|
	time += 1
	datum[:created_at] = time
	SensorDatum.create(datum)
end