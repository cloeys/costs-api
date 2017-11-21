class ChangePaidDefaultValueFalseForCost < ActiveRecord::Migration[5.1]
  def change
    change_column :costs, :paid, :boolean, default: false
  end
end
