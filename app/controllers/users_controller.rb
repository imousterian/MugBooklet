class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
    end

    def friends
        @title = 'Friends'
        @user = User.find(params[:id])
        @friends = @user.current_friends.paginate(page: params[:page])
        render 'show_current_friends'
    end

end
