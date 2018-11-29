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
        @shift_date = ShiftDate.calc_create(shift_date_params)
        @invoice_date = InvoiceDate.find(params[:invoice_date_id])
    end

    def destroy
        @shift_date = ShiftDate.find(params[:id])
        @invoice_date = @shift_date.invoice_date
        @shift_date.destroy
        flash[:notice] = "Shift date successfully deleted"
    end

private

    def shift_date_params
        params.require(:shift_date).permit(:shift_id, :invoice_date_id, :earned);
    end

end
