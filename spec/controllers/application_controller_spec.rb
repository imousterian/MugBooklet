require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
    let(:user){FactoryGirl.create(:user)}
    before{sign_in user}

    describe "guest user successfully redirects to the home page" do
        it "should respond with success" do
            get :create_guest_user
            expect(response).to redirect_to(root_path)
        end
    end
end
