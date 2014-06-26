class ChangeNotesFormatToTextInDevices < ActiveRecord::Migration
  def change
  	change_column :devices, :notes, :text
  end
end
