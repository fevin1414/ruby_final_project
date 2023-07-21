class Category < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["products"]
  end

  has_many :products,  dependent: :destroy
end