class InvoicesController < ApplicationController
    def index
        @invoices = Invoice.all
    end

    def show
        
    end

    def new
        @invoice = Invoice.new
    end

    def create
        @invoice = Invoice.new(invoice_params)
    end

    def edit

    end

    def update

    end

end
