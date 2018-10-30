class Client < ApplicationRecord
    has_one :invoice
    has_many :shifts
    has_one_attached :house_pic
end
