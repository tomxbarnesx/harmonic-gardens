class Invoice < ApplicationRecord
    belongs_to :user
    belongs_to :client
    has_many :invoice_dates
    has_many :shift_dates, through: :invoice_dates
    has_many :material_dates, through: :invoice_dates

end
