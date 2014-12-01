require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

    let(:user) {FactoryGirl.create(:user)}

    before{sign_in(user)}

    describe "successfully create a post using Ajax" do
        it "should increment a post count by 1" do
            expect do
                xhr :post, :create, post: attributes_for(:post)
            end.to change(Post, :count).by(1)
        end
        it "should respond with success" do
            xhr :post, :create, post: attributes_for(:post)
            expect(response).to be_success
        end
    end

    describe "unsuccessfully create a post using Ajax" do
        it "should not change a post count" do
            expect do
                xhr :post, :create, post: attributes_for(:invalid_post)
            end.to_not change(Post, :count)
        end
        it "should render create" do
            xhr :post, :create, post: attributes_for(:invalid_post)
            expect(response).to render_template :create
        end
    end

end
