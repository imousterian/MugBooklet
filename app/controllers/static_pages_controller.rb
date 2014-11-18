class StaticPagesController < ApplicationController

    skip_before_filter :authenticate_user!, :only => [:contact, :home]

    def home
        if user_signed_in?
            @post = current_user.posts.build
            @feed_items = current_user.feed.page(params[:page])
        end
    end

    def contact
    end

end
