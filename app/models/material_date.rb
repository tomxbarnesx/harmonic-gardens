class MaterialDate < ApplicationRecord
    belongs_to :invoice_date
    belongs_to :material

    def instant_total
        return self.material.cost * self.quantity
    end

    def self.price_set_create(mdp)
        self.price_set(mdp)
    end
    
    private
    
    def self.price_set(mdp)
        if mdp["override"] == "1"
            alt_cost = mdp["cost"] 
            mdclone = mdp.clone()
            mdclone["cost"] = alt_cost.to_f * mdclone["quantity"].to_i
            $md_entry = MaterialDate.create(mdclone)
        else
            p "we're in here *******************************"
            mdclone = mdp.clone()
            mdclone["cost"] = Material.find(mdclone["material_id"]).cost * mdclone["quantity"].to_i
            $md_entry = MaterialDate.create(mdclone)
        end
    end
end
