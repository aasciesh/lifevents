class EventsController < ApplicationController

  def index
    @events= Event.All
  end

  def search
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    
  end

  def edit
  end

  def update
  end

  def delete
  end
end
