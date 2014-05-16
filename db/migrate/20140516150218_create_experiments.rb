class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :name
      t.string :location
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
