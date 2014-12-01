class CommentsController < ApplicationController

    # not actually needed but could be used later for the comments form to be rendered differently
    # def add
    #     @post = Post.find_by(:id => params[:id])
    #     respond_to do |format|
    #         format.html { redirect_to root_url }
    #         format.js
    #     end
    # end

    def create
        @comment = current_user.comments.build(comment_params)
        @post = Post.find_by(:id => params[:comment][:post_id])
        respond_to do |format|
            if @comment.save
                format.html { redirect_to root_url }
                format.js
            else
                flash.now[:alert] = "Problem! #{errors_helper(@comment, :body)}"
                format.js
            end
        end
    end

    private
        def comment_params
            params.require(:comment).permit(:body, :post_id)
        end
end
