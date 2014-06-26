class FixLimitOnNotesForDevice < ActiveRecord::Migration
  def change
  	change_column :devices, :notes, :text, :limit => nil
  end
end
