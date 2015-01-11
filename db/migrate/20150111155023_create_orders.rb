class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order
      t.integer :total
      t.string :name
      t.string :email
      t.boolean :confirmed

      t.timestamps null: false
    end
  end
end
