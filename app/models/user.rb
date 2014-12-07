class User < ActiveRecord::Base
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
  # validates :gender, presence: true, on: :create
  # validates :locale, presence: true, on: :create
  # validates :current_password, presence: false


end
