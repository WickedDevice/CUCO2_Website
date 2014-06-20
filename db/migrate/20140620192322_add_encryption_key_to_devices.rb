class AddEncryptionKeyToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :encryption_key, :string
  end
end
