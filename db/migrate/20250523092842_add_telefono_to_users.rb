class AddTelefonoToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :telefono, :string
  end
end
