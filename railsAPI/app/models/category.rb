class Category < ActiveRecord::Base
  validates :name, :user_id, presence: true
  validates :description, length: { minimum: 0, allow_nil: false, message: "can't be nil" }

  belongs_to :user
  has_many :items, dependent: :destroy

  # search by category_ids, user_id, 
  def self.search(params = {})
    categories = params[:category_ids].present? ? Category.find(params[:category_ids]) : Category.all
    categories = categories.filter_by_user_id(params[:user_id]) if params[:user_id].present?
    categories
  end

  scope :filter_by_user_id, ->(user_id) { where(user_id: user_id) }
end
