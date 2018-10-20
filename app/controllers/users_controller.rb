class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def create
        @user = User.create(user_params)

        if @user.save
            flash[:notice] = "User added."
            redirect_to "/users"
        else
            flash[:error] = "We encountered an error creating your new user."
            render 'new'
        end
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "User successfully deleted"
        render :js => "window.location = '#{users_path}'"
    end

    def edit_access
        if has_role?("Admin") || has_role?("Foreman") && @user.user_access == "Worker"
            return "link_to 'Edit', edit_user_path(@user), remote:true, class: 'btn btn-success'"
        end
    end

private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :hourly_rate, :user_access, :email, :password);
    end
end