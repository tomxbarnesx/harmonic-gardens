class Client < ApplicationRecord
    has_one :invoice
    has_many :shifts
end
