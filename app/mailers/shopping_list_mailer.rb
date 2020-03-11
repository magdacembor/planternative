class ShoppingListMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.shopping_list_mailer.shopping_list.subject
  #
  def shopping_list
    @shopping_list = params[:shopping_list]

    mail to: @shopping_list.user.email, subject: "Your shopping list"
  end
end
