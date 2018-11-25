class ShiftsController < ApplicationController
    before_action :authenticate_user!
    def index
        if current_user.role == "admin" || current_user.role == "foreman"
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
        if current_user.role == "admin" || current_user.role == "foreman"
            @shifts = Shift.where(date: params[:date])
        else
            @shifts = Shift.where(date: params[:date]).where(user_id: current_user.id)
        end
    end

    def new
        @shift = Shift.new
        @users = User.order('last_name ASC')
    end

    def edit
        @shift = Shift.find(params[:id])
    end

    def create
        @total = Shift.multi_create(shift_params)
        @shifts = Shift.all

        if $split.save
            flash[:notice] = "Shift(s) logged successfully."
            render js: "window.location='#{shifts_path}'"
        else
            flash[:error] = "Error logging your hours"
            render js: "window.location ='#{shifts_path}'"
        end
    end

    def update
        @shift = Shift.find(params[:id])

        authorize @shift

        if @shift.update(shift_params)
            redirect_to "/shifts"
        else
            render 'edit'
        end
    end

    def destroy
        @shift = Shift.find(params[:id])
        authorize @shift

        if @shift.destroy
            flash[:notice] = "This shift was successfully deleted."
            redirect_to '/shifts'
          else
            flash.now[:alert] = "There was an error deleting the shift."
            redirect_to '/shifts'
          end
    end

private
    
    def shift_params
        params.require(:shift).permit(:start_time, :end_time, :date, :client_id, :user_id, user_id: []);
    end

end