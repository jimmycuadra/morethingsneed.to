class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes *%i{
    username
  }

  has_many :entries
  has_many :comments
end
