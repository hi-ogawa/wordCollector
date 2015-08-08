class ItemSerializer < ActiveModel::Serializer
  attributes :id, :word, :sentence, :meaning, :picture
  has_one :category
end
