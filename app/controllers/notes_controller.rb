class NotesController < ApplicationController
	#before_action :authenticate_user!

	def index
		if user_signed_in?
			@notes = Note.all
		else
			@users = User.all
		end
	end
end
