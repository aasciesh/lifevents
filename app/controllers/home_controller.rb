class HomeController < ApplicationController
  def index
  	@event= Event.new
  	@events = Event.near(user_location, 30, include: :user)
  end
end
