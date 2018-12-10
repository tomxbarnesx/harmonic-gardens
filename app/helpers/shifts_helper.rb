module ShiftsHelper

    def options_for_active_users
        options_from_collection_for_select(User.where(is_active: true).order('last_name ASC'), "id", "full_name")
    end

    def shift_create_access
        if current_user.role == "Worker"
            render partial: 'shifts/worker_form'
        else
            render partial: 'shifts/foreman_form'
        end
    end

end
