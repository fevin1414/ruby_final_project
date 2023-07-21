class Product < ApplicationRecord
  # ...

  before_validation :initialize_images

  def initialize(*args, &block)
    super
    self.images ||= []

  end
  def initialize_images
    self.images ||= []
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at", "stock", "description", "price", "image","image_id", "thumbnail_image", "product_reference_image", "category_id"]
  end

  belongs_to :category

  mount_uploader :image, ImageUploader
  mount_uploader :thumbnail_image, ImageUploader


  serialize :images, JSON
end
