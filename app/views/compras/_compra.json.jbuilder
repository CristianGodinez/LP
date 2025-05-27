json.extract! compra, :id, :producto_id, :cantidad, :precio_total, :created_at, :updated_at
json.url compra_url(compra, format: :json)
