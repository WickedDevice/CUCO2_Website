class RemoveDeviceStartTimeFromDeviceExperiment < ActiveRecord::Migration
  def change
    remove_column :device_experiments, :device_start_time, :integer
  end
end
