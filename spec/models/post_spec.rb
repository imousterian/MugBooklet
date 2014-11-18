require 'rails_helper'

RSpec.describe Post, :type => :model do
    let(:user) {FactoryGirl.create(:user)}
    before {@post = user.posts.build(content: 'Tests')}

    subject {@post}
    it {should respond_to(:content)}
    it {should respond_to(:user)}
    it {should respond_to(:user_id)}
    its(:user) {should eql user}
    it {should be_valid}

    describe "when user is not present" do
        before {@post.user_id = nil}
        it {should_not be_valid}
    end
    describe "when content is blank" do
        before {@post.content = " "}
        it {should_not be_valid}
    end
end
