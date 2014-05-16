class AddExperimentIdToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :experiment_id, :integer
  end
end
