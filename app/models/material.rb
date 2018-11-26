class Material < ApplicationRecord
    has_many :material_dates, dependent: :restrict_with_error
    has_one :invoice_date, through: :material_date

    validates_presence_of :name, message: "Your material needs a name."
    validates_presence_of :cost, message: "Enter a cost."
end
