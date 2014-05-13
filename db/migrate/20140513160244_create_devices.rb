class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :address
      t.string :notes

      t.timestamps
    end
  end
end
