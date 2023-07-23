class Product < ApplicationRecord
  belongs_to :category
  has_many :product_images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :product_images, allow_destroy: true
  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "stock", "updated_at","on_sale","newly_added","recently_updated"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["category", "product_images", "reviews"]
  end

  scope :on_sale, -> { where(on_sale: true) }
  scope :newly_added, -> { where('created_at >= ?', 1.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ?', 1.days.ago) }

  attribute :on_sale, :boolean, default: false
  attribute :newly_added, :boolean, default: false
  attribute :recently_updated, :boolean, default: false
end