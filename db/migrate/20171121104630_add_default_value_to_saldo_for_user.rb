class AddDefaultValueToSaldoForUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :saldo, :decimal, default: 0.0
  end
end
