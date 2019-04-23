class MaterialDatesController < ApplicationController
    before_action :authenticate_user!
    def show
        #CURRENTLY USED FOR CLIENTS DAILY MATERIALS
        @material_date_client = MaterialDate.where(client_id: params[:id], date: params[:date])
    end

    def new
        @clients = Client.order(:address)
        @materials = Material.where(foreman_priority: true).order('name ASC')
        @material_date = MaterialDate.new
    end

    def edit
        @material_date = MaterialDate.find(params[:id])
    end

    def create
        @client = material_date_params["client_id"]
        @date = material_date_params["date"]
        @misc = Material.find_by(name: "Misc").id
        @materials = Material.where(foreman_priority: true).order('name ASC')

        params["materials"].each do |m|
            @material_date = MaterialDate.multi_create(nested_material_params(m), @client, @date, @misc)
        end

        if $material_date.save
            flash.now[:notice] = "Material added successfully"
        else
            flash.now[:error] = "Error adding some of your materials"
        end
    end

    def update
        @material_date = MaterialDate.find(params[:id])

        if @material_date.update(material_date_params)
            flash[:notice] = "Expense updated successfully."
            redirect_to "/shifts"
        else
            flash[:error] = "Error updating your expense"
            render 'edit'
        end
    end

    def destroy
        @material_date = MaterialDate.find(params[:id])
        @material_date.destroy
        flash.now[:notice] = "Materials successfully deleted"
    end

private

    def material_date_params
        params.require(:material_date).permit(:description, :material_id, :client_id, :quantity, :date, :cost, :charge, :tax, :materials);
    end

    def nested_material_params(my_params)
        my_params.permit(:quantity, :cost, :charge, :material_id, :description)
    end

    # def blank_material_params(my_blank_params)
    #     # my_blank_params.permit(:description, :quantity, :cost, :charge, :material_id)
    # end

end
