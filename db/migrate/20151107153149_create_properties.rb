class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name ,null:false
      t.string :address, null:false
      t.string :rent, null:false
      t.string :administrativeexpense, null:false

      t.timestamps null: false
    end
  end
end
