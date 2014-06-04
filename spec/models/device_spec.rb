require 'spec_helper'

describe Device do
  time = "2014-05-16 18:15:12".to_time
  Device.create(name: "First Device", address: "Fake mac address", notes: "Dummy", created_at: time, updated_at: "2014-05-16 18:20:18".to_time, experiment_id: 1)
  Device.create(name: "Prototype", address: "0004A3D63CDD", notes: "Physical board", created_at: "2014-05-16 20:01:03".to_time, updated_at: "2014-05-16 20:01:03".to_time, experiment_id: nil)

end