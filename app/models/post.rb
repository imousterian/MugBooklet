class Post < ActiveRecord::Base
    belongs_to :user
    default_scope -> { order('created_at DESC') }
    validates_presence_of :user_id, :content

    def self.from_friends_of(user)
        followed_user_ids = "SELECT friend_id FROM friendships WHERE user_id = :user_id AND status = 'accepted'
                    UNION SELECT user_id FROM friendships WHERE friend_id = :user_id AND status = 'accepted'"
        where("user_id IN (#{followed_user_ids})", followed_user_ids: followed_user_ids, user_id: user)
    end
end