class ShiftDatesController < ApplicationController
    def new
        @invoice_date = InvoiceDate.find(params[:invoice_date_id])
        @shift_date = ShiftDate.new
    end

    def create
        @shift_date = ShiftDate.create(shift_date_params)
    end

private

    def shift_date_params
        params.require(:invoice).permit(:shift_id, :invoice_date_id);
    end

end
