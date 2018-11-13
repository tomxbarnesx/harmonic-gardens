class InvoicesController < ApplicationController
    before_action :authenticate_user!
    def index
        @invoices = Invoice.all
    end

    def show
        @invoice = Invoice.find(params[:id])
        @invoice_dates = @invoice.invoice_dates.sort_by &:date
    end

    def new
        @invoice = Invoice.new
    end

    def create
        @invoice = Invoice.create(invoice_params)

        if @invoice.save
            flash[:notice] = "Invoice successfully created"
            redirect_to "/invoices"
        else
            flash[:error] = "We an encountered an error creating your invoice"
            render 'new'
        end
    end

    def edit

    end

    def update

    end

private
    def invoice_params
        params.require(:invoice).permit(:client_id, :master_desc, :total_cost, :active);
    end

end
