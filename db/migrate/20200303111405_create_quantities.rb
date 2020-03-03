class CreateQuantities < ActiveRecord::Migration[6.0]
  def change
    create_table :quantities do |t|
      t.references :product, null: false, foreign_key: true
      t.references :shopping_list, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
