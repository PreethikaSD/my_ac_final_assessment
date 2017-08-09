class UserMailer < ApplicationMailer
	default from: 'pairbnbmail@gmail.com'

	def notify_email(user, type)
		@user = user
		@vote_type = type
		@url = 'http://localhost:3000'
		mail(to: @user.email, subject: "Your note has been voted") 
	end
end
