module MaterialDatesHelper
    def material_date_create_access
        if current_user.role == "Foreman"
            render partial: 'material_dates/foreman_form'
        elsif current_user.role == "Designer"
            render partial: 'material_dates/designer_form'
        elsif current_user.role == "Worker"
            render body: nil
        else 
            render partial: 'material_dates/admin_form'
        end
    end
end
