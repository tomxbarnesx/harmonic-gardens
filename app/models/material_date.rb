class MaterialDate < ApplicationRecord
    belongs_to :material
    belongs_to :client

    validates_numericality_of :quantity, greater_than: 0, message: "- Must be a whole number greater than 0"
    # validates_uniqueness_of :material_id, scope: :invoice_date_id, message: "- Duplicate materials on same date - Update the quantity instead"

    def self.price_set_create(mdp)
        self.price_set(mdp)
    end

    def true_cost
        return (self.cost).to_f / (self.quantity).to_i
    end

    def self.multi_create(sp, client, date)
        self.multi(sp, client, date)
    end

    def self.client_tally(mats)
        client_set = []
        last_client = nil
        mats.each do |m|
            if last_client != m.client_id
                client_set.push({"client_id": m.client_id, "client_address": m.client.address, "total_cost": (m.cost * m.quantity), "total_charge": (m.charge * m.quantity)})
                last_client = m.client_id
            else
                client_set[-1][:total_cost] += (m.cost * m.quantity)
                client_set[-1][:total_charge] += (m.charge * m.quantity)
                last_client = m.client_id
            end 
        end
        return client_set
    end
    
    private

    def self.multi(sp, client, date)
        if sp["quantity"] != "" || sp["quantity"] != "0"
            sclone = sp.clone()
            sclone["client_id"] = client
            sclone["date"] = date
            $material_date = MaterialDate.create(sclone)
        end
    end
    
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
