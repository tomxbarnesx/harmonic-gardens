class ShiftDate < ApplicationRecord
    belongs_to :invoice_date
    belongs_to :shift
    has_one :user, through: :shift

    def hour_calc
        return self.shift.time_elapsed * self.user.hourly_rate
    end

    def self.calc_create(sdp)
        self.calc_up(sdp)
    end

    private

    def self.calc_up(sdp)
        target = Shift.find(sdp[:shift_id])
        sdclone = sdp.clone()
        sdclone["earned"] = target.time_elapsed * target.user.hourly_rate
        $shift_date = ShiftDate.create(sdclone)
    end
end
