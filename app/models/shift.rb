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

    def self.multi_create(sp)
        self.multi(sp)
    end

    private

    def self.multi(sp)
        if sp["user_id"].length > 1
            i = 0
            sp["user_id"].each do |u|
                sclone = sp.clone()
                sclone["user_id"] = sp["user_id"][i]
                split = Shift.create(sclone)
                i += 1
            end
        else
            single = Shift.create(sp)
        end
    end

end

