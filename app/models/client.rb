class Client < ApplicationRecord
    has_many :invoices
    has_one :shift

    def full_name
        "#{first_name} #{last_name}"
    end

    def abbrv_name
        "#{first_name.slice(0,1)}. #{last_name}"
    end
end
