class Post < ActiveRecord::Base
  acts_as_commentable

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
