class Invoice < ApplicationRecord
    belongs_to :client
    has_many :invoice_dates
    has_many :shift_dates, through: :invoice_dates
    has_many :material_dates, through: :invoice_dates

    def just_date
        return created_at.to_s.slice(0, 10)
    end

    def current_total(id)
        total = 0
        invoice_ids = InvoiceDate.where(invoice_id: id)
        invoice_ids.each do |i|
            total += i.material_sub_2(i.id) 
            total += i.shift_sub_2(i.id)
        end
        return total
    end   

    def labor_total(id)
        l_total = 0
        invoice_ids = InvoiceDate.where(invoice_id: id)
        invoice_ids.each do |i|
            l_total += i.shift_sub_2(i.id)
        end
        return l_total
    end
end
