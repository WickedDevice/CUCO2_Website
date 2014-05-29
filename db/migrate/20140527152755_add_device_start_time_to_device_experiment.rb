class AddDeviceStartTimeToDeviceExperiment < ActiveRecord::Migration
  def change
    add_column :device_experiments, :device_start_time, :integer
  end
end
