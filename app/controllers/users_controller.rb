class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :all_users, only: [:index, :create, :update, :destroy]

    def index
    end

    def show
        @user = User.find(params[:id])

        # if @user.earnings_calculator("week") != nil
        #     @weekly_calc = @user.earnings_calculator("week")
        #     @monthly_calc = @user.earnings_calculator("month")   
        # else
        #     @weekly_calc = 0
        #     @monthly_calc = 0
        # end         

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

    def archive
        @user = User.find(params[:id])

        if @user.is_active == true
            respond_to do |format|
                if @user.update_attribute(:is_active, false)
                    flash.now[:notice] = 'User archived successfully'
                    format.html { redirect to users_path, notice: "User archived succesfully"}
                    format.js {}
                else
                    flash.now[:error] = "Error archiving user"
                    format.html { redirect_to users_path, error: "Error achiving user"}
                    format.js {}
                end
            end
        else
            respond_to do |format|
                if @user.update_attribute(:is_active, true)
                    flash.now[:notice] = "User unarchived successfully"
                    format.html { redirect_to users_path, notice: "User archived succesfully"}
                    format.js {}
                else
                    flash.now[:error] = "Error unarchiving user"
                    format.html { redirect_to users_path, error: "Error achiving user"}
                    format.js {}
                end
            end
        end
    end

    def archived
        @users = User.where(is_active: false)
    end

    def material
        @user = User.find(params[:id])
        @material_date = MaterialDate.find(params[:material_id])
    end

    def update_user_material
        @user = User.find(params[:id])
        @material_date = MaterialDate.find(params[:material_id])

        if @material_date.update(material_date_params)
            flash.now[:notice] = "User updated successfully."
            redirect_to user_path(@user), notice: "Material updated successfully"
        else 
            flash.now[:error] = "Errors editting your user"
            render "material", error: "Errors editting your material"
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
            flash[:error] = @user.errors.full_messages[0]
            redirect_to users_path
        end
    end

    def edit_access
        if has_role?("Admin") || has_role?("Foreman") && @user.user_access == "Worker"
            return "link_to 'Edit', edit_user_path(@user), remote:true, class: 'btn btn-success'"
        end
    end

private
    def all_users
        @users = User.where(is_active: true)
    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :role, :hourly_rate, :email, :phone_number, :is_active, :password, :address_view);
    end

    def material_date_params
        params.require(:material_date).permit(:description, :material_id, :client_id, :quantity, :date, :cost, :charge, :tax, :materials, :user_id);
    end
end