class NotesController < ApplicationController
	before_action :require_login,  only: [:new, :edit, :create, :update, :destroy]	
	before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
	before_action :get_note, only: [:show, :edit, :update, :destroy]
	before_action :user_process, only: [:edit, :update, :destroy]


	def index
		@notes = current_user.notes
	end
		
	def new
		@note = Note.new
	end

	def create
		@note = current_user.notes.create(note_params)
		if @note.save
			redirect_to @note, notice: 'Note was successfully created.'
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @note.update(note_params)
			redirect_to @note, notice: 'Note was updated successfully.'
		else
			render :edit
		end
	end

	def destroy
		@note.destroy
		redirect_to notes_url, notice: 'Note was deleted successfully.'
	end


	private
	def note_params
		params.require(:note).permit(:content)
	end

	def get_note
		@note = Note.find(params[:id])
	end

    def require_login
		unless user_signed_in?
			flash[:alert] = "You must be logged in to access this section"
			redirect_to '/users/sign_in'
		end
	end

	def user_process
		unless current_user.id == @note.user_id
			flash[:alert] = "You can perform actions only on notes created by you"
			redirect_to '/'
		end
	end

end
