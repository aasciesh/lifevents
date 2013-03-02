class Event < ActiveRecord::Base
  attr_accessible :name, :description, :from_time, :to_time, :post_date, :latitude, :longitude, :address, :urgency, :category, :tag_names
  attr_accessor :tag_names
  geocoded_by :address

  has_many :comments
  belongs_to :user
  has_many :taglist, dependent: :destroy
  has_many :tags, through: :taglist

  validates :name, presence: true, length: {maximum: 200}
  validates :description, presence: true, length: {minimum: 10}
  validates :from_time, presence: true
  validates :post_date, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :address, presence: true
  validates :urgency, presence: true
  validates :category, presence: true

  after_save :assign_tags

  private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(",").map do |name|
        Tag.find_or_create_by_name(name)
      end
    end

  end

end
