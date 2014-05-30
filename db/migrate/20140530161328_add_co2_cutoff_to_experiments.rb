class AddCo2CutoffToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :co2_cutoff, :integer
  end
end
