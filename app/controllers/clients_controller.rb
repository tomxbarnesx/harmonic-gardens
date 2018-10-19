class ClientsController < ApplicationController
    before_action :authenticate_user!
    def index
        @clients = Client.all
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

        if @client.save
            flash[:notice] = "Client added."
            redirect_to "/clients"
        else
            flash[:error] = "We encountered an error creating your new client."
            render 'new'
        end
    end

    def update
        @client = Client.find(params[:id])
        @client.update(client_params)
    end

    def destroy
        @client = Client.find(params[:id])
        @client.destroy
        flash[:notice] = "Client successfully deleted"
    end

private
    
    def client_params
        params.require(:client).permit(:first_name, :last_name, :address, :email, :active);
    end

end
