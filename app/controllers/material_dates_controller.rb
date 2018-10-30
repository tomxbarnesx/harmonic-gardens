class MaterialDatesController < ApplicationController
    def show
        @invoice = Invoice.find(params[:id])
        @invoice_dates = @invoice.invoice_dates
    end

    def new
        @invoice_date = InvoiceDate.find(params[:invoice_date_id])
        @mat_date = MaterialDate.new
    end

    def create
        @mat_date = MaterialDate.create(mat_date_params)
    end

    def destroy
        @mat_date = MaterialDate.find(params[:id])
        @mat_date.destroy
        flash[:notice] = "Materials successfully deleted"
    end

private

    def shift_date_params
        params.require(:material_date).permit(:material_id, :invoice_date_id, :quantity, :cost);
    end
    
end
