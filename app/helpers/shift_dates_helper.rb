module ShiftDatesHelper

    def shift_check_attach
        Shift.where(start_time: @invoice_date.date.all_day, client_id: @invoice_date.invoice.client_id).where.not(id: ShiftDate.pluck(:shift_id))
    end
    
end
