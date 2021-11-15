class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      
      t.belongs_to :order
      t.integer :quantity, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.decimal :subtotal, precision: 8, scale: 2, null: false
      t.decimal :tax, precision: 8, scale: 2, null: false
      t.decimal :total, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
