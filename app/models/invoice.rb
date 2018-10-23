class Invoice < ApplicationRecord
    belongs_to :user
    belongs_to :client
    has_many :invoice_dates
end
