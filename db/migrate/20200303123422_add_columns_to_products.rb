class AddColumnsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :water_saved, :integer
    add_column :products, :energy_saved, :integer
  end
end
