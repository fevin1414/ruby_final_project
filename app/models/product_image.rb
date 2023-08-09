class ProductImage < ApplicationRecord
  belongs_to :product
  mount_uploader :image, ProductImageUploader

  validates :product, presence: true


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "product_id", "updated_at"]
  end
end
