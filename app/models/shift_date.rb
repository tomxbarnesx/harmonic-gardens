class ShiftDate < ApplicationRecord
    belongs_to :invoice_date
    belongs_to :shift
    has_one :user, through: :shift

    validates_presence_of :shift_id, message: "Check that you have a valid shift logged to this date and client."
end
