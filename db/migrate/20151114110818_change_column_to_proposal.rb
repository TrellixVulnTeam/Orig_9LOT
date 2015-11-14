class ChangeColumnToProposal < ActiveRecord::Migration
  def change
    remove_column :proposals, :comment
  end
end
