class StaticPagesController < ApplicationController

    skip_before_filter :authenticate_user!

    def home
        if user_signed_in?
            @friends = current_user.current_friends.page(params[:page])
        end
    end

    def contact
    end

end
