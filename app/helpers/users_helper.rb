module UsersHelper

    def profile_edits
        if current_user.role == "Worker"
            render partial: 'users/worker_edit'
        else
            render partial: 'users/foreman_edit'
        end
    end
    
end
