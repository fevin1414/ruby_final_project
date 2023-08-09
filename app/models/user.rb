class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses
  has_many :card_details
  has_one :cart
  has_one :shopping_cart, dependent: :destroy
  has_many :orders

  # Validations
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :encrypted_password, presence: true
  validates :name, presence: true
  validates :admin, inclusion: { in: [true, false] }

  def self.ransackable_attributes(auth_object = nil)
    ["admin", "created_at", "email", "encrypted_password", "id", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
