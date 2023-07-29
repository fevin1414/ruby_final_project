class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  # other associations and code...
end
