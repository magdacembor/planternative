class AddColumnToShoppingLists < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_lists, :mark_as_done, :boolean, default: false
  end
end
