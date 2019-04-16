class Shift < ApplicationRecord
    belongs_to :client
    has_one :shift_date
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

    def self.earned_plus_create(sp)
        earned_plus(sp)
    end

    def earned_update(sp)
        earned_up(sp)
    end

    private

    def self.earned_plus(sp)
        sclone = sp.clone()
        sclone["earned"] = ((Time.zone.parse(sclone["end_time"]) - Time.zone.parse(sclone["start_time"]))/60/60) * sclone["employee_count"].to_f * 25
        $shift = Shift.create(sclone)
    end

    # def self.multi(sp)
    #     if sp["user_id"].kind_of?(Array)
    #         sp["user_id"].each do |u|
    #             sclone = sp.clone()
    #             sclone["user_id"] = u
    #             sclone["earned"] = ((Time.zone.parse(sclone["end_time"]) - Time.zone.parse(sclone["start_time"]))/60/60) * User.find(sclone["user_id"]).hourly_rate
    #             $shift = Shift.create(sclone)
    #         end
    #     else 
    #         sp["earned"] = ((Time.zone.parse(sp["end_time"]) - Time.zone.parse(sp["start_time"]))/60/60) * User.find(sp["user_id"]).hourly_rate
    #         $shift = Shift.create(sp)
    #     end
    # end

    def earned_up(sp)
        sclone = sp.clone()
        sclone["earned"] = ((Time.zone.parse(sclone["end_time"]) - Time.zone.parse(sclone["start_time"]))/60/60) * self.user.hourly_rate
        self.update(sclone)
    end

end

