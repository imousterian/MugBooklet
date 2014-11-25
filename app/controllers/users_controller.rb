class UsersController < ApplicationController

    def show
        @user = User.friendly.find(params[:id])
        @posts = @user.posts.page(params[:page])
        @post = @user.posts.build
        @friends = @user.all_friends
    end

end
