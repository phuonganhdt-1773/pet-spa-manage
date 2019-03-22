class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.integer :status
      t.float :price
      t.text :description

      t.timestamps
    end
  end
end
