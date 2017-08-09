class VotesController < ApplicationController

	before_action :require_login,  only: [:upvote, :downvote]

	def upvote
		set_note
		#check if note is upvoted
		@vote = Vote.find_by(note_id: @note.id)
		if @vote
			if @vote.count == 1
				redirect_to note_path(@note.id), notice: 'You can upvote only once'
			elsif @vote.count == 0
				@vote.update(count: 1)
				UserMailer.notify_email(current_user, 1).deliver_now
				redirect_to note_path(@note.id), notice: "You have upvoted #{@note.content}"				
			end
		else	
		#create a record of the note being upvoted
			@vote = Vote.new
			@vote.note_id = @note.id
			@vote.count = 1
			if @vote.save
				UserMailer.notify_email(current_user, 1).deliver_now
				redirect_to note_path(@note.id), notice: "You have upvoted #{@note.content}"	
			else
				render :'/', notice: 'Please try again'
			end
		end
	end

	def downvote
		set_note
		#check if note is downvoted
		@vote = Vote.find_by(note_id: @note.id)
		if @vote
			if @vote.count == 0
				redirect_to note_path(@note.id), notice: 'You can downvote only once'
			elsif @vote.count == 1
				@vote.update(count: 0)
				UserMailer.notify_email(current_user, 0).deliver_now				
				redirect_to note_path(@note.id), notice: "You have downvoted #{@note.content}"			
			end	
		else	
		#create a record of the note bering downvoted	
			@note = Note.new
			@vote.note_id = @note.id
			@vote.count = 0
			if @vote.save
				UserMailer.notify_email(current_user, 0).deliver_now				
				redirect_to note_path(@note.id), notice: "You have downvoted #{@vote.content}"
			else
				render :'/', notice: 'Please try again'
			end
		end
	end	

	private

	def vote_params
		process_params = params.require(:vote).permit(vote_id, count)
	end

	def set_note
		@note = Note.find(params[:id])
	end	

    def require_login
		unless user_signed_in?
			flash[:alert] = "You must be logged in to access this section"
			redirect_to '/users/sign_in'
		end
	end	
end
