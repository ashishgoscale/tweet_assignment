class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #relationship
  has_many :auth_tokens, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :follows, dependent: :destroy

  #validations
  validates :password, confirmation: true

  #methods
  def generate_devise_token
  	loop do
  		token = SecureRandom.hex(12)
  		break token unless AuthToken.find_by device_token: token 
  	end
  end

  def follower
    self.follows.where(is_follow: 2)
  end

  def following
    self.follows.where(is_follow: 1)
  end
end
