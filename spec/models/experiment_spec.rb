require 'spec_helper'

describe Experiment do
  time = "2014-05-16 18:15:12".to_time
  User.create()
  Experiment.create(name: "First experiment", location: "Somewhere", start: time, :end => nil, co2_cutoff: 2050)
  Experiment.create(name: "Second experiment", location: "Not sure", start: Time.now, :end => nil, co2_cutoff: 2001)
end
