class CreateCompras < ActiveRecord::Migration[8.0]
  def change
    create_table :compras do |t|
      t.references :producto, null: false, foreign_key: true
      t.integer :cantidad
      t.decimal :precio_total

      t.timestamps
    end
  end
end
