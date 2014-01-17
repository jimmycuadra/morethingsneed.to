class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes *%i{
    username
  }

  has_many :comments
  has_many :entries

  def comments
    object.comments.where(spam: false)
  end

  def entries
    object.entries.where(spam: false)
  end
end
