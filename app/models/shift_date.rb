class ShiftDate < ApplicationRecord
    belongs_to :invoice_date
    belongs_to :shift
    has_one :user, through: :shift

    def hour_calc
        return self.shift.time_elapsed * self.user.hourly_rate
    end

end
