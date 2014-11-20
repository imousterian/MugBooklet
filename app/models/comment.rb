class Comment < ActiveRecord::Base
    belongs_to :post
    belongs_to :user
    validates_presence_of :post_id, :user_id, :body

    def comment_feed

    end

end
