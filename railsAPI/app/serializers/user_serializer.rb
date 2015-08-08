class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token, :created_at, :updated_at
  embed :ids
  has_many :categories
end
