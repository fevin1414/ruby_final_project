class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :province

  validates :street, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 255 }
  validates :province_id, presence: true

end
