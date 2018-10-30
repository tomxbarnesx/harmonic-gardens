class MaterialDatesController < ApplicationController
    def show
        @invoice = Invoice.find(params[:id])
        @invoice_dates = @invoice.invoice_dates
    end

    def new
        @invoice_date = InvoiceDate.find(params[:invoice_date_id])
        @material_date = MaterialDate.new
    end

    def create
        @material_date = MaterialDate.create(material_date_params)
    end

    def destroy
        @material_date = MaterialDate.find(params[:id])
        @material_date.destroy
        flash[:notice] = "Materials successfully deleted"
    end

private

    def material_date_params
        params.require(:material_date).permit(:material_id, :invoice_date_id, :quantity, :cost);
    end

end
