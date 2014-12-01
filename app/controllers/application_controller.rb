class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    include ApplicationHelper
    protect_from_forgery with: :exception
    before_action :configure_permitted_params, if: :devise_controller?
    before_filter :authenticate_user!, except: [:create_guest_user]
    before_action :show_current_friends, :show_potential_friends, :show_pending_friends


    def create_guest_user
        u = User.new { |user| user.guest = true }
        id = "guest_#{Time.now.to_i}#{rand(100)}"
        u.name = id

        u.email = "#{id}@example.com"
        u.save!(:validate => false)

        sign_in(:user, u)
        flash[:notice] = 'Welcome, Guest! Your guest account will be available for 24 hours or until you close the browser.'
        redirect_to root_path
    end

    private

        def configure_permitted_params
            devise_parameter_sanitizer.for(:sign_up) << :name
        end

        def show_current_friends
            if user_signed_in?
                @friends = current_user.all_friends
            end
        end

        def show_pending_friends
            if user_signed_in?
                @pending_friends = current_user.requested_friendships.limit(5).order("RANDOM()")
            end
        end

        def show_potential_friends
            if user_signed_in?
                if current_user.all_friends.blank?
                    @available_friends = User.all.limit(5).order("RANDOM()")
                else
                    @available_friends = current_user.suggested_friends.limit(5).order("RANDOM()")
                end
            end
        end
end
