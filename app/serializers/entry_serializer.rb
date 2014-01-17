class EntrySerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes *%i{
    id
    body
    user_id
    created_at
    updated_at
    up_vote_count
    down_vote_count
  }

  has_many :comments
  has_one :user

  def body
    EntriesHelper.format_entry(object)
  end

  def comments
    object.comments.where(spam: false)
  end
end
