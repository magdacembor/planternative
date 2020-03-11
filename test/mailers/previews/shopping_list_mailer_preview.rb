# Preview all emails at http://localhost:3000/rails/mailers/shopping_list_mailer
class ShoppingListMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/shopping_list_mailer/shopping_list
  def shopping_list
    ShoppingListMailer.with(shopping_list: ShoppingList.last).shopping_list
  end

end
