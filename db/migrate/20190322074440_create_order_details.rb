class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.float :price
      t.references :order, foreign_key: true
      t.references :pet, foreign_key: true
      t.references :service, foreign_key: true

      t.timestamps
    end
  end
end
