class Client < ApplicationRecord
    has_one :invoice
    has_one :shift
end
