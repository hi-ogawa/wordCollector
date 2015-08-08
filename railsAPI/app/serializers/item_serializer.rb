class ItemSerializer < ActiveModel::Serializer
  attributes :id, :word, :sentence, :meaning, :picture, :created_at, :updated_at
  has_one :category
end
