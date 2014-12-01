class LikesController < ApplicationController

    def create
        @post = Post.find(params[:like][:post_id])
        current_user.like(@post)
        respond_to do |format|
            format.js
        end
    end

    def selected_index
        @post = Post.find_by(:id => params[:pid])
        @likes = @post.likes
        respond_to do |format|
            format.js
        end
    end

    def destroy
        @post = Post.find(Like.find(params[:id]).post_id)
        current_user.unlike(@post)
        respond_to do |format|
            format.js
        end
    end

end
