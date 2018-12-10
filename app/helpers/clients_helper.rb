module ClientsHelper

    def house_pic_choice
        if @client.house_pic.attached?
            return (image_tag @client.house_pic, options = {width: "100%"})
        else
            return (image_tag "home_placeholder.jpg", options = {width: "100%", class: "house-pic-container"})
        end
    end
    
end
