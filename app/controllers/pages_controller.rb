class PagesController < ApplicationController
    before_action :authenticate_user!

    def landing
        @user = current_user
    end
    
end
