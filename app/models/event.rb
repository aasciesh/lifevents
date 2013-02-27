class Event < ActiveRecord::Base
  attr_accessible :description, :from_time, :name, :post_date, :to_time, :urgency, 
  					:street, :postcode, :city, :state, :country
  geocoded_by :address

  has_many :comments
  belongs_to :user
  belongs_to :category
  has_many :tags, through: :taglist

  def address
  	[street, city, state, postcode, country].compact.join(', ')
  end
  
end
