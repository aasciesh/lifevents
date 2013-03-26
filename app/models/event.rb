class Event < ActiveRecord::Base
      include Tire::Model::Search
      include Tire::Model::Callbacks
  attr_accessible :name, :description, :from_time,:post_date, :to_time, :latitude, :longitude, :address, :urgency, :category
  geocoded_by :address
  before_validation :geocode

  has_many :comments
  belongs_to :user
  has_many :taglists
  has_many :tags, through: :taglists
  has_many :eventjoins, foreign_key: "joinedevent_id"
  has_many :eventjoiners, through: :eventjoins, as: :joinedevent

  validates :name, presence: true, length: {maximum: 200}
  validates :description, presence: true, length: {minimum: 10}
  # validates :from_time, presence: true
  validates :address, presence: true
  validates :urgency, presence: true, urgency_type: true
  validates :category, presence: true, category_type: true

  before_save :linkify_tags
  after_save :assign_tags

  mapping do
    indexes :id, type: 'integer', index: 'not_analyzed'
    indexes :name, boost: 15, analyzer: 'snowball'
    indexes :description, boost: 10, analyzer: 'snowball'
    indexes :created_at, type: 'integer'
    indexes :location, type: 'geo_point', as: 'location'
    indexes :urgency_point
    indexes :event_creator, boost: 5, analyzer: 'snowball'
    indexes :comments_count, type: 'integer'
    indexes :eventjoiners_count, type: 'integer'
  end

  def self.search(params, location)
    latLon = [location.latitude,location.longitude].join(',') unless location.nil?
    
    tire.search(page: 1, per_page: 5) do
      query do
        boolean do
          must { string params[:query]} if params[:query].present?
        end
      end
      sort {by [{created_at: 'desc'}, {urgency_point: 'desc'}]}
       sort {by _geo_distance: {location: latLon, order: 'asc'}} unless location.nil?
      raise to_curl
    end
    
  end

  def to_indexed_json
      to_json(
              only: ['id', 'name', 'description', 'created_at'],
              methods: ['location', 'urgency_point', 'event_creator', 'comments_count', 'eventjoiners_count']
        )
  end

  def location
    [latitude, longitude].join(',')
  end

  def event_creator
    name = [user.firstname.capitalize, user.lastname.capitalize].join(' ')
  end

  def urgency_point
    urg = urgency
    case urg
    when 'normal'
      return 1
    when 'medium'
      return 2
    when 'high'
      return 3
    when 'critical'
      return 4
    else
      return 0
    end
  end

  def comments_count
    comments.count
  end

  def eventjoiners_count
    eventjoiners.count
  end

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
