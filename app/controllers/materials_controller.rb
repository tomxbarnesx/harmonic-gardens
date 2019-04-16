class MaterialsController < ApplicationController
    before_action :authenticate_user!
    before_action :all_materials, only: [:index, :create, :update, :destroy]

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
        @material = Material.create(material_params)
        
        respond_to do |format|
            if @material.save
                format.html { redirect_to materials_path, notice: "Material added successfully" }
                flash.now[:notice] = "Material added succesfully"
                format.js {}
            else
                format.html { render 'new', error: "We encountered an error adding your material"}
                flash.now[:error] = "Errors saving your material."
                format.js { render 'new' }
            end
        end
    end

    def update
        @material = Material.find(params[:id])

        respond_to do |format|
            if @material.update(material_params)
                flash.now[:notice] = "Material updated successfully."
                format.html { redirect_to materials_path, notice: "Material updated successfully" }
                format.js {}
            else
                flash.now[:error] = "We encountered an error editting your material"
                format.html { render "new", error: "We encountered an error editting your material" }
                format.js { render 'edit'}
            end
        end
    end

    def destroy
        @material = Material.find(params[:id])

        if @material.destroy
            flash.now[:notice] = "Material successfully deleted"
        else
            flash.now[:error] = @material.errors.full_messages[0]
            render 'update'
        end

    end

private

    def all_materials
        @materials = Material.all
    end

    def material_params
        params.require(:material).permit(:name, :cost, :foreman_priority);
    end

end
