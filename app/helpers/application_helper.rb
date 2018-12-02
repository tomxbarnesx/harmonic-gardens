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
        if current_user.role == "Worker"
            render partial: "layouts/worker_nav"
        else 
            render partial: "layouts/foreman_nav"
        end
    end

    def profile_edits
        if current_user.role == "Worker"
            render partial: 'users/worker_edit'
        else
            render partial: 'users/foreman_edit'
        end
    end

    def shift_create_access
        if current_user.role == "Worker"
            render partial: 'shifts/worker_form'
        else
            render partial: 'shifts/foreman_form'
        end
    end
end
