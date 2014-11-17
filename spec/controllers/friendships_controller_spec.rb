require 'rails_helper'

RSpec.describe FriendshipsController, :type => :controller do

    let (:user) {FactoryGirl.create(:user)}
    let (:other_user) {FactoryGirl.create(:user)}

    before {login_as(user)}

    # describe "create a friendship using Ajax" do
    #     it "should increment a friendship count by 1" do
    #         expect do
    #             xhr :post, :create, friendship: { friend_id: other_user.id }
    #         end.to change(Friendship, :count).by(1)
    #     end
    #     it "should respond with success" do
    #         xhr :post, :create, friendship: { friend_id: other_user.id }
    #         expect(response).to be_success
    #     end
    # end

    describe "GET destroy" do
        it "returns http success" do
            # get :destroy
            # expect(response).to be_success
        end
  end
end
