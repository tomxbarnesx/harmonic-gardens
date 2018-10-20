class User < ApplicationRecord
  has_many :shifts, dependent: :nullify
  has_many :invoices
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  validates :username, uniqueness: true

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
