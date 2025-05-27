class User < ApplicationRecord
  has_many :compras
  devise :database_authenticatable, :rememberable, :validatable

  def admin?
    self.admin
  end
end
