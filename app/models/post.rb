class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy


  validates :title, presence: true
  validates :description, presence: true

  def truncate_post
    description.truncate_words(100, omission: '... (continued)')
  end
end
