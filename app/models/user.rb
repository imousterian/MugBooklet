class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    # extend FriendlyId
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable

    # friendly_id :name, use: :slugged
    # friendly_id :slugged_candidates, use: :slugged
    has_many :posts, :dependent => :destroy
    has_many :comments, :dependent => :destroy
    has_many :friendships, :dependent => :destroy
    has_many :likes, :dependent => :destroy

    has_many :inactive_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy

    has_many :active_friends, -> { where(friendships: {status: 'accepted'}).order('name DESC') },
                :through => :friendships, source: :friend

    has_many :inactive_friends, -> {where(friendships: {status: 'accepted'})},
                :through => :inactive_friendships, source: :user

    # friendships that the user requested
    has_many :pending_friends, -> { where(friendships: {status: 'requested'}).order('name DESC') },
                :through => :friendships, source: :friend

    # friendships that the user was requested of
    has_many :requested_friendships, -> {where(friendships: {status: 'requested'})},
                :through => :inactive_friendships, source: :user

    validates_presence_of :name, unique: true

    paginates_per 12

    # def slugged_candidates
    #     [ :name ]
    # end

    def all_friends
        active_friends | inactive_friends
    end

    def friend_ids
        all_friends.map {|i| i.id}
    end

    def friends_of_friends
        Friendship.where(user_id: [friend_ids]).
                    where.not(friend_id: self).map {|i| i.friend_id}.uniq
    end

    def suggested_friends
        if friends_of_friends.empty?
            User.where.not(id: [friend_ids]).where.not(id: self)
        else
            User.where(id: [friends_of_friends])
        end
    end

    def has_potential_friend?(friend)
        friendships.where('friend_id = ? AND status = ?', friend.id, 'requsted')
    end

    def request_friendship(friend)
        friendships.create!(friend_id: friend.id, status: 'requested')
    end

    def been_approved_by(friend)
        friendships.find_by(friend_id: friend.id).update_columns(status: 'accepted')
    end

    def been_rejected_by(friend)
        friendships.find_by(friend_id: friend.id).destroy
    end

    def like(post)
        likes.create!(post_id: post.id)
    end

    def unlike(post)
        likes.find_by(post_id: post.id).destroy
    end

    def liking?(post)
        likes.find_by(post_id: post.id)
    end

    def feed
        # Post.where(user_id: [friend_ids])
        Post.from_friends_of(self)
    end

end
