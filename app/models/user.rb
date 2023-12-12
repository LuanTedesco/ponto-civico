class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_many :likes
  has_one_attached :avatar
  has_many :notifications, dependent: :destroy

  enum role: { user: 'user', admin: 'admin', moderator: 'moderator' }

  validates :username, :email ,presence: true
end
