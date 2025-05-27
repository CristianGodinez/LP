class Producto < ApplicationRecord
  has_many :compras

  # Asociación para la imagen
  has_one_attached :imagen

  # Validaciones
  validates :precio,
            presence: true,
            numericality: { greater_than: 0 }
end
