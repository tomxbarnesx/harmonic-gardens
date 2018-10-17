class Shift < ApplicationRecord
    belongs_to :user
    belongs_to :client

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
end

