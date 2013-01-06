class Identity < OmniAuth::Identity::Models::ActiveRecord
  attr_accessor :name

  validates :name, presence: true
  validates :email, uniqueness: true, format: /\@/
end
