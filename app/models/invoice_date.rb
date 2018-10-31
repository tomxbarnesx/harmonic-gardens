class InvoiceDate < ApplicationRecord
    belongs_to :invoice
    has_many :shift_dates, dependent: :destroy
    has_many :material_dates, dependent: :destroy

    def just_date
        return created_at.to_s.slice(0, 10)
    end

    def shift_sub_total
        shift_total = 0

        self.shift_dates.each do |shift_d|
            shift_total += shift_d.hour_calc
        end

        return shift_total
    end

    def material_sub_total
        mat_total = 0 

        self.material_dates.each do |mat_d|
            mat_total += mat_d.instant_total
        end

        return mat_total
    end

    def material_sub_2(id)
        total = 0
        material_dates = MaterialDate.where(invoice_date_id: id)
        material_dates.each do |mat|
            total += mat.instant_total
        end
        return total
    end
end
