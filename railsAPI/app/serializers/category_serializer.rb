class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at

  has_one :user

  # attributes :item_ids
  # def item_ids
  #   object.items.map(&:id)
  # end
end
