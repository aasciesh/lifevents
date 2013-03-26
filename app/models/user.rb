class User < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  attr_accessible  :firstname, :lastname, :password, :password_confirmation, :email, :avatar
  has_secure_password
  has_attached_file :avatar, :styles => { medium: "300x300>", thumb: "40x40>", tiny: "28x28" }
  has_many :comments
  has_many :events
  has_many :eventjoins, foreign_key: "eventjoiner_id"
  has_many :joinedevents, through: :eventjoins, as: :eventjoiner
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :firstname, presence: true, length: {maximum: 50}
  validates :lastname, presence: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  validates :email, presence: true, format: {with: EMAIL_REGEX}, uniqueness: { case_sensitive: false } 
  validates_attachment :avatar, :presence => true, content_type: {content_type: ["image/jpg", "image/jpeg", "image/png"]},
                        :size => { :in => 0..2048.kilobytes }
 
  before_save :create_cookie, :downcase_email, :capitalize
  
  mapping do 
    indexes :id, type: 'integer', index: 'not_analyzed'
    indexes :firstname, boost: 15, analysis: 'keyword'
    indexes :lastname, boost: 10, analysis: 'keyword'
    indexes :thumb_pic_url
    indexes :tiny_pic_url
  end

  

  def self.search(params)

    tire.search(page: params[:page]|| 1, per_page: 5) do
      query do
        boolean do
          must { string params[:query]+'*'} if params[:query].present?
        end
      end
      
    end
  end

  def to_indexed_json
     to_json(
      only: ['id', 'firstname', 'lastname'],
      methods: [:thumb_pic_url, :tiny_pic_url]
    )
  end

  def thumb_pic_url
    avatar.url(:thumb)
  end

  def tiny_pic_url
    avatar.url(:tiny)
  end

  private

  def create_cookie
      self.remember_cookie = SecureRandom.urlsafe_base64
  end

  def downcase_email
    self.email = self.email.downcase
  end
  def capitalize
    self.firstname=self.firstname.downcase.capitalize
    self.lastname=self.lastname.downcase.capitalize
  end
end
