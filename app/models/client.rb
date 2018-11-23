class Client < ApplicationRecord
    has_one :invoice
    has_many :shifts
    has_one_attached :house_pic

    validates :first_name, presence: true
    validates :last_name, presence: true
end
