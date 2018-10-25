class Shift < ApplicationRecord
    belongs_to :user
    belongs_to :client
    has_one :invoice_date, through: :shift_date

    def time_elapsed
        return ((end_time - start_time)/60/60)
    end

    def just_date
        return start_time.to_s.slice(5, 6)
    end

    def simple_start
        return start_time.to_s[11..15]
    end

    def simple_end
        return end_time.to_s[11..15]
    end

    def full_name_hours
        return self.user.first_name + ' ' + self.user.last_name + ' - ' + self.time_elapsed.to_s
    end
end

