class EventsController < ApplicationController
  include ActionView::Helpers::DateHelper

   before_filter :find_event, only: [ :edit, :delete, :show]
   before_filter :authenticate, except: [:index, :show]

  def index
    @events= Event.All
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(params[:event])
    if @event.save
      username= @event.user.firstname.capitalize + " " + @event.user.lastname.capitalize
      liveItem = {    "event_id" => "#{@event.id}",
                      "username" => "#{username}", 
                      "avatar_url" => "#{@event.user.avatar.url(:thumb)}",
                      "eventTitle" =>  "#{@event.name}",
                      "details" =>  "#{@event.description}",
                      "postTime" =>  "#{time_ago_in_words(@event.created_at)}",
                      "address" => "#{@event.address}",
                      "latitude" =>  "#{@event.latitude}",
                      "longitude" =>  "#{@event.longitude}",
                      "urgency" =>  "#{@event.urgency}",
                      "category" => "#{@event.category}",
                      "comments_count" => "#{@event.comments.count}",
                      "joiners_count" => "#{@event.eventjoiners.count}"
                    }

      respond_to do |format|
        format.html { redirect_to @event }
        format.js { render json: {message: 'saved', event_data: liveItem.to_json} }
      end
      faye_transmit liveItem
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
  def authenticate
    unless signed_in?
      flash[:error_msg]= "Error"
      redirect_to root_path
    end
  end
end
