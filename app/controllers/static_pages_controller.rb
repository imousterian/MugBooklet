class StaticPagesController < ApplicationController

    # before_filter :authenticate_user!, except: [:home, :contact]
    skip_before_filter :authenticate_user!, :only => [:contact, :home]

    def home
        # if user_signed_in?
            # puts "current-user: #{current_user}"
            # @friends = current_user.current_friends.page(params[:page])
            # render 'users/show'
            # @pending_friends = current_user.pending_friends
        # end
    end

    def contact
    end

end
