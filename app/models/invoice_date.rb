class InvoiceDate < ApplicationRecord
    belongs_to :invoice
    has_many :shift_dates, dependent: :destroy
    has_many :material_dates, dependent: :destroy

    def just_date
        return created_at.to_s.slice(0, 10)
    end

    def shift_sub_2(id)
        shift_total = 0
        shift_dates = ShiftDate.where(invoice_date_id: id)
        shift_dates.each do |shift|
            shift_total += shift.earned
            # shift_total += shift.earned
        end
        return shift_total
    end

    def material_sub_2(id)
        mat_total = 0
        material_dates = MaterialDate.where(invoice_date_id: id)
        material_dates.each do |mat|
            mat_total += mat.cost
        end
        return mat_total
    end

    def daily_total(id)
        return self.material_sub_2(id) + self.shift_sub_2(id)
    end
end
