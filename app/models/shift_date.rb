class ShiftDate < ApplicationRecord
    belongs_to :invoice_date
    belongs_to :shift
end
