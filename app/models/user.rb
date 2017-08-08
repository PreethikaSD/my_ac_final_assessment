class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :notes, dependent: :destroy
  has_many :followers, dependent: :destroy
  validates :email, :password , presence: true
  validates :email, uniqueness: true

	def count_follow
		self.followers.where(count: 1).count
	end

	def count_unfollow
		self.followers.where(count: 0).count
	end
       
end
