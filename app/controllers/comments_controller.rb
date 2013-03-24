class CommentsController < ApplicationController
	before_filter :signed_in_user
	
	def create
	    @event = Event.find(params[:event_id])
	    @comment = @event.comments.build(params[:comment])
	    @comment.user_id = current_user.id
		@comment.save
	    redirect_to event_path(@event)
	end
end