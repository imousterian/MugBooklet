require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do

    let(:user){FactoryGirl.create(:user)}
    let(:friend){FactoryGirl.create(:user)}

    before{sign_in user}

    describe "if user is signed in" do
        before do
            user.save
            friend.save
            user.friendships.create!(friend_id: friend.id, status: 'accepted')
            friend.posts.create!(:content => 'Lorem')
        end
        it "has a list of feed items" do
            get :home
            expect(user.feed.first).to eql friend.posts.first
        end
        it "builds a post" do
            post = user.posts.build
            get :home
            expect(post.user_id).to eq user.id
        end
        it "should respond with success" do
            get :home
            expect(response).to be_success
        end
        it "renders the template home" do
            get :home
            expect(response).to render_template :home
        end
    end

    describe "GET contact" do
        it "returns http success" do
            get :contact
            expect(response).to be_success
        end
    end

end
