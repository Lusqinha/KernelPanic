class Post < ApplicationRecord
  has_rich_text :content
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }
  belongs_to :user
end
