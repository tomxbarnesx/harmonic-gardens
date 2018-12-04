class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :all_users, only: [:index, :create, :update, :destroy]

    def index
    end

    def show
        @user = User.find(params[:id])
        @weekly_calc = @user.earnings_calculator("week")
        @monthly_calc = @user.earnings_calculator("month")
        authorize @user
    end

    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def create
        @user = User.create(user_params)

        respond_to do |format|
            if @user.save
                format.html { redirect_to users_path, notice: "User added successfully" }
                flash.now[:notice] = "User added successfully."
                format.js {}
            else
                format.html { render 'new', error: "Errors adding your user"}
                flash.now[:error] = "Errors saving your user."
                format.js { render 'new' }
            end
        end
    end

    def update
        @user = User.find(params[:id])
        authorize @user

        respond_to do |format|
            if @user.update(user_params)
                flash.now[:notice] = "User updated successfully."
                format.html { redirect_to user_path(@user), notice: "User updated successfully" }
                format.js {}
            else
                flash.now[:error] = "Errors editting your user"
                format.html { render "edit", error: "Errors editting your user" }
                format.js { render 'edit' }
            end
        end
    end

    def destroy
        @user = User.find(params[:id])
        authorize @user
        
        if @user.destroy
            flash[:notice] = "User successfully deleted"
            redirect_to users_path
        else
            flash.now[:error] = @user.errors.full_messages[0]
            render 'update'
        end
    end

    def edit_access
        if has_role?("Admin") || has_role?("Foreman") && @user.user_access == "Worker"
            return "link_to 'Edit', edit_user_path(@user), remote:true, class: 'btn btn-success'"
        end
    end

private
    def all_users
        @users = User.all
    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :role, :hourly_rate, :email, :password);
    end
end