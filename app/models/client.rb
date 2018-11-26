class Client < ApplicationRecord
    has_one :invoice
    has_many :shifts
    has_one_attached :house_pic

    validates_presence_of :first_name, message: "Enter a first name."
    validates_presence_of :last_name, message: "Enter a last name."
    validates_presence_of :address, message: "Enter an address."

end
