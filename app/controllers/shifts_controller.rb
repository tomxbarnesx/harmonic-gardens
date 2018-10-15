class ShiftsController < ApplicationController
    def index
        #Also handles the 'new' function
        @shift = Shift.new
    end

    def create
        @shift = Shift.new(shift_params)
        # @shift.user_id = current_user.id
    end

private
    
    def shift_params
        params.require(:shift).permit(:start_time, :end_time)
    end

end
