class UserSerializer < ActiveModel::Serializer
  attributes *%i{
    username
  }
end
