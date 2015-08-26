class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :created_at, :updated_at

  # explicitly define by myself
  attributes :category_ids
  def category_ids
    object.categories.map(&:id)
  end
end
