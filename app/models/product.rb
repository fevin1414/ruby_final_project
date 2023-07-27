class Product < ApplicationRecord
  belongs_to :category
  has_many :product_images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :product_images, allow_destroy: true
  scope :on_sale, -> { where(on_sale: true) }

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "stock", "updated_at", "on_sale", "newly_added_eq", "recently_updated_eq"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "product_images", "reviews"]
  end

  def self.newly_added
    where('created_at >= ? AND created_at < ?', 3.days.ago, Time.current)
  end

  def self.recently_updated
    recently_added_ids = newly_added.pluck(:id)
    scope = where('updated_at >= ? AND updated_at < ?', 3.days.ago, Time.current)

    scope = scope.where.not(id: recently_added_ids) if recently_added_ids.present?
    scope
  end
  attribute :on_sale, :boolean, default: false
end
