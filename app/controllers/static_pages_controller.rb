class StaticPagesController < ApplicationController

    skip_before_filter :authenticate_user!, :only => [:contact, :home]

    def home
        if user_signed_in?
            @post = current_user.posts.build
            # @comment = current_user.comments.build
            @feed_items = current_user.feed.page(params[:page])
            @user = current_user
        end
    end

    def contact
    end

end
