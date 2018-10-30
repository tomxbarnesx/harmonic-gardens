class Material < ApplicationRecord
    has_one :invoice_date, through: :material_date
end
