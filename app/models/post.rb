class Post < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller && controller.current_user }

  acts_as_commentable

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
