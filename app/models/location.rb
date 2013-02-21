class Location < ActiveRecord::Base
  attr_accessible :city, :country, :latitude, :longitude, :postcode, :state, :street
  belongs_to :event
  
end
