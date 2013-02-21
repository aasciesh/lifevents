class User < ActiveRecord::Base
  attr_accessible  :firstname, :lastname, :password, :password_confirmation, :email, :ip
  has_secure_password
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_many :comments
  has_many :events, dependent: :destroy

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :firstname, presence: true, length: {maximum: 50}
  validates :lastname, presence: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  validates :email, presence: true, format: {with: EMAIL_REGEX}, uniqueness: { case_sensitive: false } 
  
end
