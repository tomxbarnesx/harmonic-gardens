class MaterialDate < ApplicationRecord
    belongs_to :invoice_date
    has_one :material
end
