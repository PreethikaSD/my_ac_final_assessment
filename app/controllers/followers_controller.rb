class FollowersController < ApplicationController
	before_action :require_login,  only: [:follow, :unfollow]

	def follow
		set_follow_user
		#check if user has already followed the particular user
		@followed = Follower.find_by(user_id: @follow.id, follow_id: current_user.id)
		if @followed 
			if @followed.count == 1
				redirect_to '/', notice: 'You can follow only once'
			elsif @followed.count == 0
				@followed.update(count: 1)
				redirect_to '/', notice: "You are following the user #{@follow.email}"				
			end
		else	
		#create a record of the current user and followed user	
			@follower = Follower.new
			@follower.user_id = @follow.id	
			@follower.follow_id = current_user.id					
			@follower.count = 1
			if @follower.save
				redirect_to '/', notice: "You are following the user #{@follow.email}"
			else
				render :'/', notice: 'Please try again'
			end
		end
	end

	def unfollow
		set_follow_user
		#check if user has already unfollowed the particular user
		@followed = Follower.find_by(user_id: @follow.id, follow_id: current_user.id)
		if @followed 
			if @followed.count == 0
				redirect_to '/', notice: 'You can unfollow only once'
			elsif @followed.count == 1
				@followed.update(count: 0)
				redirect_to '/', notice: "You are unfollowing the user #{@follow.email}"			
			end	
		else	
		#create a record of the current user and unfollowed user	
			@follower = Follower.new
			@follower.user_id = @follow.id	
			@follower.follow_id = current_user.id					
			@follower.count = 0
			if @follower.save
				redirect_to '/', notice: "You are unfollowing the user #{@follow.email}"
			else
				render :'/', notice: 'Please try again'
			end
		end
	end	

	private

	def follower_params
		process_params = params.require(:follower).permit(user_id, follow_id, count)
	end

	def set_follow_user
		@follow = User.find(params[:id])
	end	

    def require_login
		unless user_signed_in?
			flash[:alert] = "You must be logged in to access this section"
			redirect_to 'users/sign_in'
		end
	end
end
