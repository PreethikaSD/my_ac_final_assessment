class UsersController < ApplicationController
	before_action :require_login,  only: [:other_users]

	def index
		if user_signed_in?
			@users = Follower.where(follow_id: current_user.id)
			@user_array = []
			@users.each do |user|
				@user_array << User.find(user.user_id)
			end
		end
	end

	def other_users
			#get users i follow
			@users_i_follow = Follower.where(follow_id: current_user.id)
			#minus from total users to find users i dont follow
			@users_i_follow_id = @users_i_follow.pluck(:user_id)
			@users_i_dont_follow = User.all.pluck(:id) - @users_i_follow_id
			@user_array = []
			@users_i_dont_follow.each do |id|
				@user_array << User.find(id)
			end
	end

	private
    def require_login
		unless user_signed_in?
			flash[:alert] = "You must be logged in to access this section"
			redirect_to 'users/sign_in'
		end
	end
end
