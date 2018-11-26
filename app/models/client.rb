class Client < ApplicationRecord
    has_many :invoices, dependent: :restrict_with_error
    has_many :shifts, dependent: :restrict_with_error
    has_one_attached :house_pic

    validates_presence_of :first_name, message: "Enter a first name"
    validates_presence_of :last_name, message: "Enter a last name"
    validates_presence_of :address, message: "Enter an address"

end
