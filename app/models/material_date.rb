class MaterialDate < ApplicationRecord
    belongs_to :invoice_date
    belongs_to :material

    def instant_total
        return self.material.cost * self.quantity
    end
end
