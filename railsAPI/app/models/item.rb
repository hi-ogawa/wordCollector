class Item < ActiveRecord::Base
  validates :word, :category_id, presence: true
  validates :sentence, length: { minimum: 0, allow_nil: false, message: "can't be nil" }
  validates :meaning, length: { minimum: 0, allow_nil: false, message: "can't be nil" }

  belongs_to :category

  has_attached_file :picture, :default_url => "/images/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
end
