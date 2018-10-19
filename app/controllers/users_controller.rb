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
        @user = User.create(cser_params)

        if @user.save
            flash[:notice] = "User added."
            redirect_to "/csers"
        else
            flash[:error] = "We encountered an error creating your new cser."
            render 'new'
        end
    end

    def update
        @user = User.find(params[:id])
        @user.update(cser_params)
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "User successfully deleted"
    end

private
    
    def user_params
        params.require(:user).permit(:first_name, :last_name, :active);
    end
end
