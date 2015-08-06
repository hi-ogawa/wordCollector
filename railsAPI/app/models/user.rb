class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :auth_token, uniqueness: true
  before_create :generate_authentication_token!

  has_many :categories, dependent: :destroy

  def generate_authentication_token!
    self.auth_token = loop do
      token = Devise.friendly_token
      break token unless User.exists?(auth_token: token)
    end
  end
end
