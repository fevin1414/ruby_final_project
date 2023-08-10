class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address

  def self.ransackable_attributes(auth_object = nil)
    ["address_id", "created_at", "customer_id", "id", "payment_id", "status", "total", "updated_at", "user_id"]
  end
end
