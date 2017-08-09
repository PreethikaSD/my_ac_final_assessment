class Note < ApplicationRecord
	belongs_to :user
	has_many :votes, dependent: :destroy

	def count_upvote
		self.votes.where(count: 1).count
	end

	def count_downvote
		self.votes.where(count: 0).count
	end

end
