class Item < ActiveRecord::Base
  # validation
  validates :word, :category_id, presence: true
  validates :sentence, length: { minimum: 0, allow_nil: false, message: "can't be nil" }
  validates :meaning, length: { minimum: 0, allow_nil: false, message: "can't be nil" }

  # association
  belongs_to :category

  # default value
  before_validation :default_values
  def default_values
    self.sentence ||= ""
    self.meaning ||= ""
  end

  # paperclip settings
  has_attached_file :picture, :default_url => "/images/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  # search by item_ids, category_id, 
  def self.search(params = {})
    items = params[:item_ids].present? ? Item.find(params[:item_ids]) : Item.all
    items = items.filter_by_category_id(params[:category_id]) if params[:category_id].present?
    items 
  end
  scope :filter_by_category_id, ->(category_id) { where(category_id: category_id) }
end
