class ClientsController < ApplicationController
    before_action :authenticate_user!
    before_action :all_clients, only: [:index, :create, :update, :destroy]

    def index
    end

    def show
        @client = Client.find(params[:id])
    end

    def new
        @client = Client.new
    end

    def edit
        @client = Client.find(params[:id])
    end

    def create
        @client = Client.create(client_params)
        
        respond_to do |format|
            if @client.save
                format.html { redirect_to clients_path, notice: "Client added successfully" }
                flash.now[:notice] = "Client added successfully."
                format.js {}
            else
                format.html { render 'new', error: "Errors saving your client"}
                flash.now[:error] = "Errors saving your client."
                format.js { render 'new' }
            end
        end
    end

    def archive
        @client = Client.find(params[:id])

        if @client.is_active == true
            respond_to do |format|
                if @client.update_attribute(:is_active, false)
                    flash.now[:notice] = 'Client archived successfully'
                    format.html { redirect to clients_path, notice: "Client archived succesfully"}
                    format.js {}
                else
                    flash.now[:error] = "Error archiving client"
                    format.html { redirect_to clients_path, error: "Error achiving client"}
                    format.js {}
                end
            end
        else
            respond_to do |format|
                if @client.update_attribute(:is_active, true)
                    flash.now[:notice] = "Client unarchived successfully"
                    format.html { redirect_to clients_path, notice: "Client archived succesfully"}
                    format.js {}
                else
                    flash.now[:error] = "Error unarchiving invoice"
                    format.html { redirect_to clients_path, error: "Error achiving client"}
                    format.js {}
                end
            end
        end
    end

    def archived
        @clients = Client.where(is_active: false)
    end

    def update
        @client = Client.find(params[:id])

        respond_to do |format|
            if @client.update(client_params)
                flash.now[:notice] = "Client updated successfully."
                format.html { redirect_to clients_path, notice: "Client updated successfully" }
                format.js {}
            else
                flash.now[:error] = "Errors editting your client"
                format.html { render "new", error: "Errors editting your client" }
                format.js { render 'edit' }
            end
        end
    end

    def destroy
        @client = Client.find(params[:id])

        if @client.destroy
            flash.now[:notice] = "Client successfully deleted"
        else
            flash.now[:error] = @client.errors.full_messages[0]
            render 'update'
        end
    end

private

    def all_clients
        @clients = Client.where(is_active: true)
    end
    
    def client_params
        params.require(:client).permit(:first_name, :last_name, :address, :email, :active, :home_phone, :cell_phone, :house_pic, :is_active);
    end

end
