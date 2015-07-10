class Post < ActiveRecord::Base
  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  has_attached_file :picture, :default_url => "/images/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
end
