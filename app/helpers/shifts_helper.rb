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

    def material_date_create_access
        # if current_user.role == "Foreman"
        #     render partial: 'material_dates/foreman_form'
        # elsif current_user.role == "Worker"
        #     render body: nil
        # else 
        #     render partial: 'material_dates/admin_form'
        # end
    end

    def shift_house_pic_choice
        if @shift.client.house_pic.attached?
            return (image_tag @shift.client.house_pic, options = {width: "100%"})
        else
            return (image_tag "home_placeholder.jpg", options = {width: "100%", class: "house-pic-container"})
        end
    end

end
