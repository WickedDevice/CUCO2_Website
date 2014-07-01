class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :long_title
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
