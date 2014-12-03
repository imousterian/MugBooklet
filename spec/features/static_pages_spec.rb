require 'rails_helper'

feature 'Home page' do

    scenario "When user is not signed in or signed up" do
        visit root_path
        expect(page).to have_selector('h1', text: 'Welcome')
        expect(page).to_not have_title ('| Home')
        expect(page).to have_css("#sign_up_button")
    end

    scenario "When user signs up successfully" do
        visit root_path
        within("form#new_user.new_user") do
            fill_in "user_name", with: "fidel"
            fill_in "user_email", with: "fidel@fidel.com"
            fill_in "user_password", with: "fidelfidel"
            fill_in "user_password_confirmation", with: "fidelfidel"
        end
        click_button "Sign up"
        expect(page).to have_text("fidel Welcome! You have signed up successfully.")
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

    scenario "User posts a new post", js: true do
        if_user_is_logged_in
        and_submits_a_post
    end

    scenario "User posts a new comment", js: true do
        if_user_is_logged_in
        and_user_has_friends
        and_a_post_exists
        and_submits_a_comment
    end

    scenario "User requests a friend for friendship" do
        if_user_is_logged_in
        expect { click_button "Request"}.to change(Friendship, :count).by(1)
    end

    scenario "User accepts a friendship", js: true do
        if_user_is_logged_in
        and_user_has_friends
        and_accept_friendship
    end

    scenario "User declines a friendship", js: true do
        if_user_is_logged_in
        and_user_has_friends
        and_reject_friendship
    end


    # methods to be called in scenarios
    def if_user_is_logged_in
        @user = FactoryGirl.create(:user)
        login_as(@user)
        visit root_path
    end

    def and_user_has_friends
        @friend = FactoryGirl.create(:user)
        @new_friend = FactoryGirl.create(:user)
        @user.friendships.create!(friend_id: @friend.id, status: 'accepted')
        @new_friend.friendships.create!(friend_id: @user.id, status: 'requested')
        visit root_path
    end

    def then_user_should_see_friends_feed
        @user.all_friends.each do |friend|
            expect(page).to have_text(friend.name)
        end
    end

    def and_submits_a_post
        within("form#new_post.new_post") do
            fill_in "post_content", with: "Super post!"
        end
        click_button "Post"
        wait_for_ajax
        expect(page).to have_text("Super post!")
    end

    def and_submits_a_comment
        within("form#new_comment.new_comment") do
            fill_in "comment_body", with: "Super comment!"
        end
        click_button "Comment"
        wait_for_ajax
        expect(page).to have_text("Super comment!")
    end

    def and_a_post_exists
        @friend.posts.create!(content: "lalala")
        visit root_path
    end

    def and_accept_friendship
        click_link 'Friends'
        within("#my-modal") do
            click_button "Accept"
        end
        wait_for_ajax
        expect(page).to have_text("#{@new_friend.name}")
        then_user_should_see_friends_feed
    end

    def and_reject_friendship
        click_link 'Friends'
        within("#my-modal") do
            click_button "Reject"
        end
        wait_for_ajax
        expect(page).to_not have_text("#{@new_friend.name}")
    end
end

