class MaterialDatesController < ApplicationController
    before_action :authenticate_user!
    def show
        @invoice = Invoice.find(params[:id])
        @invoice_dates = @invoice.invoice_dates
    end

    def new
        @invoice_date = InvoiceDate.find(params[:invoice_date_id])
        @material_date = MaterialDate.new
    end

    def create
        @material_date = MaterialDate.price_set_create(material_date_params)
        @invoice_date = InvoiceDate.find(params[:invoice_date_id])
        
        #double check the validity of this as a solution:
        # @invoice_date.update(subtotal: @invoice_date.daily_total(@invoice_date.id))
    end

    def destroy
        @material_date = MaterialDate.find(params[:id])
        @invoice_date = @material_date.invoice_date
        # @invoice_date.update(subtotal: @invoice_date.daily_total(@invoice_date.id))
        @material_date.destroy
        flash[:notice] = "Materials successfully deleted"
    end

private

    def material_date_params
        params.require(:material_date).permit(:material_id, :invoice_date_id, :quantity, :override, :cost);
    end

end
