class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable

    has_many :friendships, :dependent => :destroy
    # has_many :friends, through: :friendships, :conditions => "status = 'accepted'"
    has_many :current_friends, -> { where(friendship: {status: 'accepted'}).order('name DESC') }, :through => :friendships

    # has_many :requested_friends, through: :friendships, :source => :friend, :conditions => "status = 'requested'"
    # has_many :pending_friends, through: :friendships, :source => :friend, :conditions => "status = 'pending'"
end
