require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

    let!(:user) {FactoryGirl.create(:user)}
    before {sign_in(user)}

    describe "GET show" do
        it "assigns the requested user to user" do
            get :show, id: user
            expect(assigns(:user)).to eql user
        end

        it "renders show page" do
            get :show, id: user
            expect(response).to render_template("show")
        end
    end
end
