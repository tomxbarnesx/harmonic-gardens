class Shift < ApplicationRecord
    belongs_to :user
    belongs_to :client

    def time_elapsed
        return ((end_time - start_time)/60/60)
    end
end

