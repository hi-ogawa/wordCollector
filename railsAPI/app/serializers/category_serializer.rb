class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :user_id
end
