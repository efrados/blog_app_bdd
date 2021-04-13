class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates_presence_of :body, :title

  default_scope { order(created_at: :desc) }
end
