class InvoicesController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @invoices = Invoice.where(active: true)
    end

    def show
        @invoice = Invoice.find(params[:id])
        @invoice_dates = @invoice.invoice_dates.sort_by &:date
        
        respond_to do |format|
            format.html
            format.pdf do
              pdf = InvoicePdf.new(@invoice)
              total_update = @invoice.current_total
              @invoice.update(total_cost: total_update)
              send_data pdf.render, filename: 'HGInvoice.pdf', type: 'application/pdf'
            end
          end
    end

    def new
        @invoice = Invoice.new
    end

    def create
        @invoice = Invoice.create(invoice_params)

        if @invoice.save
            flash[:notice] = "Invoice successfully created"
            redirect_to "/invoices"
        else
            flash[:error] = "We an encountered an error creating your invoice"
            render 'new'
        end
    end

    def archive
        @invoices = Invoice.where(active: false)
    end

    # def edit

    # end

    def update
        @invoice = Invoice.find(params[:id])

        if @invoice.active == true
            respond_to do |format|
                if @invoice.update(active: false)
                    flash.now[:notice] = "Invoice archived successfully"
                    format.html { redirect_to invoices_path, notice: "Invoice archived succesfully"}
                    format.js {}
                else
                    flash.now[:error] = "Error archiving invoice"
                    format.html { redirect_to invoices_path, error: "Error achiving invoices"}
                    format.js { }
                end
            end
        else
            respond_to do |format|
                if @invoice.update(active: true)
                    flash.now[:notice] = "Invoice unarchived successfully"
                    format.html { redirect_to invoices_path, notice: "Invoice archived succesfully"}
                    format.js { redirect_to invoices_path }
                else
                    flash.now[:error] = "Error unarchiving invoice"
                    format.html { redirect_to invoices_path, error: "Error achiving invoices"}
                    format.js { redirect_to invoices_path }
                end
            end
        end
    end

private
    def invoice_params
        params.require(:invoice).permit(:client_id, :master_desc, :total_cost, :active);
    end

end
