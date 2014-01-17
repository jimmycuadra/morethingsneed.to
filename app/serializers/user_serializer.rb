class UserSerializer < ActiveModel::Serializer
  attributes *%i{
    id
    username
  }
end
