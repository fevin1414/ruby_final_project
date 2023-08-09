class Product < ApplicationRecord
  belongs_to :category
  has_many :product_images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :product_images, allow_destroy: true
  has_many :order_items
  has_many :orders, through: :order_items
  scope :on_sale, -> { where(on_sale: true) }

  # Validations
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :category_id, presence: true, numericality: { only_integer: true }
  validates :on_sale, inclusion: { in: [true, false] }


  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "stock", "updated_at", "on_sale", "newly_added_eq", "recently_updated_eq"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "product_images", "reviews", "orders"]
  end

  def self.newly_added
    where('created_at >= ? AND created_at < ?', 3.days.ago, Time.current)
  end

  def self.recently_updated
    newly_added_ids = newly_added.pluck(:id)
    scope = where('updated_at >= ? AND updated_at < ?', 3.days.ago, Time.current)

    # Exclude recently added products from recently updated products
    scope = scope.where.not(id: newly_added_ids) if newly_added_ids.present?

    scope
  end
  attribute :on_sale, :boolean, default: false
end
