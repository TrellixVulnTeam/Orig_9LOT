class CreateUserhopes < ActiveRecord::Migration
  def change
    create_table :userhopes do |t|
      t.string :place
      t.string :rent
      t.string :breadth

      t.timestamps null: false
    end
  end
end
