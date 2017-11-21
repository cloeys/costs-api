# migration for creating costs table in db
class CreateCosts < ActiveRecord::Migration[5.1]
  def change
    create_table :costs do |t|
      t.string :title
      t.string :description
      t.string :code
      t.decimal :amount
      t.boolean :paid
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
