class ShiftDatesController < ApplicationController
    before_action :authenticate_user!

    def show
        @invoice = Invoice.find(params[:id])
        @invoice_dates = @invoice.invoice_dates
    end

    def new
        @invoice_date = InvoiceDate.find(params[:invoice_date_id])
        @shift_date = ShiftDate.new
        
    end

    def create
        @shift_date = ShiftDate.create(shift_date_params)
        @invoice_date = InvoiceDate.find(params[:invoice_date_id])
        if @shift_date.save
            flash.now[:notice] = "Shift added successfully"
        else
            flash.now[:error] = "Error adding your shift"
            render 'new'
        end
    end

    def destroy
        @shift_date = ShiftDate.find(params[:id])
        @invoice_date = @shift_date.invoice_date
        @shift_date.destroy
        flash.now[:notice] = "Shift date deleted successfully"
    end

private

    def shift_date_params
        params.require(:shift_date).permit(:shift_id, :invoice_date_id);
    end

end
