class ShiftsController < ApplicationController
    before_action :authenticate_user!
    def index
    end

    def new
        @shift = Shift.new
    end

    def create
        @shift = Shift.create(shift_params)
    end

private
    
    def shift_params
        params.require(:shift).permit(:start_time, :end_time, :date, :client_id, :user_id);
    end

end