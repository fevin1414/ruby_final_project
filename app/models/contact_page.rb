class ContactPage < ApplicationRecord
  validates :content, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "updated_at"]
  end
end
