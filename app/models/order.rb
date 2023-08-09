class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address, optional: true

  has_many :order_items
  has_many :products, through: :order_items

  validates :user, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: ['new', 'processing', 'shipped', 'completed', 'cancelled'] }
  validates :payment_id, presence: true, if: -> { status == 'completed' }

  def self.ransackable_attributes(auth_object = nil)
    ["address_id", "created_at", "id", "payment_id", "status", "total", "updated_at", "user_id"]
  end
end
