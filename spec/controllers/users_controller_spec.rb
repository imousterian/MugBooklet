require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

    describe "GET show" do
        # let(:user){FactoryGirl.create(:user)}
        # before {get name_path(user.name)}
        it "assigns the requested user to user" do
            # user = FactoryGirl.create(:user)
            # get controller.show, name: user
            # expect(assigns(:user)).to eql user
        end

        it "shows show page" do
            # get name_path(FactoryGirl.create(:user).name)
            # expect(response).to render_template("show")
        end
    end
end
