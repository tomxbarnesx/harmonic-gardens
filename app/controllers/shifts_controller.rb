class ShiftsController < ApplicationController
    before_action :authenticate_user!
    def index
        if current_user.role == "Admin" || current_user.role == "Foreman"
            @shifts = Shift.all
        else
            @shifts = Shift.where(user_id: current_user.id)
        end
    end

    def show
        @shift = Shift.find(params[:id]) 
        authorize @shift
    end

    def day_log
        date = Date.parse(params[:date])

        if current_user.role == "Admin" || current_user.role == "Foreman"
            @shifts = Shift.where(start_time: date.all_day)
            @material_dates = MaterialDate.where(date: date.all_day)
            @client_materials = MaterialDate.client_tally(@material_dates)
        else
            @shifts = Shift.where(start_time: date.all_day).where(user_id: current_user.id)
        end
    end

    def new
        @shift = Shift.new
    end

    def edit
        @shift = Shift.find(params[:id])
    end

    def create
        @shift = Shift.earned_plus_create(shift_params)
        @shifts = Shift.all

        respond_to do |format|
            if $shift.save
                format.html { redirect_to shifts_path, notice: "Shift(s) logged successfully."}
                flash.now[:notice] = "Shift(s) logged successfully."
                format.js {}
            else
                format.html { render 'new', error: "Error logging your hours."}
                flash.now[:error] = "Error logging your hours"
                format.js {render 'new'}
            end
        end
    end

    def update
        @shift = Shift.find(params[:id])

        authorize @shift

        if @shift.earned_update(shift_params)
            flash[:notice] = "Shift updated successfully."
            redirect_to "/shifts"
        else
            flash[:error] = "Error updating your shift"
            render 'edit'
        end
    end

    def destroy
        @shift = Shift.find(params[:id])
        authorize @shift

        if @shift.destroy
            flash[:notice] = "Shift successfully deleted."
            redirect_to '/shifts'
          else
            flash.now[:alert] = "There was an error deleting the shift."
            redirect_to '/shifts'
          end
    end

private
    
    def shift_params
        params.require(:shift).permit(:start_time, :end_time, :earned, :client_id, :employee_count);
    end

end