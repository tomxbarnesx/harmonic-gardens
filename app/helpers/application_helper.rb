module ApplicationHelper
    def has_role?(role)
        if current_user.user_access == role
            return true
        end
    end

    def flash_class(level)
        case level.to_sym
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-danger"
        when :alert then "alert alert-danger"
        end
    end

    def layout_switch
        if current_user.role == "Worker" || current_user.role == "Designer"
            render partial: "layouts/worker_nav"
        else 
            render partial: "layouts/foreman_nav"
        end
    end

    def client_shift_attach
        Client.where(is_active: true).order('address ASC')
    end

    def client_shift_attach_names
        Client.where(is_active: true).order('first_name ASC')
    end

end
