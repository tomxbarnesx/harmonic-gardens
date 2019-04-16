class MaterialDatesController < ApplicationController
    before_action :authenticate_user!
    def show
        #CURRENTLY USED FOR CLIENTS DAILY MATERIALS
        @material_date_client = MaterialDate.where(client_id: params[:id])
    end

    def new
        @clients = Client.order(:address)
        @materials = Material.where(foreman_priority: true).order('name ASC')
        @material_date = MaterialDate.new
        @m = 0
    end

    def create
        @client = material_date_params["client_id"]
        @date = material_date_params["date"]

        params["materials"].each do |key, value|
            MaterialDate.multi_create(nested_material_params(value), @client, @date)
        end

        if $material_date.save
            flash.now[:notice] = "Material added successfully"
        else
            flash.now[:error] = "Error adding your material"
            render 'new'
        end
    end

    def destroy
        @material_date = MaterialDate.find(params[:id])
        @material_date.destroy
        flash.now[:notice] = "Materials successfully deleted"
    end

private

    def material_date_params
        params.require(:material_date).permit(:material_id, :client_id, :quantity, :date, :cost, :tax, :materials);
    end

    def nested_material_params(my_params)
        my_params.permit(:quantity, :material_id, :cost, :charge)
    end

end
