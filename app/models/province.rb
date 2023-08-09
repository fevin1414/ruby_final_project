class Province < ApplicationRecord
  has_many :addresses

  # Validations
  validates :name, presence: true, length: { maximum: 255 } # Assuming that a province would have a name attribute
end
