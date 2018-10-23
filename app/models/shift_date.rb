class ShiftDate < ApplicationRecord
    belongs_to :invoice_date
    has_one :shift
end
