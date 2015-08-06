class Category < ActiveRecord::Base
  validates :name, :user_id, presence: true
  validates :description, length: { minimum: 0, allow_nil: false, message: "can't be nil" }

  belongs_to :user
end
