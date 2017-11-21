# migration for creating users table in db
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :lastname
      t.string :email
      t.decimal :saldo, precision: 8, scale: 2
      t.date :dateofbirth

      t.timestamps
    end
  end
end
