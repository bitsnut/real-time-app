class User < ActiveRecord::Base

  # has_many :friendships
  # has_many :friends, through: :friendships, conditions: Proc.new { friendships: { state: 'accepted' } }
  # has_many :pending_friendships, class_name: "Friendships", foreign_key: :user_id, conditions: Proc.new { state: 'pending' }
  # has_many :pending_friends, through: :pending_friendships, source: :friend
  # has_many :requested_friendships, class_name: 'Friendships',
  #                                     foreign_key: :user_id,
  #                                     conditions: Proc.new { state: 'requested' }
  # has_many :requested_friends, through: :requested_friendships, source: :friend
  
  # has_many :blocked_friendships, class_name: 'Friendships',
  #                                     foreign_key: :user_id,
  #                                     conditions: Proc.new { state: 'blocked' }
  # has_many :blocked_friends, through: :blocked_friendships, source: :friend
  
  # has_many :accepted_friendships, class_name: 'Friendships',
  #                                     foreign_key: :user_id,
  #                                     conditions: Proc.new { state: 'accepted' }
  # has_many :accepted_friends, through: :accepted_friendships, source: :friend


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable
         #:recoverable, :confirmable

  validates :email, presence: true
  validates :email, uniqueness: { :case_sensitive => false, :allow_blank => false }, format: { :with => Devise.email_regexp }, :if => :email_changed?
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :password, presence: { length: { within: Devise.password_length } }, :on => :create
  validates :password, presence: true, :on => :update, :unless => lambda { |user| user.password.blank? }
  # validates :username, presence: true, on: :create
  # validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  # validates :current_password, presence: false

  # def full_name
  #   first_name + " " + last_name
  # end

  # def to_param
  #   username
  # end

  # def has_blocked?(other_user)
  #   blocked_friends.include?(other_user)
  # end    



end
