class CommentsController < ApplicationController

    def new
        puts "parameters: #{params}"
        @post = Post.find_by(:id => params[:comment][:post_id])
        respond_to do |format|
            # format.html { redirect_to root_url }
            format.js
        end
    end

    def add
        @post = Post.find_by(:id => params[:id])
        respond_to do |format|
            # format.html { redirect_to root_url }
            format.js
        end
    end

    def create
        @comment = current_user.comments.build(comment_params)
        @post = Post.find_by(:id => params[:comment][:post_id])
        respond_to do |format|
            if @comment.save
                format.html { redirect_to root_url }
                format.js
            else
                render 'static_pages/home'
            end
        end
    end

    private
        def comment_params
            params.require(:comment).permit(:body, :user_id, :post_id)
        end
end
