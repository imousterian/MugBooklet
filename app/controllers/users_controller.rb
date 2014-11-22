class UsersController < ApplicationController

    def show
        # @user = User.find(params[:id])
        @user = User.find_by name: params[:name]
        @posts = @user.posts.page(params[:page])
        @post = @user.posts.build
        # will be getting user's post here.
        # @posts = @user.posts.paginate(page: params[:page])
    end

    def friends
        # @friends = current_user.all_friends
        # @title = 'Friends'
        # @user = User.find(params[:id])
        # @friends = @user.current_friends.paginate(page: params[:page])
        # render 'shared/friend_feed'
    end

end
