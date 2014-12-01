class FriendshipsController < ApplicationController

    def create
        @requested_friend = User.find(params[:friendship][:friend_id])
        current_user.request_friendship(@requested_friend)
        respond_to do |format|
            format.html { redirect_to @requested_friend }
            format.js
        end
    end

    def update
        @accepted_friend = Friendship.find(params[:id]).user
        @accepted_friend.been_approved_by(current_user)
        respond_to do |format|
            format.html { redirect_to @accepted_friend }
            format.js
        end
    end

    def destroy
        @rejected_friend = Friendship.find(params[:id]).user
        @rejected_friend.been_rejected_by(current_user)
        respond_to do |format|
            format.html { redirect_to current_user }
            format.js
        end
    end
end
