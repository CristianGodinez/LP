class AddUserToCompras < ActiveRecord::Migration[8.0]
  def change
    add_reference :compras, :user, foreign_key: true
  end
end
