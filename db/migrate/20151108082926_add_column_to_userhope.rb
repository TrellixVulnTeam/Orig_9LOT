class AddColumnToUserhope < ActiveRecord::Migration
  def change
    add_column :userhopes, :user_id, :string
  end
end
