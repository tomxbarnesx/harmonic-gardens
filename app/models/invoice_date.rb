class InvoiceDate < ApplicationRecord
    belongs_to :invoice
    has_many :shift_dates, dependent: :destroy
    has_many :material_dates, dependent: :destroy

    def just_date
        return created_at.to_s.slice(0, 10)
    end
end
