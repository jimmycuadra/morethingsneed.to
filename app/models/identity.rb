class Identity < ActiveRecord::Base
  validates :email, uniqueness: true, format: /\@/
end
