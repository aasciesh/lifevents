class HomeController < ApplicationController
  def index
  	@event= Event.new
  	@events = Event.order('created_at DESC').limit(30).near("malmi helsinki", 30).all
  end
end
