class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :price_range
      t.boolean :low_cal
      t.boolean :high_protein
      t.boolean :gluten_free
      t.text :description
      t.text :ingredients
      t.float :protein_per_100g
      t.float :fat_per_100g
      t.float :calories_per_100g
      t.float :carbs_per_100g
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
