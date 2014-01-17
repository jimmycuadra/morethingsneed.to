class CommentSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes *%i{
    name
    comment
    created_at
    updated_at
  }

  has_one :entry
  has_one :user
end
