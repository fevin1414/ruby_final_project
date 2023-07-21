class Product < ApplicationRecord
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at","stock","description","image_id","price"]
  end

  belongs_to :category
end
