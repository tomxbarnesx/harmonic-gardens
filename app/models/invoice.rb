class Invoice < ApplicationRecord
    belongs_to :client
    has_many :invoice_dates
    has_many :shift_dates, through: :invoice_dates
    has_many :material_dates, through: :invoice_dates

    def just_date
        return created_at.to_s.slice(0, 10)
    end
end
