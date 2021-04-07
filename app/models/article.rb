class Article < ApplicationRecord
  validates_presence_of :body, :title
end
