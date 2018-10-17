module ApplicationHelper
    def has_role?(role)
        if current_user.user_access == role
            return true
        end
    end
end
