require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do

    let!(:user) {FactoryGirl.create(:user)}
    before(:each)do
        @post = user.posts.create!(content: "Lorem")
    end

    before{sign_in(user)}

    describe "successfully create a comment using Ajax" do

        it "should increment a comment count by 1" do
            expect do
                xhr :post, :create, comment: attributes_for(:comment, post_id: @post.id)
            end.to change(Comment, :count).by(1)
        end
        it "should respond with success" do
            xhr :post, :create, comment: attributes_for(:comment, post_id: @post.id)
            expect(response).to be_success
        end
    end

    describe "unsuccessfully create a comment using Ajax" do
        it "should not change a post count" do
            expect do
                xhr :post, :create, comment: attributes_for(:invalid_comment, post_id: @post.id)
            end.to_not change(Comment, :count)
        end
        it "should render create" do
            xhr :post, :create, comment: attributes_for(:invalid_comment, post_id: @post.id)
            expect(response).to render_template :create
        end
    end

end
