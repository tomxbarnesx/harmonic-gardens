class User < ApplicationRecord
  has_many :shifts, dependent: :nullify
  has_many :invoices
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates_uniqueness_of :username, message: "Username already taken."
 
  validates_presence_of :first_name, message: "Enter a first name."
  validates_presence_of :last_name, message: "Enter a last name."
  validates_presence_of :username, message: "Enter a username."

  enum role: [:worker, :foreman, :admin]

  after_initialize do
    if self.new_record?
      self.role ||= :worker
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
