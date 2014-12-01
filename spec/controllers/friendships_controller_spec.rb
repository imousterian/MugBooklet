require 'rails_helper'

RSpec.describe FriendshipsController, :type => :controller do

    let! (:user) {FactoryGirl.create(:user)}
    let! (:other_user) {FactoryGirl.create(:user)}

    before{sign_in(user)}

    describe "request a friendship using Ajax" do
        it "should increment a friendship count by 1" do
            expect do
                xhr :post, :create, friendship: { friend_id: other_user.id }
            end.to change(Friendship, :count).by(1)
        end
        it "should respond with success" do
            xhr :post, :create, friendship: { friend_id: other_user.id }
            expect(response).to be_success
        end
    end

    describe "accept a friendship using Ajax" do
        before {other_user.request_friendship(user)}
        let(:friendship) do
            other_user.friendships.find_by(friend_id: user.id)
        end
        it "should not change the friendship count" do
            expect do
                xhr :patch, :update, id: friendship.id
            end.to_not change(Friendship, :count)
        end
        it "should respond with success" do
            xhr :patch, :update, id: friendship.id
            expect(response).to be_success
        end
        it "updates the friend information" do
            xhr :patch, :update, id: friendship.id
            expect(user.all_friends.last).to eql(other_user)
        end
    end

    describe "reject a friendship using Ajax" do
        before {other_user.request_friendship(user)}
        let(:friendship) do
            other_user.friendships.find_by(friend_id: user.id)
        end
        it "should decrement the friendship count" do
            expect do
                xhr :delete, :destroy, id: friendship.id
            end.to change(Friendship, :count).by(-1)
        end
        it "should respond with success" do
            xhr :delete, :destroy, id: friendship.id
            expect(response).to be_success
        end
    end
end
