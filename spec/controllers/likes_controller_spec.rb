require 'rails_helper'

RSpec.describe LikesController, :type => :controller do

    let(:user) {FactoryGirl.create(:user)}
    let(:new_post) {FactoryGirl.create(:post)}

    before{sign_in(user)}

    describe "like a post using Ajax" do
        it "should increment a like count by 1" do
            expect do
                xhr :post, :create, like: { post_id: new_post.id }
            end.to change(Like, :count).by(1)
        end
        it "should respond with success" do
            xhr :post, :create, like: { post_id: new_post.id }
            expect(response).to be_success
        end
    end

    describe "unlike a post using Ajax" do
        before {user.like(new_post)}
        let(:like) {user.likes.find_by(post_id: new_post.id)}
        it "should decrement a like count by one" do
            expect do
                xhr :delete, :destroy, id: like.id
            end.to change(Like, :count).by(-1)
        end
        it "should respond with success" do
            xhr :delete, :destroy, id: like.id
            expect(response).to be_success
        end
    end

    describe "show a summary of likes" do
        before {user.like(new_post)}
        let(:like) {user.likes.find_by(post_id: new_post.id)}

        it "should show an array of likes" do
            xhr :get, :selected_index, :pid => new_post.id
            expect(assigns(:likes)).to match_array([like])
        end
        it "should respond with success" do
            xhr :get, :selected_index, :pid => new_post.id
            expect(response).to be_success
        end
    end

end
