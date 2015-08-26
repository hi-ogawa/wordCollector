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


  # username validations
  validates :username, uniqueness: true
  validates :username, presence: true
  validates :username, length: {minimum: 5, message: "must be longer than 4 characters"}
  validates :username, length: {maximum: 20, message: "must be shorter than 21 characters"}

  validate :username_must_have_only_numbers_or_letters
   # same as -> validates :username, format: { with: /\A[a-zA-Z0-9]+\z/, message: "...."}

  def username_must_have_only_numbers_or_letters
    unless username =~ /\A[a-zA-Z0-9]+\z/
      errors.add(:username, "must have only numbers or letters")
    end
  end

end
