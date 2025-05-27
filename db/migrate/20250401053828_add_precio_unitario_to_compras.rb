class AddPrecioUnitarioToCompras < ActiveRecord::Migration[8.0]
  def change
    add_column :compras, :precio_unitario, :decimal
  end
end
