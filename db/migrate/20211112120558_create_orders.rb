class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :subtotal, precision: 8, scale: 2, null: true
      t.decimal :tax, precision: 8, scale: 2, null: true
      t.decimal :total, precision: 8, scale: 2, null: true
      t.timestamps
    end
  end
end
