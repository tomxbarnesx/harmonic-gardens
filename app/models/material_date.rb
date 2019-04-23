class MaterialDate < ApplicationRecord
    belongs_to :material
    belongs_to :client

    # validates_numericality_of :quantity, greater_than: 0, message: "- Must be a whole number greater than 0"
    # validates_uniqueness_of :material_id, scope: :invoice_date_id, message: "- Duplicate materials on same date - Update the quantity instead"

    def self.price_set_create(mdp)
        self.price_set(mdp)
    end

    def true_cost
        return (self.cost).to_f / (self.quantity).to_i
    end

    def self.multi_create(sp, client, date, misc)
        self.multi(sp, client, date, misc)
    end

    def self.client_tally(mats, date)
        #Create the client totals on the Material Dates / Shift view
        client_set = []
        last_client = nil
        #Loop through the materials and bundle them
        mats.each do |m|
            if last_client != m.client_id
                if m.cost
                    cost = m.cost * m.quantity
                else
                    cost = m.cost
                end

                if m.charge
                    charge = m.charge * m.quantity
                else 
                    charge = m.charge
                end

                client_set.push({"client_id": m.client_id, "date": m.date, "client_address": m.client.address, "client_full_name": m.client.full_name, "total_cost": cost, "total_charge": charge})
                last_client = m.client_id
            else
                if m.cost
                    if client_set[-1][:total_cost] == nil
                        client_set[-1][:total_cost] = 0
                    end
                client_set[-1][:total_cost] += (m.cost * m.quantity)
                end

                if m.charge
                    if client_set[-1][:total_charge] == nil
                        client_set[-1][:total_charge] = 0
                    end
                    client_set[-1][:total_charge] += (m.charge * m.quantity)
                end

                last_client = m.client_id
            end 
        end
        return client_set
    end
    
    private

    def self.multi(sp, client, date, misc)
        if sp["quantity"] == 0 || sp["quantity"] == "0" || sp["quantity"] == nil || sp["description"] == ""
            nil
        elsif sp["quantity"] != "" || sp["quantity"] != 0 || sp["quantity"] != "0" || sp["quantity"] != nil
            sclone = sp.clone()
            if sclone["material_id"] == ""
                sclone["material_id"] = misc
            end
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
