# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
time = "2014-05-16 18:15:12".to_time
User.create(admin: true, name: "Example_user", password: "123", password_confirmation: "123")
Device.create(id: 1, name: "First Device", address: "Fake mac address", notes: "Dummy", created_at: time, updated_at: "2014-05-16 18:20:18".to_time, experiment_id: 1, user_id: 1, encryption_key: " ")
Device.create(id: 2, name: "Prototype", address: "0004A3D63CDD", notes: "Physical board", created_at: "2014-05-16 20:01:03".to_time, updated_at: "2014-05-16 20:01:03".to_time, experiment_id: nil, user_id: 1, encryption_key: "post_modern_octopus")

Experiment.create(id: 1, name: "First experiment", location: "Somewhere", start: time, :end => nil, co2_cutoff: 2050, user_id: 1)
Experiment.create(id: 2, name: "Second experiment", location: "Not sure", start: Time.now, :end => nil, co2_cutoff: 2001, user_id: 1)
DeviceExperiment.create(id: 1, location: "Somewhere in somewhere", experiment_id: 1, device_id: 1)

Page.create( title: "FAQ", long_title: "Frequently asked questions", content: "###This uses Github flavored markdown!\r\n1. Just edit this from by clicking 'edit'\r\n    (It only shows up if you're an admin)\r\n2. It is probably easiest to copy & paste into the content box\r\n\r\n* FAQ and Buy are the only pages that do anything, now.\r\n* But more could be added easily, or things could be changed so that *all* pages are viewable.\r\n\r\n<p>\r\n\t Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et pulvinar est, eget lobortis erat. Aliquam facilisis, sapien a tincidunt varius, tortor velit euismod metus, vel ultricies mi libero sit amet libero. Duis id mi lacus. Donec eget tellus luctus metus euismod consectetur. Pellentesque dictum aliquam leo, sed malesuada justo tincidunt ut. Etiam eget condimentum lectus, vitae ultrices neque. Curabitur ut quam a nisi vulputate sollicitudin vel eu arcu. Curabitur consequat aliquam ipsum eu venenatis. Morbi sed sem sollicitudin enim pulvinar lacinia. Fusce vehicula adipiscing molestie. Duis varius lectus id cursus tincidunt.\r\n</p>\r\n\r\n<p>\r\nInterdum et malesuada fames ac ante ipsum primis in faucibus. Donec tincidunt diam et faucibus dapibus. Aliquam posuere augue sed lorem dapibus cursus. Nunc a mi leo. Phasellus ullamcorper gravida pellentesque. Aliquam id lacus non dui viverra convallis non ultrices ligula. Morbi nec tempor tellus. Nulla suscipit et velit vitae imperdiet.\r\n</p>\r\n\r\n<p>\r\nMauris eu ante ultricies, tincidunt felis eu, blandit orci. Proin euismod elit non turpis tristique facilisis. Vivamus tristique tristique nisl, eu porta eros porta fringilla. Cras condimentum pellentesque mattis. Aenean erat nisl, tempus et sodales non, fermentum sit amet dui. Aliquam ac diam sed quam egestas euismod. Duis faucibus suscipit tortor adipiscing tempus. Phasellus egestas enim convallis lacus tempus, a consequat massa sodales. Ut eu fermentum lectus. Morbi eu enim vel ligula dignissim porta. Phasellus posuere vel dolor vitae sollicitudin. Phasellus dapibus fringilla sagittis. Duis suscipit, nunc id iaculis dapibus, turpis mi iaculis magna, ac sollicitudin orci nunc vulputate nisi. Donec consequat tristique turpis, sit amet tempor dolor adipiscing at. \r\n\r\n</p>")
Page.create( title: "Buy", long_title: "Purchase sensors", content: "Purchase sensors here!\r\n\r\nEventually...")
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