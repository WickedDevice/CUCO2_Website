class AddAddressIndexToDevices < ActiveRecord::Migration
  def change
  	add_index :devices, :address, unique: true
  end
end
