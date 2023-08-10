class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :addresses
         has_many :card_details
         has_many :orders
  has_one :customer
  def self.ransackable_attributes(auth_object = nil)
    ["admin", "created_at", "email", "encrypted_password", "id", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
