require 'rails_helper'

feature 'Home page' do

    scenario "When user is not signed in or signed up" do

        visit root_path

        expect(page).to have_selector('h1', text: 'Welcome')

        expect(page).to_not have_title ('| Home')

        expect(page).to have_css("#sign_up_button")

        expect(page).to have_link("Sign up now!")

    end

    scenario "When user signs up successfully" do

        visit root_path
        click_link "Sign up"
        expect(page).to have_title(full_title('Sign up'))

        fill_in "user_name", with: "fidel"
        fill_in "user_email", with: "fidel@fidel.com"
        fill_in "user_password", with: "fidelfidel"
        fill_in "user_password_confirmation", with: "fidelfidel"
        click_button "Sign up"
        expect(page).to have_text("Welcome! You have signed up successfully.")
        expect(page).to have_text("Logged in as fidel@fidel.com")
    end

    scenario "When user is signed in" do
        if_user_is_logged_in
        and_user_has_friends
        then_user_should_see_friends_feed
    end

    scenario "Contact links work" do
        if_user_is_logged_in
        visit root_path
        click_link "Contact"
        expect(page).to have_title(full_title('Contact'))
    end

    def if_user_is_logged_in
        @user = FactoryGirl.create(:user)
        login_as(@user)
        visit root_path
    end

    def and_user_has_friends
        @friend = FactoryGirl.create(:user)
        @user.friendships.create!(friend_id: @friend.id, status: 'accepted')
        visit root_path
    end

    def then_user_should_see_friends_feed
        @user.all_friends.each do |friend|
            expect(page).to have_selector("li##{friend.id}", text: friend.name)
        end
    end

end

