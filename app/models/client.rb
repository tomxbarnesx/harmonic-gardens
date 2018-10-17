class Client < ApplicationRecord
    has_many :invoices
    has_one :shift
end
