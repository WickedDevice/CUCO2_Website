class CreateDeviceExperiments < ActiveRecord::Migration
  def change
    create_table :device_experiments do |t|
      t.integer :device_id
      t.integer :experiment_id
      t.string :location

      t.timestamps
    end
  end
end
