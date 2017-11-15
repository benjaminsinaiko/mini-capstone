class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.string :image
      t.string :description
      t.string :species

      t.timestamps
    end
  end
end
