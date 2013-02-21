class Event < ActiveRecord::Base
  attr_accessible :description, :from_time, :name, :post_date, :priority_point, :to_time, :urgency
  has_one :location
  has_many :comments
  belongs_to :user
  belongs_to :category
  has_many :tags, through: :taglist
  
end
