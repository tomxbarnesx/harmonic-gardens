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
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
        end
    end
end
