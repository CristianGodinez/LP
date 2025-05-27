class Compra < ApplicationRecord
  belongs_to :producto
  belongs_to :user

  # Calcula el precio total antes de guardar
  before_save :calcular_precio_total

  # Validación: no vender más de lo disponible
  validate :cantidad_no_mayor_que_stock

  # Valida que tenga un usuario cada venta
  validates :user, presence: true

  # Descontar el stock tras crear la venta
  after_create :descontar_stock

  private

  def calcular_precio_total
    if cantidad.present? && precio_unitario.present?
      self.precio_total = cantidad * precio_unitario
    end
  end

  def cantidad_no_mayor_que_stock
    return unless producto && cantidad.present?
    if cantidad > producto.stock
      errors.add(:cantidad, "no puede ser mayor que el stock disponible (#{producto.stock})")
    end
  end

  def descontar_stock
    producto.decrement!(:stock, cantidad)
  end
end
