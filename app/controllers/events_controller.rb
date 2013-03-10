class EventsController < ApplicationController
   before_filter :find_event, only: [ :edit, :delete]

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
    @event.post_date= Time.now.to_datetime
    if @event.save
      respond_to do |format|
        format.html { redirect_to @event }
        format.js { render json: {message: 'saved', event_data: @event} }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js { render json: {message: 'not saved', event_errors: @event.errors} }
      end
    end
  end
    

  def edit
  end

  def update
    @event = Event.new(params[:event])
    if @event.save
      respond_to do |format|
        format.html { redirect_to @event}
      end
    else
      respond_to do |format|
        format.html { redirect_to @event}
      end
    end
  end

  def delete
  end

  private

  def find_event
    @event = Event.find_by_id(params[:id])
  end
end
