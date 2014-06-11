class AddDetailsToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :details, :text
  end
end
