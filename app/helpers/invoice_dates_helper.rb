module InvoiceDatesHelper
    def shift_dates_to_select
        Shift.where(just_date = @invoice_date.date.to_s)
    end
end