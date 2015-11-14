class AddColumnsToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :comment, :string
  end
end
