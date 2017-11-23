class AddReceivedDateAndDueDateToCosts < ActiveRecord::Migration[5.1]
  def change
    add_column :costs, :received_date, :date, null: false, default: Date.today
    add_column :costs, :due_date, :date, null: true
  end
end
