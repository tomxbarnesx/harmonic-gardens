class InvoiceDate < ApplicationRecord
    belongs_to :invoice 
    has_many :shift_dates
    has_many :material_dates
end
