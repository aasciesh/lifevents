class Event < ActiveRecord::Base
  attr_accessible :name, :description, :from_time,:post_date, :to_time, :latitude, :longitude, :address, :urgency, :category
  geocoded_by :address
  before_validation :geocode

  has_many :comments
  belongs_to :user
  has_many :taglist, dependent: :destroy
  has_many :tags, through: :taglist

  validates :name, presence: true, length: {maximum: 200}
  validates :description, presence: true, length: {minimum: 10}
  validates :from_time, presence: true
  validates :address, presence: true
  validates :urgency, presence: true, urgency_type: true
  validates :category, presence: true, category_type: true

  before_save :linkify_tags
  after_save :assign_tags

  private

  def tagsExtract=(tagslist)
    @tagsExtract = tagslist
  end
  def tagsExtract
    @tagsExtract
  end

  def linkify_tags
    self.tagsExtract = self.description.scan(/(?:^|\s):(\w+{2,})/i)
    tagsExtract.each do |name|
        tagtemp= name[0]
        self.description.gsub!(/(?:^|\s):#{tagtemp}/, " <a href='/events/#{tagtemp}' class='tagLink'>:#{tagtemp}</a>").lstrip!
    end
  end

  def assign_tags
    tagsExtract.each do |name|
      self.tags << Tag.find_or_create_by_name(name[0])
    end
  end

end
