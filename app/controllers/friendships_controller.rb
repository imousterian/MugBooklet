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
        # puts params
        # fri = Friendship.find(params[:id])
        # puts "YAHHO #{fri.id} #{fri.user_id} #{fri.friend_id}"
        # puts "accepted user: #{@accepted_friend.id}"
        # f = @accepted_friend.friendships.find_by(friend_id: current_user.id)
        # puts "current friendship: not #{f}"
        # puts "current friendsship: #{f.id} #{f.user_id} #{f.friend_id}"
        # @friendship = Friendship.find(params[:id])
        # @accepted_friend = User.find(params[:friendship][:user_id])
        # if @friendship.save
        #     # @friendship.update_attributes(:status => 'accepted')
        #     current_user.accept_request_of(@friendship)
        #     respond_to do |format|
        #         format.html { redirect_to @accepted_friend }
        #         format.js
        #     end
        # end
    end

    def destroy
        @rejected_friend = User.find(params[:friend_id])
        @friendship = Friendship.find(params[:id])
        @friendship.destroy
        respond_to do |format|
            format.html { redirect_to current_user }
            format.js
        end
    end

end
