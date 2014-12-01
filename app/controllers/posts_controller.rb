class PostsController < ApplicationController

    def create
        @post = current_user.posts.build(post_params)
        respond_to do |format|
            if @post.save
                format.html { redirect_to root_url }
                format.js
            else
                flash.now[:alert] = "Problem! #{errors_helper(@post, :content)}"
                format.js
            end
        end
    end

    private
        def post_params
            params.require(:post).permit(:content)
        end
end
