class InvoiceDatesController < ApplicationController
    before_action :authenticate_user!
    def show
        @invoice_date = InvoiceDate.find(params[:id])
        @shift_dates = @invoice_dates.shift_dates
    end
    
    def new
        @invoice = Invoice.find(params[:invoice_id])
        @invoice_date = InvoiceDate.new
    end

    def create
        @invoice_date = InvoiceDate.create(invoice_date_params)

        if @invoice_date.save
            flash.now[:notice] = "Date created successfully"
        else
            flash.now[:error] = "Error adding new date"
            render 'new'
        end
    end

    def destroy
        @invoice_date = InvoiceDate.find(params[:id])
        if @invoice_date.destroy
            flash.now[:notice] = "Date successfully deleted"
        else
            flash.now[:error] = "Error deleting shift"
        end
    end

private
    def invoice_date_params
        params.require(:invoice_date).permit(:invoice_id, :date, :description, :subtotal);
    end
end
