class AddColumddnToProposals < ActiveRecord::Migration
  def change
    change_column_default :proposals, :type, 'Nonevaluation'
  end
end
