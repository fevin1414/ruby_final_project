class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order, presence: true
  validates :product, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "product_id", "quantity", "updated_at","orders_id_eq"]
  end


end
