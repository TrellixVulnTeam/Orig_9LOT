class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :proposal_id
      t.string :comment
    end
  end
end
