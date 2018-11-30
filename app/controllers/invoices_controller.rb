class InvoicesController < ApplicationController
    before_action :authenticate_user!
    def index
        @invoices = Invoice.all
    end

    def show
        @invoice = Invoice.find(params[:id])
        @invoice_dates = @invoice.invoice_dates.sort_by &:date

        respond_to do |format|
            format.html
            format.pdf do
              pdf = InvoicePdf.new(@invoice)
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

    # def set_pdf
    #     @invoice = Invoice.find(params[:id])
    #     @invoice.total_cost = @invoice.current_total(@invoice.id)
    #     @invoice.save
    #     redirect_to "#{invoice_path(@invoice)}/pdf"
    # end

    # def edit

    # end

    # def update

    # end

private
    def invoice_params
        params.require(:invoice).permit(:client_id, :master_desc, :total_cost, :active);
    end

end
