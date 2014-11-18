require 'rails_helper'

RSpec.describe User, :type => :model do

    before do
        @user = User.new(name: "Fidel", email: "fidel@fidel.com", password: "fidelfidel", password_confirmation: "fidelfidel")#FactoryGirl.create(:user)
        @potential_friend = User.new(name: "Amigo", email: "amigo@amigo.com", password: "fidelfidel", password_confirmation: "fidelfidel") #FactoryGirl.create(:user)
    end

    subject {@user}

    it {should respond_to(:name)}
    it {should respond_to(:email)}
    it {should respond_to(:password)}
    it {should respond_to(:password_confirmation)}
    it {should respond_to(:suggested_friends)}
    it {should respond_to(:friend_ids)}
    it {should respond_to(:friends_of_friends)}
    it {should respond_to(:been_rejected_by)}
    it {should respond_to(:been_approved_by)}

    it {should be_valid}

    describe "user sending a friend request" do
        before do
            @user.save
            @potential_friend.save
            @user.request_friendship(@potential_friend)
        end

        it {should be_has_potential_friend(@potential_friend)}
        its(:pending_friends) {should include(@potential_friend)}

        describe "friendship status of a potential friend" do
            subject {@potential_friend}
            its(:requested_friendships) {should include(@user)}
        end

        describe "user accepting a request" do
            before do
                @user.been_approved_by(@potential_friend)
            end
            subject{@user}
            its(:active_friends) {should include(@potential_friend)}

        end

        describe "user rejecting a request" do
            before do
                @user.been_rejected_by(@potential_friend)
            end
            subject{@user}
            its(:active_friends) {should_not include(@potential_friend)}

        end
    end

    describe "user's suggested friends" do

        describe "when user already has friends" do
            let(:friend1) {FactoryGirl.create(:user)}
            let(:friend2) {FactoryGirl.create(:user)}
            let(:friend3) {FactoryGirl.create(:user)}
            let(:friend4) {FactoryGirl.create(:user)}
            let(:friend5) {FactoryGirl.create(:user)}

            before do
                @user.save
                @user.friendships.create!(friend_id: friend1.id, status: 'accepted')
                friend1.friendships.create!(friend_id: friend2.id, status: 'accepted')
                friend1.friendships.create!(friend_id: friend3.id, status: 'accepted')
                friend1.friendships.create!(friend_id: friend4.id, status: 'accepted')
            end

            subject{@user}

            its(:all_friends) {should include(friend1)}
            its(:friend_ids) {should include(friend1.id)}
            its(:friends_of_friends) {should include(friend2.id, friend3.id, friend4.id)}
            its(:suggested_friends) {should include(friend2, friend3, friend4)}
            its(:suggested_friends) {should_not include(friend5)}

        end

        describe "when user has no friends" do
            let(:friend1) {FactoryGirl.create(:user)}
            let!(:friend2) {FactoryGirl.create(:user)}

            before do
                @user.save
                @user.friendships.create!(friend_id: friend1.id, status: 'accepted')
            end

            subject {@user}
            its(:suggested_friends) {should_not be_empty}
            its(:suggested_friends) {should include(friend2)}
        end

    end

    describe "user friend's posts" do
        let!(:post_to_follow) {FactoryGirl.create(:post, user: FactoryGirl.create(:user))}
        let!(:new_friend) {FactoryGirl.create(:user)}
        before do
            @user.save
            @user.request_friendship(new_friend)
            @user.been_approved_by(new_friend)
            3.times {new_friend.posts.create!(content: "Lorem")}
        end
        its(:feed) do
            new_friend.posts.each do |p|
                should include(p)
            end
        end
    end

end

















