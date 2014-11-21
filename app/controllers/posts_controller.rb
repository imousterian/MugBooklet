class PostsController < ApplicationController
    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = []
            render 'static_pages/home'
        end
    end

    def like
        @post = Post.find_by(:id => params[:id])
        respond_to do |format|
            format.js
        end
    end

    private
        def post_params
            params.require(:post).permit(:content)
        end
end
