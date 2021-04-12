class Article < ApplicationRecord
  validates_presence_of :body, :title

  default_scope { order(created_at: :desc) }
end
