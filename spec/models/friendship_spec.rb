require 'rails_helper'

RSpec.describe Friendship, :type => :model do
    let (:user)   {FactoryGirl.create(:user)}
    let (:friend) {FactoryGirl.create(:user)}
    let (:friendship) {user.friendships.build(friend_id: friend.id)}
    subject {friendship}
    it {should be_valid}

    describe "user_methods" do
        it {should respond_to(:user)}
        it {should respond_to(:friend)}
        its(:user) {should eq user}
        its(:friend) {should eq friend}
    end

    describe "when friend_id is not present" do
        before {friendship.friend_id = nil}
        it {should_not be_valid}
    end

    describe "when user_id is not present" do
        before {friendship.user_id = nil}
        it {should_not be_valid}
    end
end
