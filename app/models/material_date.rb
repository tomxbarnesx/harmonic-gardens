class MaterialDate < ApplicationRecord
    belongs_to :invoice_date
    belongs_to :material

    validates_numericality_of :quantity, greater_than: 0, only_integer: true, message: "- Must be a whole number greater than 0"
    validates_uniqueness_of :material_id, scope: :invoice_date_id, message: "- Duplicate materials on same date - Update the quantity instead"

    def self.price_set_create(mdp)
        self.price_set(mdp)
    end

    def true_cost
        return (self.cost).to_f / (self.quantity).to_i
    end
    
    private
    
    def self.price_set(mdp)
        if mdp["override"] == "1"
            alt_cost = mdp["cost"]
            mdclone = mdp.clone()
            if mdclone["tax"] == "1"
                mdclone["cost"] = (alt_cost.to_f * 1.0635) * mdclone["quantity"].to_i
            else
                mdclone["cost"] = alt_cost.to_f * mdclone["quantity"].to_i
            end
            $md_entry = MaterialDate.create(mdclone)
        else
            mdclone = mdp.clone()
            if mdclone["tax"] == "1"
                mdclone["cost"] = (Material.find(mdclone["material_id"]).cost * 1.0635) * mdclone["quantity"].to_i
            else
                mdclone["cost"] = Material.find(mdclone["material_id"]).cost * mdclone["quantity"].to_i
            end
            $md_entry = MaterialDate.create(mdclone)
        end
    end
end
