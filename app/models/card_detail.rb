class CardDetail < ApplicationRecord
  belongs_to :user
  belongs_to :billing_user, class_name: "User", foreign_key: "billing_user_id", optional: true
  belongs_to :billing_province, class_name: "Province", foreign_key: "billing_province_id", optional: true
end
