class InvoiceDatesController < ApplicationController
    def new
        @invoice = Invoice.find(params[:invoice_id])
        @invoice_date = InvoiceDate.new
    end

    def create
        @invoice_date = InvoiceDate.create(invoice_date_params)
    end

    def destroy
        @invoice_date = InvoiceDate.find(params[:id])
        @invoice_date.destroy
        flash[:notice] = "Date successfully deleted"
    end

private
    def invoice_date_params
        params.require(:invoice_date).permit(:invoice_id, :date, :description, :subtotal);
    end
end
