class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :payment
  accepts_nested_attributes_for :payment
  has_many :images, dependent: :destroy

  def full_name
    ("#{first_name} #{last_name}").strip if first_name.present? || last_name.present?
    "Anonymous"
  end
end
