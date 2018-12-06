module InvoicesHelper

    def invoice_enders
        if @invoice.active == true
            render partial: "invoices/archive_buttons"            
        else
            render partial: "invoices/unarchive_buttons"
        end
    end

end
