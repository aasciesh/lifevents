class User < ActiveRecord::Base
  attr_accessible  :firstname, :lastname, :password, :password_confirmation, :email, :ip, :avatar
  has_secure_password
  has_attached_file :avatar, :styles => { medium: "300x300>", thumb: "40x40>", tiny: "28x28" }
  has_many :comments
  has_many :events


  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :firstname, presence: true, length: {maximum: 50}
  validates :lastname, presence: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  validates :email, presence: true, format: {with: EMAIL_REGEX}, uniqueness: { case_sensitive: false } 
  
  before_save(on: :update) do
    @tempuser = User.find_by_id(self.id)
    self.firstname = @tempuser.firstname
    self.lastname = @tempuser.lastname
  end
  before_save :create_cookie


  private 

  def create_cookie
      self.remember_cookie = SecureRandom.urlsafe_base64
  end

end
