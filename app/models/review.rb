class Review < ApplicationRecord
  belongs_to :product

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "customer_name", "id", "product_id", "rating", "updated_at", "images_attachments_id", "product"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["product"] # Allowlisting the "product" association for search
  end

  has_many_attached :images
end
