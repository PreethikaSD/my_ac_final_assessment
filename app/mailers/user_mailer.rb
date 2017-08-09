class UserMailer < ApplicationMailer
	default from: 'pairbnbmail@gmail.com'

	def notify_email(user, type)
		@user = user
		@vote_type = type
		@url = 'https://my-assessment-camp.herokuapp.com'
		mail(to: @user.email, subject: "Your note has been voted") 
	end
end
