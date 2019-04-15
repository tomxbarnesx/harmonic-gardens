class MaterialDatesController < ApplicationController
    before_action :authenticate_user!
    def show
        @invoice = Invoice.find(params[:id])
        @invoice_dates = @invoice.invoice_dates
    end

    def new
        # @invoice_date = InvoiceDate.find(params[:invoice_date_id])
        @materials = Material.order('')
        @material_date = MaterialDate.new
    end

    def new
        @shift = Shift.new
        @users = User.order('last_name ASC')
    end

    def create
        @material_date = MaterialDate.price_set_create(material_date_params)
        @invoice_date = InvoiceDate.find(params[:invoice_date_id])

        if @material_date.save
            flash.now[:notice] = "Material added successfully"
        else
            flash.now[:error] = "Error adding your material"
            render 'new'
        end
    end

    def destroy
        @material_date = MaterialDate.find(params[:id])
        @invoice_date = @material_date.invoice_date
        @material_date.destroy
        flash.now[:notice] = "Materials successfully deleted"
    end

private

    def material_date_params
        params.require(:material_date).permit(:material_id, :invoice_date_id, :quantity, :override, :cost, :tax);
    end

end
