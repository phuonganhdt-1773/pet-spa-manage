class AddBreedToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :breed, :string
    add_column :pets, :gender, :string
    add_column :pets, :weight, :float
    add_column :pets, :height, :float
  end
end
