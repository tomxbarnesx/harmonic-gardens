class MaterialsController < ApplicationController
    before_action :authenticate_user!
    def index
        @materials = Material.all
        authorize @materials
    end
    
    def new
        @material = Material.new
    end

    def edit
        @material = Material.find(params[:id])
    end

    def create 
        @material = Material.create!(material_params)
        
        if @material.save
            flash[:notice] = "Material added successfully."
            redirect_to "/materials"
        else
            flash[:error] = "We encountered an error adding your material"
            redirect_to "/materials"
        end
    end

    def update
        @material = Material.find(params[:id])

        if @material.update(material_params)
            flash[:notice] = "Material editted successfully."
            redirect_to "/materials"
        else
            flash[:error] = "We encountered an error editting your material"
            redirect_to "/materials"
        end
    end

    def destroy
        @material = Material.find(params[:id])
        @material.destroy
    end

private
    def material_params
        params.require(:material).permit(:name, :cost);
    end
end
