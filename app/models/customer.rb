class Customer < ApplicationRecord

  belongs_to :user
  has_many :orders, through: :user
  # Validations
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :order_id, numericality: { only_integer: true }
  validates :user_id, numericality: { only_integer: true }
  validates :product_data, presence: true # Add more validations if there is a specific format for product_data
  validates :gst, :pst, :hst, :total_with_taxes, numericality: true # Assuming these are decimal/float fields

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "order_id", "updated_at", "user_id", "product_data", "gst","pst","hst","total_with_taxes"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "user"]
  end
  def self.ransackable_attributes(auth_object = nil)
    super + %w(subtotal)
  end

end
