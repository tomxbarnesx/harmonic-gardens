class ShiftsController < ApplicationController
    before_action :authenticate_user!
    def index
        if current_user.user_access == "Admin" || current_user.user_access == "Foreman"
            @shifts = Shift.all
        else
            @shifts = Shift.where(user_id: current_user.id)
        end
    end

    def show
        @shift = Shift.find(params[:id]) 
    end

    def new
        @shift = Shift.new
    end

    def edit
        @shift = Shift.find(params[:id])
    end

    def create
        @shift = Shift.create(shift_params)

        if @shift.save
            flash[:notice] = "Hours logged successfully."
            redirect_to "/shifts"
        else
            flash[:error] = "We encountered an error logging your hours"
            redirect_to "/shifts"
        end
    end

    def update
        @shift = Shift.find(params[:id])

        if @shift.update(shift_params)
            redirect_to "/shifts"
        else
            render 'edit'
        end
    end

    def destroy
        @shift = Shift.find(params[:id])
        @shift.destroy
        redirect_to "/shifts"
    end

private
    
    def shift_params
        params.require(:shift).permit(:start_time, :end_time, :date, :client_id, :user_id);
    end

end